% clc
% clearvars
% close all

%% -------------Option 1------------------------

% Bottom floor
% BM = '{"a0": 2.0792177436760255, "a1": -0.00047430641306795134, "a2": -2.9646824121238429e-05, "a3": 6.2867165604273216e-06, "a4": 0.88869265958711419, "a5": 0.014374390611501899, "a6": -0.0032856969337886955, "a7": 2.1946027786541796e-25, "a8": 0.0}';
% BM = jsondecode(BM);
% B_f = '{"a0": 1.8254504574988495, "a1": 0.00049077009553834662, "a2": 6.0987214848447095e-05, "a3": 1.8724250800427415e-06, "a4": 0.97654679636739172, "a5": -0.069775795224891066, "a6": 0.0059500701742311746, "a7": -0.0048730546355353023, "a8": -1.5401862434310272e-06}';
% B_f = jsondecode(B_f);

BM=floor1_zone18_result;
B_f=floor1_zone1_result;

% Middle floor

% M_fg = '{"a0": 0.91814219617605275, "a1": 0.0021262282411331425, "a2": 3.2119230703632269e-06, "a3": 4.4745032360888271e-06, "a4": 0.91353428820574922, "a5": -0.030380469657310297, "a6": 0.091636544332178868, "a7": -0.003569834879956298, "a8": 0.0}';
% M_fg = jsondecode(M_fg);
% M_fc = '{"a0": 0.85230868818175765, "a1": 0.0031606248375417516, "a2": -1.3811870115361195e-05, "a3": 4.1033477141806343e-06, "a4": 0.89349830474805469, "a5": 0.010706637801331463, "a6": 0.069725586364618231, "a7": -0.023514008038033118, "a8": 0.0}';
% M_fc = jsondecode(M_fc);

M_fg=floor2_zone2_result;
M_fc=floor2_zone17_result;



% Top floor


% T_fg = '{"a0": 0.46411514043849067, "a1": 0.0017201823207916925, "a2": 5.4103721036013765e-06, "a3": 4.7521091394248438e-06, "a4": 0.96123484838047557, "a5": 0.021111919358289502, "a6": -0.016398654063695599, "a7": 0.0}';
% T_fg = jsondecode(T_fg);
% T_pc = '{"a0": 0.92073193046578439, "a1": 0.0028924685249885639, "a2": 3.3151801424507244e-05, "a3": 1.6285192630815589e-06, "a4": 0.94920202001876841, "a5": 0.010570386482397647, "a6": -0.020309494107622787, "a7": 0.0}';
% T_pc = jsondecode(T_pc); 


T_fg=floor3_zone6_result;
T_pc=floor3_zone11_result;

% X=[Basement,Bot_floor,Mid_floor_guest,Mid_floor_corridor,Top_floor_guest,Top_floor_corridor] dimension is 6

%U = [T_ref_i'; m_i';Prh_i'];
%D = [Tamb(i_sch);Sol_rad(i_sch);Qint(i_sch,:)';1];

A = [BM.a4 BM.a5 zeros(1,4);...
    B_f.a5 B_f.a4 zeros(1,4);...
    0 0 M_fg.a4 M_fg.a5 zeros(1,2);...
    0 0 M_fc.a5 M_fc.a4 zeros(1,2);...
    zeros(1,4) T_fg.a4 0;zeros(1,4) 0 T_pc.a4];

B1=[BM.a6,B_f.a6,M_fg.a6,M_fc.a6,T_fg.a5,T_pc.a5];
B2=[BM.a7,B_f.a7,M_fg.a7,M_fc.a7,T_fg.a6,T_pc.a6];
B3=[BM.a8,B_f.a8,M_fg.a8,M_fc.a8,T_fg.a7,T_pc.a7];

B=[diag(B1) diag(B2) diag(B3)];

E=[BM.a1 BM.a2 BM.a3 zeros(1,5) BM.a0;...
    B_f.a1 B_f.a2 0 B_f.a3 zeros(1,4) B_f.a0;...
    M_fg.a1 M_fg.a2 0 0 M_fg.a3 zeros(1,3) M_fg.a0;...
    M_fc.a1 M_fc.a2 0 0 0 M_fc.a3 0 0 M_fc.a0;...
    T_fg.a1 T_fg.a2 zeros(1,4) T_fg.a3 0 T_fg.a0;...
    T_pc.a1 T_pc.a2 0 0 0 0 0 T_pc.a3 T_pc.a0];

% Sys.A=A;
% Sys.B=B;
% Sys.E=E;
%Xnew=A*X+B*U+E*D;

%% Chiller Coefficients
% Chiller='{"d2": -0.49327437664283713, "d0": 21288.868182780352, "d1": 1743.1164903882293}';
% Chiller = jsondecode(Chiller);

Chiller=chiller_result;
%% Boiler Coefficients
% Boiler = '{"e1": -2901.461255672652, "e0": 42423.740691249346, "e2": 1.3428240112817802}';
% Boiler = jsondecode(Boiler);
Boiler=boiler_result;
%% Fan Coefficients
% Fan_supply='{"c2": 131.42806173129756, "c1": -2197.1168438392087, "c0": 15381.812230221009}';
% Fan_supply = jsondecode(Fan_supply);

Fan_supply=fan1_result;