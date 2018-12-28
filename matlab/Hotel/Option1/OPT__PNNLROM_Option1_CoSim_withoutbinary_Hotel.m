
clearvars
clc
close all

load('fan.mat')
load('chiller.mat')
load('boiler.mat')
load('floor1.mat')
load('floor2.mat')
load('floor3.mat')

Flag_Plot = 1;
Flag_SingleRun = 1;
Flag_FC = 1;

if Flag_SingleRun
    X = 22*ones(6,1);   % '6' stands for the dimension of the state space model
    InitialStates.X = X;
    InitialStates.Pfc_f = 0;
    InitialStates.Pfc_h = 0;
    InitialStates.Eb = 2.5e5*3600*Flag_FC;
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
Zoneparam.Ts = f2c(55)*ones(6,1); % supply air temperature
Zoneparam.T_approx = 22*ones(6,1); % approximation for room temperature for complexity
COP = 6.285;%3.5; % chiller COP % changed based on Sen files
tau_ch = 200; % time constant of the chiller, second
tau_fc = 120*60; % time constant of the FC, second
eta_d = 0.9; % battery discharging efficiency
eta_c = 0.9; % battery charging efficiency
eta_fc_e = 0.5; % electrical efficiency of the FC
eta_fc_h = 0.35; % heat efficiecny of the FC
eta_boil = 0.8125;%0.9; % boiler efficiency  % chanaged based on the Sen files
T_approx = 22; % approximation for room temperature for complexity
kas = 1e-4; % coefficent to calculate temperature buffer from ancillary service

%% Operation constraints bounds
T_high = 26*ones(6,1); % temperature bounds
T_low = 20*ones(6,1);
Tref_high = 26*ones(6,1); % temperature set-points bounds
Tref_low = 18*ones(6,1);
Eb_max = 5e5*3600*Flag_FC; % battery energy capacity
Pfc_f_max = 1e6*Flag_FC; % FC fuel consumption capacity
Pfc_f_min = 0.2*Pfc_f_max*Flag_FC; % FC fuel consumption minimum operating point
Pb_max = 5e5*Flag_FC; % battery power capacity

m_min(1)= 0.81184;
m_max(1)= 1.62369;

m_min(2)= 0.19939+0.12029+2.45639+0.11254+5.09444e-002+0.65163+0.76339;
m_max(2)= 0.39879+ 0.24058+4.91277+0.22508+0.10189+3.25816+1.52677;

m_min(3)=0;
m_max(3)=0.88275+0.86971+4.40470+5.57902+0.79506+0.80446;

m_min(4)=0.38311;
m_max(4)=1.91553;

m_min(5)=0;
m_max(5)=0.25859+0.24952+1.05050;

m_min(6)=0.18780+1.57519+1.62522+1.43589;
m_max(6)=0.88596+2.25027+2.32175+2.05127;

m_min = [m_min(1);m_min(2);m_min(3);m_min(4);m_min(5);m_min(6)]; % supply air flow rate limits (eio file)
m_max =[m_max(1);m_max(2);6*m_max(3);6*m_max(4);m_max(5);m_max(6)];

FC_ramp_up = 0.25*Pfc_f_max*Flag_FC; % FC ramp rate limits
FC_ramp_down = 0.25*Pfc_f_max*Flag_FC;

%% Initial conditions for building and equipment status
X0 = InitialStates.X;
Pfc_f0 = InitialStates.Pfc_f;
Pfc_h0 = InitialStates.Pfc_h;
Eb0 = InitialStates.Eb;
Pf_total=zeros(1,1);
Pcc_total=zeros(1,1);
Ppre_total=zeros(1,1);
N_AHU =1;
alpha_oa=0.3;
%% Sen Coefficients
Option_1_ModelCoeff_latest   % populates zone thermal model matrices

Option1ModelTest

% X=[Basement,Bot_floor,Mid_floor_guest,Mid_floor_corridor,Top_floor_guest,Top_floor_corridor] dimension is 6

%load extvar_option1_hotel.mat   % loads disturbance data needed for the zone model

Tamb = Tout(tshift:60:(tshift-1)+(60*N_sch));
Sol_rad = Qsol(tshift:60:(tshift-1)+(60*N_sch))*1;
Qint = Qint_total(tshift:60:(tshift-1)+(60*N_sch),:)*1;

C_f = Fan_supply;

Tmix_vec = alpha_oa*Tamb + (1-alpha_oa)*Zoneparam.T_approx(1,1); % Assuming OA ratio and Tapprox are the same for all zones

