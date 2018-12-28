
clearvars
clc
close all

load('fan.mat')
load('chiller.mat')
load('boiler.mat')
load('Bot_floor.mat')
load('Mid_floor.mat')
load('Top_floor.mat')


Flag_Plot = 1;
Flag_SingleRun = 1;
Flag_FC = 1;

if Flag_SingleRun
    X = 22*ones(7,1);   % '7' stands for the dimension of the state space model
    InitialStates.X = X;
    InitialStates.Pfc_f = 0;
    InitialStates.Pfc_h = 0;
    InitialStates.Eb = 2.5e5*3600*Flag_FC;
    InitialStates.Eth = 0;
    tshift = 24*10+1;
    Ndays = 1;
end

%% Simulation constants
dt = 1*60; % Time step for discrete thermal dynamics model, seconds
dt_h = 60*60; % Time step for scheduling period
N_sch = 24; % Number of scheduling period
N_state = 3600/dt*N_sch; % Number of thermal dynamics model steps
N_perhour = dt_h/dt; % Number of thermal dynamics model steps per hour

%% Prices
c_e_perday = 0.1*ones(N_sch,1)*1e-3; % electricity price
c_e_perday(N_sch*2/3:N_sch*5/6) = 0.2*1e-3;
c_e_120day = repmat(c_e_perday,365,1);
c_e = c_e_120day(1+tshift:N_sch+tshift);
c_ng_perday = 0.08*ones(N_sch,1)*1e-3; % natural gas price
c_ng_perday(1:N_sch/3) = 0.08*1e-3;
c_ng_perday(N_sch*5/6:end) = 0.08*1e-3;
c_ng_120day = repmat(c_ng_perday,365,1);
c_ng = c_ng_120day(1+tshift:N_sch+tshift);
c_as_perday = 0.03*ones(N_sch,1)*1e-3; % ancillary service price
c_as_120day = repmat(c_as_perday,365,1);
c_as = c_as_120day(1+tshift:N_sch+tshift);

%% Building constants
Zoneparam.Cp = 1e3; % specific heat of air
Zoneparam.Ts = f2c(55)*ones(4,1); % supply air temperature
Zoneparam.T_approx = 22*ones(4,1); % approximation for room temperature for complexity
COP = 6.285;%3.5; % chiller COP % changed based on Sen files
eta_d = 0.9; % battery discharging efficiency
eta_c = 0.9; % battery charging efficiency
eta_th_d = 0.9; % thermal storage discharging efficiency
eta_th_c = 0.9; % thermal storage charging efficiency
eta_th_loss = 0.05; % thermal storage static loss
eta_fc_e = 0.5; % electrical efficiency of the FC
eta_fc_h = 0.35; % heat efficiecny of the FC
eta_boil = 0.8125;%0.9; % boiler efficiency  % chanaged based on the Sen files
T_approx = 22; % approximation for room temperature for complexity
kas = 1e-4; % coefficent to calculate temperature buffer from ancillary service

%% Operational constraints bounds
T_high = 24*ones(4,1); % temperature bounds
T_low = 20*ones(4,1);
Tref_high = 26*ones(4,1); % temperature set-points bounds
Tref_low = 18*ones(4,1);
Eb_max = 5e5*3600*Flag_FC; % battery energy capacity
Eth_max = 5e5*3600*3; % thermal storage energy capacity
Pfc_f_max = 1e6*Flag_FC; % FC fuel consumption capacity
Pfc_f_min = 0.2*Pfc_f_max*Flag_FC*0; % FC fuel consumption minimum operating point
Pb_max = 5e5*Flag_FC; % battery power capacity
Pth_max = 5e5*1; % thermal storage power capacity
m_min = [0.85173;3.15099;21.82094;3.09008]; % supply air flow rate limits
m_max = [4.25864;12.27895;109.10469;11.38940]*100;
FC_ramp_up = 0.25*Pfc_f_max*Flag_FC; % FC ramp rate limits
FC_ramp_down = 0.25*Pfc_f_max*Flag_FC;
%% Initial conditions for building and equipment status
X0 = InitialStates.X;   % Initial temperature values
Pfc_f0 = InitialStates.Pfc_f;
Pfc_h0 = InitialStates.Pfc_h;
Eb0 = InitialStates.Eb;
Eth0 = InitialStates.Eth;
Pf_total=zeros(1,1);
Pcc_total=zeros(1,1);
Ppre_total=zeros(1,1);
N_AHU =4;
alpha_oa=0.3;
%% ZoneModel Coefficients & disturbance data

