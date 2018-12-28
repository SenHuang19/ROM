% clc
% clearvars
% close all

%% -------------Option 1------------------------

% % Bottom floor
% BM ='{"a0": 0.28813047288147686, "a1": -0.00024273048264840028, "a2": 3.0705897322106019e-06, "a3": 2.2733416701509459e-07, "a4": 0.98091681220522464, "a5": 0.0065101088869177438, "a6": 0.00017634120968515208, "a7": -0.0044130609173927112, "a8": 3.9364538786128115e-06}';
% BM = jsondecode(BM);
% B_f = '{"a0": 0.77275704324198813, "a1": 0.0009072679550223068, "a2": 5.0543220586740375e-05, "a3": 1.0065851479890179e-06, "a4": 0.94464959478345334, "a5": 0.050449087162393713, "a6": 0.00022132233718111409, "a7": -0.027665746195947798, "a8": -0.015107526435485923, "a9": 2.1705426340023603e-06}';
% B_f = jsondecode(B_f);
% B_p = '{"a0": -0.043098241852099761, "a1": 0.00035495576251634098, "a2": -1.3535771803946579e-06, "a3": 0.96859425749252048, "a4": 0.033244123531203894, "a5": 0.0002124507402766967}';
% B_p = jsondecode(B_p);
% % Middle floor
% 
% M_f = '{"a0": 0.76656043325014878, "a1": 0.0010492386272869566, "a2": 7.114185903399471e-05, "a3": 1.4317666765507648e-06, "a4": 0.88217968153707971, "a5": 0.052559312432209106, "a6": 0.032213002426015797, "a7": -0.0017921655975265667, "a8": 2.2483510859462397e-07}';
% M_f = jsondecode(M_f);
% M_p = '{"a0": -0.18883719378035835, "a1": 8.7230808411263932e-05, "a2": 5.5423976541743368e-07, "a3": 0.98824627853420366, "a4": 0.019343557351242404, "a5": 0.00012640697808024781}';
% M_p = jsondecode(M_p);
% % Top floor
% 
% 
% T_f = '{"a0": 0.71302620142818895, "a1": 0.00025995544066208085, "a2": 1.2063022688213172e-05, "a3": 3.3846831040303685e-07, "a4": 0.88928557240386719, "a5": 0.0059637773658612857, "a6": 0.073182997022833235, "a7": 0.0021522507344294028, "a8": 3.7355107419410934e-07}';
% T_f = jsondecode(T_f);
% T_p = '{"a0": 0.016372591228073219, "a1": 0.0024946665007345194, "a2": 6.2924833463403351e-05, "a3": 0.97097875103059372, "a4": 0.027087647455673051, "a5": -0.007274810526614009}';
% T_p = jsondecode(T_p);

BM=Bot_floor_zone6_result;
B_f=Bot_floor_zone4_result;
B_p=Bot_floor_zone5_result;
M_f=Mid_floor_zone4_result;
M_p=Mid_floor_zone5_result;
T_f=Top_floor_zone4_result;
T_p=Top_floor_zone5_result;

% X=[Basement,Bot_floor,Bot_plenum,Mid_floor,Mid_plenum,Top_floor,Top_plenum]

%U = [T_ref_i'; m_i';Prh_i'];
%D = [Tamb(i_sch);Sol_rad(i_sch);Qint(i_sch,:)';1];

A = [BM.a4 BM.a5 zeros(1,5);...
    B_f.a6 B_f.a4 B_f.a5 zeros(1,4);... %B_f.a5 B_f.a4 B_f.a6 zeros(1,4);...
    0 B_p.a4 B_p.a3 zeros(1,4);...
    zeros(4,3), [M_f.a4 M_f.a5 0 0;M_p.a4 M_p.a3 0 0;0 0 T_f.a4 T_f.a5;0 0 T_p.a4 T_p.a3]];

B=[BM.a6 zeros(1,3) BM.a7 zeros(1,3) BM.a8 zeros(1,3);...
    0 B_f.a7 0 0 0 B_f.a8 0 0 0 B_f.a9 0 0;...
    zeros(1,5) B_p.a5 zeros(1,6);...
    0 0 M_f.a6 0 0 0 M_f.a7 0 0 0 M_f.a8 0;...
    zeros(1,6) M_p.a5 zeros(1,5);...
    zeros(1,3) T_f.a6 zeros(1,3) T_f.a7 zeros(1,3) T_f.a8;...
    zeros(1,7) T_p.a5 zeros(1,4)];

E=[BM.a1 BM.a2 BM.a3 zeros(1,3) BM.a0;...
    B_f.a1 B_f.a2 0 B_f.a3 0 0 B_f.a0;...
    B_p.a1 B_p.a2 zeros(1,4) B_p.a0;...
    M_f.a1 M_f.a2 0 0 M_f.a3 0 M_f.a0;...
    M_p.a1 M_p.a2 zeros(1,4) M_p.a0;...
    T_f.a1 T_f.a2 0 0 0 T_f.a3 T_f.a0;...
    T_p.a1 T_p.a2 zeros(1,4) T_p.a0];


%Xnew=A*X+B*U+E*D;

%% Chiller Coefficients
% Chiller='{"d2": 0.021064377886322604, "d0": 31831.133045203038, "d1": 1669.3381694021118}';
% Chiller = jsondecode(Chiller);
Chiller=chiller_result;
%% Boiler Coefficients
% Boiler = '{"e1": -7427.858331724743, "e0": 87326.430571052188, "e2": 1.2194084496701703}';
% Boiler = jsondecode(Boiler);
Boiler=boiler_result;
%% Fan Coefficients

% Fan_basement= '{"c2": -2.8299603300043187e-07, "c1": 1426.8404675121399, "c0": -3.4106051316484809e-08}';
% Fan_base= jsondecode(Fan_basement);
% Fan_bot='{"c2": 84.480355951858115, "c1": 471.14579801443278, "c0": -500.86675472088518}';
% Fan_bot = jsondecode(Fan_bot);
% Fan_mid='{"c2": 10.318117204413147, "c1": 397.49369172728188, "c0": -2306.8985871172627}';
% Fan_mid = jsondecode(Fan_mid);
% Fan_top='{"c2": 188.45849258878928, "c1": -645.32297405719748, "c0": 2583.7729155549769}';
% Fan_top = jsondecode(Fan_top);

Fan_base=fan4_result;
Fan_bot=fan1_result;
Fan_mid=fan2_result;
Fan_top=fan3_result;
Fan=[Fan_base,Fan_bot,Fan_mid,Fan_top];