tic

%% EDC optimization
cvx_begin

% Desicion variables:
% zone temperatue set-point, battery charge, battery discharge, supply
% air flow rate, FC fuel consumption set-point, FC heat output
% set-point, total reheat, AS capacity
variables u(N_sch,5) m_s(N_sch,6) Prh(N_sch,6) T_ref(N_sch,6)
% u =[Pb_in,Pb_out,Pfc_f_ref,Pfc_h_ref,Ras]
% m_s: Supply Mass flow rate from AHU

% State variables:
% zone temperature, battery SOC
variables x(N_sch,6,N_perhour) Eb(N_sch,1,N_perhour)  % Three dimensional vector (second column represents 'size')
%('6' includes zone(6))

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
            Pcc_i(n_f,1) = sum(m_s(i,:))*Zoneparam.Cp*(Tmix_i-Zoneparam.Ts(n_f,1));
        else
            Pcc_i(n_f,1) = 0;
        end
    end
     
    Pcc_total(i,1) = sum(Pcc_i); 
    
    Pcc_chiller = Chiller.d0+Chiller.d1*Tamb(i)+Chiller.d2*(Pcc_total(i,1));  % Regression equation for chiller
    
    Pch_i = Pcc_chiller; % chiller power

    
     Pf_total(i,1) = C_f.c0+C_f.c1*sum(m_s(i,:)) + C_f.c2*power(sum(m_s(i,:)),2);%m_s(i,n_f).^2;  % m_i is the supply air flow rate    
    %
    Pfc_e_i = u(i,3)*eta_fc_e; % FC elec output
    
    P_e_i = Pch_i + Pf_total(i,1) + u(i,1) - Pfc_e_i - u(i,2); % grid power
    
    J_e_i = c_e(i)*P_e_i;
    
    
    Ppre_total(i,1) = sum(Prh(i,:),2);
    
    Pcc_boiler(i,1)= Boiler.e0+Boiler.e1*Tamb(i)+Boiler.e2*(Ppre_total(i,1)-u(i,4));  % Regression equation for Boiler
    
    P_ng_i = u(i,3) + Pcc_boiler(i,1);
    J_gas_i = c_ng(i)*P_ng_i;
    % AS payment
    J_as_i = -c_as(i)*u(i,5);
    % Total cost
    J(i,1) = J_e_i + J_gas_i + J_as_i;
    
end

minimize ( sum(J) )

subject to