Option_1_ModelCoeff_latest   % populates zone thermal model matrices

%load extvar_option1.mat   % loads disturbance data needed for the zone model
Option1ModelTest

Tamb = Tout(tshift:60:(tshift-1)+(60*N_sch));
Sol_rad = Qsol(tshift:60:(tshift-1)+(60*N_sch))*1;
Qint = Qint_total(tshift:60:(tshift-1)+(60*N_sch),:)*1;

C_f = [Fan.c0;Fan.c1;Fan.c2];  % Fan coefficients

Tmix_vec = alpha_oa*Tamb + (1-alpha_oa)*Zoneparam.T_approx(1,1); % Assuming OA ratio and Tapprox are the same for all zones

tic

%% EDC optimization
cvx_begin

% Decision variables:
% zone temperatue set-point, battery charge, battery discharge, supply
% air flow rate, FC fuel consumption set-point, FC heat output
% set-point, total reheat, AS capacity
variables u(N_sch,7) m_s(N_sch,4) Prh(N_sch,4) T_ref(N_sch,4)
% u =[Pb_in,Pb_out,Pfc_f_ref,Pfc_h_ref,Ras,Pth_in,Pth_out]
% m_s: Supply Mass flow rate from AHU, '4' indicates there are 4 AHU's similarly for reheat (Prh) as well

% State variables:
% zone temperature, battery SOC
variables x(N_sch,7,N_perhour) Eb(N_sch,1,N_perhour) Eth(N_sch,1,N_perhour)  % Three dimensional vector (second column represents 'size')
%('7' includes zone(7))

expression Pcc_total(N_sch)
expression Ppre_total(N_sch)
expression Pf_total(N_sch)
expression Pcc_i(N_AHU)
expression J_i(N_sch)

% calculate cost
for i = 1:N_sch
    
    
    % Total cost incurred from various sources (electricity, natural gas, fuel cell, AS)
    % Electricity cost
    
    %% Chiller cost
    Tmix_i = Tmix_vec(i);
    for n_f = 1:N_AHU
        if Tmix_i >= Zoneparam.Ts(n_f)
            Pcc_i(n_f,1) = m_s(i,n_f)*Zoneparam.Cp*(Tmix_i-Zoneparam.Ts(n_f,1));
        else
            Pcc_i(n_f,1) = 0;
        end
    end
     
    Pcc_total(i,1) = sum(Pcc_i); 
    
    Pcc_chiller = Chiller.d0+Chiller.d1*Tamb(i)+Chiller.d2*(Pcc_total(i,1));  % Regression equation for chiller
    
    Pch_i = Pcc_chiller; % chiller power

    %%  Fan
     
     for n_f = 1:N_AHU
        if n_f ==1
            Pf_i(n_f,1) = C_f(1,n_f)+C_f(2,n_f)*m_s(i,n_f);
        else
         Pf_i(n_f,1) = C_f(1,n_f)+C_f(2,n_f)*m_s(i,n_f) + C_f(3,n_f)*power(m_s(i,n_f),2); %m_s(i,n_f).^2;  % m_i is the supply air flow rate 
        end
    end
    
    Pf_total(i,1) = sum(Pf_i);
    
    %
    Pfc_e_i = u(i,3)*eta_fc_e; % FC elec output
    
    P_e_i = Pch_i + Pf_total(i,1) + u(i,1) - Pfc_e_i - u(i,2); % grid power
    
    J_e_i = c_e(i)*P_e_i;
    

    Ppre_total(i,1) = sum(Prh(i,:),2);
    
    Pcc_boiler(i,1) = Boiler.e0+Boiler.e1*Tamb(i)+Boiler.e2*(Ppre_total(i,1)-u(i,4)+u(i,6)-u(i,7));  % Regression equation for Boiler
    
    
    P_ng_i = u(i,3) + Pcc_boiler(i,1);
    J_gas_i = c_ng(i)*P_ng_i;
    % AS payment
    J_as_i = -c_as(i)*u(i,5);
    % Total cost
    J(i,1) = J_e_i + J_gas_i + J_as_i;
    