for i_sch = 1:N_sch  % (nS=24)
    
    
    T_ref_i = T_ref(i_sch,:);
    m_i = m_s(i_sch,:);
    Prh_i = Prh(i_sch,:);
    Pb_in_i = u(i_sch,1);
    Pb_out_i = u(i_sch,2);
    Pfc_f_ref_i = u(i_sch,3);
    Pfc_h_ref_i = u(i_sch,4);
    Ras_i = u(i_sch,5);
   
    
    if i_sch == 1
        Pfc_f_ref_iminus = Pfc_f0;
        Pfc_h_ref_iminus = Pfc_h0;
    else
        Pfc_f_ref_iminus = u((i_sch-1),3);
        Pfc_h_ref_iminus = u((i_sch-1),4);
    end
    
    % Limits
    0 <= Pfc_h_ref_i <= Pfc_f_ref_i*eta_fc_h;
    0 <= sum(Prh(i_sch,:))- Pfc_h_ref_i;
    0 <= Ras_i <= 0;
    m_min <= m_i' <= m_max;
    Pfc_f_min*1 <= Pfc_f_ref_i <= Pfc_f_max*1;
    -FC_ramp_down <= Pfc_f_ref_i - Pfc_f_ref_iminus <= FC_ramp_up;
    0 <= Pb_in_i <= Pb_max;
    0 <= Pb_out_i <= Pb_max;
    Tref_low <= T_ref_i' <= Tref_high;
    Prh >= 0;
    
    
    % States in faster time step
    
    for i_state = 1:N_perhour
        
        T_i = x(i_sch,:,i_state)';
        
        Eb_i = Eb(i_sch,1,i_state);
        
        if i_sch == 1 && i_state == 1
            X = X0;
            Eb_iminus = Eb0;
        elseif i_state == 1
            X = x(i_sch-1,:,N_perhour)';
            Eb_iminus = Eb(i_sch-1,1,N_perhour);
        else
            X = x(i_sch,:,i_state-1)';
            Eb_iminus = Eb(i_sch,1,i_state-1);
        end
        
        U = [T_ref_i'; m_i';Prh_i'];
        D = [Tamb(i_sch);Sol_rad(i_sch);Qint(i_sch,:)';1];
        
   
        Xnew=A*X+B*U+E*D; %  X=[Basement,Bot_floor,Mid_floor_guest,Mid_floor_corridor,Top_floor_guest,Top_floor_corridor] dimension is 6
        Eb_new = Eb_iminus + dt*eta_c*Pb_in_i - dt*1/eta_d*Pb_out_i;
        
        Xnew == T_i;
        Eb_new == Eb_i
        
        
        T_low + kas*Ras_i/3 <= [T_i(1);T_i(2);T_i(3);T_i(4);T_i(5);T_i(6)] <= T_high - kas*Ras_i/3;
        0 <= Eb_i <= Eb_max;
        
    end
    
    Xnew' == T_ref_i; % temperature reach set-point
    
    
end

Eb_new == Eb0; % final battery SOC

cvx_end

toc


%% Post process

if Flag_Plot
    
    tvec_sch = (0:N_sch)';
    tvec_state = (0:N_sch*N_perhour)'/N_perhour;
    
    % Temperature
    
    T_z_Bas = [];
    T_z_Bot = [];
    T_z_Mid_G = [];
    T_z_Mid_C = [];
    T_z_Top_G = [];
    T_z_Top_C = [];
    
    
    for i = 1:N_sch
        T_z_Bas = [T_z_Bas;reshape(x(i,1,:),[N_perhour,1])];
        T_z_Bot = [T_z_Bot;reshape(x(i,2,:),[N_perhour,1])];
        T_z_Mid_G = [T_z_Mid_G;reshape(x(i,3,:),[N_perhour,1])];
        T_z_Mid_C = [T_z_Mid_C;reshape(x(i,4,:),[N_perhour,1])];
        T_z_Top_G = [T_z_Top_G;reshape(x(i,5,:),[N_perhour,1])];
        T_z_Top_C = [T_z_Top_C;reshape(x(i,6,:),[N_perhour,1])];
        
    end
    
    figure(1)
    plot(tvec_state(2:end),T_z_Bas)
    hold on
    plot(tvec_state(2:end),T_z_Bot)
    hold on
    plot(tvec_state(2:end),T_z_Mid_G)
    hold on
    plot(tvec_state(2:end),T_z_Mid_C)
    hold on
    plot(tvec_state(2:end),T_z_Top_G)
    hold on
    plot(tvec_state(2:end),T_z_Top_C)
    legend('Bas','Bot','Mid_G','Mid_C','Top_G','Top_C')
    grid on
    
    
    figure(2)
    for i =1:6
        subplot(3,2,i)
        yyaxis left
        plot(tvec_sch(2:end),x(:,i))
%         hold on
%         plot(tvec_sch(2:end),10e3*c_e)
        hold on
        plot(tvec_sch(2:end),T_ref(:,i),'r')
        yyaxis right
        plot(tvec_sch(2:end),Tamb)
        ylabel('Ambient')
        legend('T','Tref','Ambient')
    end
    
    
    figure(3)
      for i =1:6
 
          subplot(3,2,i)
          yyaxis left
          plot(tvec_sch(1:end-1),m_s(:,i),'-*')
          hold on
          plot(tvec_sch(1:end-1),m_min(i)*ones(24,1),'-*r')
          hold on
          plot(tvec_sch(1:end-1),m_max(i)*ones(24,1),'-*b')
          ylabel('flow rate')
          yyaxis right
          plot(tvec_sch(1:end-1),Prh(:,i),'-*')
          ylabel('Reheat')
          legend('flow rate','min flow','max flow','reheat')
        
      end
    
    % FC
    Pb_in = u(:,1);
    Pb_out = u(:,2);
    Pfc_f_ref = u(:,3);
    Pfc_h_ref = u(:,4);
    Ras = u(:,5);
    
    Eb_vec = [];
    for i = 1:N_sch
        Eb_vec = [Eb_vec;reshape(Eb(i,1,:),[N_perhour,1])];
    end
    
    figure(4)
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
    
    figure(6)
    plot(tvec_sch(2:end),Pfc_f_ref)
    hold on
    plot(tvec_sch(2:end),Pfc_h_ref)
    plot(tvec_sch(2:end),sum(Prh,2))
    legend('Pfc f','Pfc h','P h')
    grid on
   
end