end

minimize ( sum(J) )


subject to

for i_sch = 1:N_sch  
    
    
    T_ref_i = T_ref(i_sch,:);
    m_i = m_s(i_sch,:);
    Prh_i = Prh(i_sch,:);
    Pb_in_i = u(i_sch,1);
    Pb_out_i = u(i_sch,2);   
    Pfc_f_ref_i = u(i_sch,3);
    Pfc_h_ref_i = u(i_sch,4);
    Ras_i = u(i_sch,5);
    Pth_in_i = u(i_sch,6);
    Pth_out_i = u(i_sch,7);
    
    
    if i_sch == 1
        Pfc_f_ref_iminus = Pfc_f0;
        Pfc_h_ref_iminus = Pfc_h0;
    else
        Pfc_f_ref_iminus = u((i_sch-1),3);
        Pfc_h_ref_iminus = u((i_sch-1),4);
    end
    
    % Limits
    0 <= Pfc_h_ref_i <= Pfc_f_ref_i*eta_fc_h;
    0 <= sum(Prh(i_sch,:)) + Pth_in_i - Pth_out_i - Pfc_h_ref_i;
    0 <= Ras_i <= 0;
    m_min <= m_i' <= m_max;
    Pfc_f_min*1 <= Pfc_f_ref_i <= Pfc_f_max*1;
    -FC_ramp_down <= Pfc_f_ref_i - Pfc_f_ref_iminus <= FC_ramp_up;
    0 <= Pb_in_i <= Pb_max;
    0 <= Pb_out_i <= Pb_max;
    0 <= Pth_in_i <= Pth_max*1;
    0 <= Pth_out_i <= Pth_max*1;
    Tref_low <= T_ref_i' <= Tref_high;
    Prh >= 0;
    
    
    % States in faster time step
    
    for i_state = 1:N_perhour
        
        T_i = x(i_sch,:,i_state)';
        
        Eb_i = Eb(i_sch,1,i_state);
        Eth_i = Eth(i_sch,1,i_state);
        
        if i_sch == 1 && i_state == 1
            X = X0;
            Eb_iminus = Eb0;
            Eth_iminus = Eth0;
        elseif i_state == 1
            X = x(i_sch-1,:,N_perhour)';
            Eb_iminus = Eb(i_sch-1,1,N_perhour);
            Eth_iminus = Eth(i_sch-1,1,N_perhour);
        else
            X = x(i_sch,:,i_state-1)';
            Eb_iminus = Eb(i_sch,1,i_state-1);
            Eth_iminus = Eth(i_sch,1,i_state-1);
        end
        
        U = [T_ref_i'; m_i';Prh_i'];
        D = [Tamb(i_sch);Sol_rad(i_sch);Qint(i_sch,:)';1];
        
   
        Xnew=A*X+B*U+E*D; % X=[Basement,Bot_floor,Bot_plenum,Mid_floor,Mid_plenum,Top_floor,Top_plenum]
        Eb_new = Eb_iminus + dt*eta_c*Pb_in_i - dt*1/eta_d*Pb_out_i;
        Eth_new = Eth_iminus + dt*eta_th_c*Pth_in_i - dt*1/eta_th_d*Pth_out_i;
        
        Xnew == T_i;
        Eb_new == Eb_i;
        Eth_new == Eth_i;
        
        
        T_low + kas*Ras_i/3 <= [T_i(1);T_i(2);T_i(4);T_i(6)] <= T_high - kas*Ras_i/3;
        0 <= Eb_i <= Eb_max;
        -Eth_max <= Eth_i <= Eth_max;
        
    end
    
    [Xnew(1);Xnew(2:2:7)]' == T_ref_i; % temperature reach set-point
    
end

Eb_new == Eb0; % final battery SOC.
Eth_new == Eth0;

cvx_end

toc


%% Post process

if Flag_Plot
    
    tvec_sch = (0:N_sch)';
    tvec_state = (0:N_sch*N_perhour)'/N_perhour;
    
    % Temperature
    
    T_z_Bas = [];
    T_z_Bot = [];
    T_z_Mid = [];
    T_z_Top = [];
    
    T_z_PleBot = [];
    T_z_PleMid = [];
    T_z_PleTop = [];
    
  
    
    for i = 1:N_sch
        T_z_Bas = [T_z_Bas;reshape(x(i,1,:),[N_perhour,1])];
        T_z_Bot = [T_z_Bot;reshape(x(i,2,:),[N_perhour,1])];
        T_z_Mid = [T_z_Mid;reshape(x(i,4,:),[N_perhour,1])];
        T_z_Top = [T_z_Top;reshape(x(i,6,:),[N_perhour,1])];
        
        T_z_PleBot = [T_z_PleBot;reshape(x(i,3,:),[N_perhour,1])];
        T_z_PleMid = [T_z_PleMid;reshape(x(i,5,:),[N_perhour,1])];
        T_z_PleTop = [T_z_PleTop;reshape(x(i,7,:),[N_perhour,1])];
        
    end
    
    figure
    plot(tvec_state(2:end),T_z_Bas)
    hold on
    plot(tvec_state(2:end),T_z_Bot)
    hold on
    plot(tvec_state(2:end),T_z_Mid)
    hold on
    plot(tvec_state(2:end),T_z_Top)
    legend('Bas','Bot','Mid','Top')
    grid on
    
    figure
    plot(tvec_state(2:end),T_z_PleBot)
    hold on
    plot(tvec_state(2:end),T_z_PleMid)
    hold on
    plot(tvec_state(2:end),T_z_PleTop)
    legend('Ple Bot','Ple Mid','Ple Top')
    grid on
   
    
    T_ref_Bas = T_ref(:,1);
    T_ref_Bot = T_ref(:,2);
    T_ref_Mid = T_ref(:,3);
    T_ref_Top = T_ref(:,4);
    
    figure
    subplot(2,2,1)
    yyaxis left
    plot(tvec_sch(2:end),x(:,1))
    hold on
    plot(tvec_sch(2:end),T_ref_Bas)
    yyaxis right
    plot(tvec_sch(2:end),Tamb)
    ylabel('Ambient temperature')
    legend('T base','Tref base','Ambient')
    subplot(2,2,2)
    yyaxis left
    plot(tvec_sch(2:end),x(:,2))
    hold on
    plot(tvec_sch(2:end),T_ref_Bot)
    yyaxis right
    plot(tvec_sch(2:end),Tamb)
   legend('T bot','Tref bot','Ambient')
    subplot(2,2,3)
    yyaxis left
    plot(tvec_sch(2:end),x(:,4))
    hold on
    plot(tvec_sch(2:end),T_ref_Mid)
    yyaxis right
    plot(tvec_sch(2:end),Tamb)
    legend('T mid','Trefmid','Ambient')
    subplot(2,2,4)
    yyaxis left
    plot(tvec_sch(2:end),x(:,6))
    hold on
    plot(tvec_sch(2:end),T_ref_Top)
    yyaxis right
    plot(tvec_sch(2:end),Tamb)
    legend('T top','Tref top','Ambient')
    grid on
    
    
    % HVAC
    m_Base = m_s(:,1); Prh_Base = Prh(:,1);
    m_Bot = m_s(:,2); Prh_Bot = Prh(:,2);
    m_Mid = m_s(:,3); Prh_Mid = Prh(:,3);
    m_Top = m_s(:,4); Prh_Top = Prh(:,4);
     

    figure
    subplot(2,2,1)
    yyaxis left
    plot(tvec_sch(2:end),m_Base)
    hold on
    plot(tvec_sch(2:end),m_min(1)*ones(24,1),'--r')
    hold on
    plot(tvec_sch(2:end),m_max(1)*ones(24,1),'--b')
    ylabel('flow rate base')
    yyaxis right
    plot(tvec_sch(2:end),Prh_Base)
    ylabel('Reheat base')
    legend('m base')
    subplot(2,2,2)
    yyaxis left
    plot(tvec_sch(2:end),m_Bot)
    hold on
    plot(tvec_sch(2:end),m_min(2)*ones(24,1),'--r')
    hold on
    plot(tvec_sch(2:end),m_max(2)*ones(24,1),'--b')
    ylabel('flow rate bot')
    yyaxis right
    plot(tvec_sch(2:end),Prh_Bot)
    legend('m bot')
    ylabel('Reheat bot')
    subplot(2,2,3)
    yyaxis left
    plot(tvec_sch(2:end),m_Mid)
    hold on
    plot(tvec_sch(2:end),m_min(3)*ones(24,1),'--r')
    hold on
    plot(tvec_sch(2:end),m_max(3)*ones(24,1),'--b')
    ylabel('flow rate mid')
    yyaxis right
    plot(tvec_sch(2:end),Prh_Mid)
    legend('m mid')
    ylabel('Reheat mid')
    subplot(2,2,4)
    yyaxis left
    plot(tvec_sch(2:end),m_Top)
    hold on
    plot(tvec_sch(2:end),m_min(4)*ones(24,1),'--r')
    hold on
    plot(tvec_sch(2:end),m_max(4)*ones(24,1),'--b')
    ylabel('flow rate top')
    yyaxis right
    plot(tvec_sch(2:end),Prh_Top)
    legend('m top')
    ylabel('Reheat top')
    grid on
    
  
    
    % FC
    Pb_in = u(:,1);
    Pb_out = u(:,2);
    Pfc_f_ref = u(:,3);
    Pfc_h_ref = u(:,4);
    Ras = u(:,5);
    Pth_in = u(:,6);
    Pth_out = u(:,7);
    
    Eb_vec = [];
    for i = 1:N_sch
        Eb_vec = [Eb_vec;reshape(Eb(i,1,:),[N_perhour,1])];
    end
    Eth_vec = [];
    for i = 1:N_sch
        Eth_vec = [Eth_vec;reshape(Eth(i,1,:),[N_perhour,1])];
    end
    
    figure
    subplot(2,1,1)
    plot(tvec_sch(2:end),Pb_in)
    hold on 
    plot(tvec_sch(2:end),Pb_out)
    legend('Pb in','Pb out')
    grid on
    subplot(2,1,2)
    plot(tvec_state(2:end),Eb_vec)
    legend('Eb')
    grid on
    
    figure
    subplot(2,1,1)
    plot(tvec_sch(2:end),Pth_in)
    hold on 
    plot(tvec_sch(2:end),Pth_out)
    legend('Pth in','Pth out')
    grid on
    subplot(2,1,2)
    plot(tvec_state(2:end),Eth_vec)
    legend('Eth')
    grid on
    
    figure
    plot(tvec_sch(2:end),Pfc_f_ref)
    hold on
    plot(tvec_sch(2:end),Pfc_h_ref)
    hold on
    plot(tvec_sch(2:end),sum(Prh,2))
    legend('Pfc f','Pfc h','P rh')
    grid on
   
end



