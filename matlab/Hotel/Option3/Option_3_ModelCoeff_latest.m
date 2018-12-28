% clc
% clearvars
% close all


%% -------------Option 3------------------------
% GitHub notes: Zone 5: Plenum , Zone 4: Office, Zone 6: Basement


% Bottom floor
% BM = '{"a0": 2.4044729630041672, "a1": -0.0002191478093632764, "a2": -6.2118596081500949e-06, "a3": 7.7416095665507924e-06, "a4": 0.8715410422551233, "a5": 0.01499550774170183, "a6": -0.0046516930303288628, "a7": -0.0046908746307389726, "a8": -0.018652848299468838, "a9": 0.020691466983541074, "a10": -0.00071694340834355108, "a11": -0.013778357899599136, "a12": 0.01839483003388942, "a13": -3.7602536112671654e-25, "a14": 0.0}';
% BM = jsondecode(BM);
% B_f_1 = '{"a0": 1.0311558688588995, "a1": 0.00013769419876034418, "a2": -1.5880878763916029e-05, "a3": 5.0681746339836271e-05, "a4": 0.9241454755799926, "a5": 0.04959819306555175, "a6": 0.020703873353039966, "a7": -0.040150127555870364, "a8": -0.0041079210493033518, "a9": -2.7365107686622237e-28, "a10": 0.00010920290652541192}';
% B_f_1 = jsondecode(B_f_1);
% B_f_2 = '{"a0": 2.7093425216676117, "a1": 0.00016297956877834045, "a2": 3.3537471454810908e-05, "a3": 0.00010151094753677508, "a4": 0.99895465787525661, "a5": -0.0042200224495460396, "a6": 0.0054468741032255418, "a7": -0.13915232421037849, "a8": 0.0063898327251311173, "a9": -1.5032904812129505e-26, "a10": 0.0}';
% B_f_2 = jsondecode(B_f_2);
% B_f_3 = '{"a0": 0.64540322605009592, "a1": 0.0016827512745880922, "a2": 0.00029376478979743829, "a3": 3.7641328780348135e-05, "a4": 0.94743921427089783, "a5": 0.019290321952044245, "a6": 0.017966782930247348, "a7": -0.030207543644725544, "a8": 0.009053506625190149, "a9": -0.28896218836237675, "a10": 4.2811443046443676e-05}';
% B_f_3 = jsondecode(B_f_3);
% B_f_4 = '{"a0": 1.1134255422693506, "a1": 9.2178551126229991e-05, "a2": -2.261754777803634e-05, "a3": 4.0998944495260115e-05, "a4": 0.94223644822190133, "a5": 0.029873062028509371, "a6": 0.019977794232911784, "a7": -0.039189961381192906, "a8": -0.0065846925069239495, "a9": -3.9864308520457299e-27, "a10": 5.2674680154043774e-05}';
% B_f_4 = jsondecode(B_f_4);
% B_f_5 = '{"a0": 4.0843623180865478, "a1": 0.0016324557560956762, "a2": 0.00020414852698145879, "a3": 7.8552922782564732e-06, "a4": 0.85257624790757203, "a5": -0.017108807770412099, "a6": 0.14685232846813395, "a7": -0.003748474211524272, "a8": 0.019258000459835639, "a9": -0.0031943487252697467, "a10": -0.040673336494019496, "a11": -0.18518638444207236, "a12": 0.047079593809240705, "a13": -0.11220155341021917, "a14": 0.0}';
% B_f_5 = jsondecode(B_f_5);
% B_f_6 = '{"a0": 0.072728073620069722, "a1": 0.0028111281676170777, "a2": 0.00026602734076360479, "a3": 9.4199964311623371e-06, "a4": 0.96004481017849186, "a5": 0.006222434963404494, "a6": -0.099900603463167065, "a7": 0.026458080652291521, "a8": 0.1019946082542157, "a9": -0.12024975381870986, "a10": 1.2372945869170619e-05}';
% B_f_6 = jsondecode(B_f_6);
% B_f_7 = '{"a0": 0.40141318719877006, "a1": -0.00055309258083018292, "a2": -7.3716345910179358e-07, "a3": 3.8403912504701228e-07, "a4": 0.27165650625034027, "a5": -0.00034734598491596903, "a6": 0.0014289228878804402, "a7": 0.00084015309582180996, "a8": 0.70994212312956895, "a9": -0.0041135957769466661, "a10": 0.0}';
% B_f_7 = jsondecode(B_f_7);


BM=floor1_zone1_8_result;
B_f_1=floor1_zone1_1_result;
B_f_2=floor1_zone1_2_result;
B_f_3=floor1_zone1_3_result;
B_f_4=floor1_zone1_4_result;
B_f_5=floor1_zone1_5_result;
B_f_6=floor1_zone1_6_result;
B_f_7=floor1_zone1_7_result;





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
% T_f_1 = '{"a0": 4.1087989708569914, "a1": 0.00808764899778271, "a2": 3.6906949395773229e-05, "a3": 2.2954224358911197e-05, "a4": 0.83129876429956229, "a5": 0.035146071842301216, "a6": -0.017423944249955161, "a7": -0.67524635616433248, "a8": 3.0570762103728974e-05}';
% T_f_1 = jsondecode(T_f_1);
% T_f_2 = '{"a0": 0.35567874296171098, "a1": 0.0020182614318192816, "a2": 3.6664420527311873e-05, "a3": 2.2889318558490403e-06, "a4": 0.9704183065361548, "a5": 0.0015812670850303204, "a6": 0.0023503619586287485, "a7": 0.0034745887312328571, "a8": 0.0016199103536290024, "a9": -0.065999618666040691, "a10": 9.7683901093769652e-06}';
% T_f_2 = jsondecode(T_f_2);
% T_f_3 = '{"a0": 3.1498884046014872, "a1": 0.0071039994741656344, "a2": 2.453837310845244e-05, "a3": 1.9315415473708233e-05, "a4": 0.85600917646429286, "a5": 0.020376758056047883, "a6": 0.0051228025981758874, "a7": -0.013854195797919246, "a8": -0.32318397112971864, "a9": 1.9890420823843414e-05}';
% T_f_3 = jsondecode(T_f_3);
% T_f_4 = '{"a0": 1.1442250806905072, "a1": 0.0010140498151608118, "a2": 2.6193861060568605e-05, "a3": 9.0467519015869687e-06, "a4": 0.94501549135279084, "a5": 0.0061682000252416677, "a6": 0.0047684608574774471, "a7": -0.0048534655889048419, "a8": -0.13636537837086457, "a9": 1.2382167450608485e-05}';
% T_f_4 = jsondecode(T_f_4);

T_fg=floor3_zone6_result;
T_f_1=floor3_zone6_1_result;
T_f_2=floor3_zone6_2_result;
T_f_3=floor3_zone6_3_result;
T_f_4=floor3_zone6_4_result;


% X=[Basement,Bot_floor_zones,Mid_floor_guest,Mid_floor_corridor,Top_floor_guest,Top_floor_zones] total = 15 states

%U = [T_ref_i'; m_i';Prh_i'];
%D = [Tamb(i_sch);Sol_rad(i_sch);Qint(i_sch,:)';1];

A_bot=[BM.a4 BM.a5 BM.a6 BM.a7 BM.a8 BM.a9 BM.a10 BM.a11;... 
    B_f_1.a7 B_f_1.a4 0 0 B_f_1.a5 B_f_1.a6 0 0 ;...  % connection..(b,4,5)
    B_f_2.a7 0 B_f_2.a4 B_f_2.a5 0 B_f_2.a6 0 0 ;...  % (b,3,5)
    B_f_3.a7 0 B_f_3.a5 B_f_3.a4 0 B_f_3.a6 0 0 ;...  % (b,2,5)
    B_f_4.a7 B_f_4.a5 0 0 B_f_4.a4 B_f_4.a6 0 0 ;...  % (b,1,5)
    B_f_5.a11 B_f_5.a5 B_f_5.a6 B_f_5.a7 B_f_5.a8 B_f_5.a4 B_f_5.a9 B_f_5.a10;...  % (b,1,2,3,4,5,6,7)
    B_f_6.a7 0 0 0 0 B_f_6.a5 B_f_6.a4 B_f_6.a6;...  % (b,5,7)
    B_f_7.a7 0 0 0 0 B_f_7.a5 B_f_7.a6 B_f_7.a4];  % (b,5,6)

A_mid=[M_fg.a4 M_fg.a5 ;...
    M_fc.a5 M_fc.a4];


A_top=[T_fg.a4 0 0 0 0 ;...
    0 T_f_1.a4 T_f_1.a5 0 0 ;... %connection..2
    0 T_f_2.a5 T_f_2.a4 T_f_2.a6 T_f_2.a7 ;... %1,3,4
    0 0 T_f_3.a5 T_f_3.a4 T_f_3.a6 ;... %2,4
    0 0 T_f_4.a5 T_f_4.a6 T_f_4.a4]; %2,3



A=[A_bot zeros(8,7); zeros(2,8) A_mid zeros(2,5);zeros(5,10) A_top];

B=[BM.a12  zeros(1,14) BM.a13 zeros(1,14) BM.a14 zeros(1,14);... 
   0 B_f_1.a8 zeros(1,13) 0 B_f_1.a9 zeros(1,13) 0 B_f_1.a10 zeros(1,13);... 
   0 0 B_f_2.a8 zeros(1,12) 0 0 B_f_2.a9 zeros(1,12) 0 0 B_f_2.a10 zeros(1,12);...
   0 0 0 B_f_3.a8  zeros(1,11) 0 0 0 B_f_3.a9 zeros(1,11) 0 0 0 B_f_3.a10 zeros(1,11);...
   0 0 0 0 B_f_4.a8 zeros(1,10) 0 0 0 0 B_f_4.a9 zeros(1,10) 0 0 0 0 B_f_4.a10 zeros(1,10);...
   0 0 0 0 0 B_f_5.a12 zeros(1,9) 0 0 0 0 0 B_f_5.a13 zeros(1,9) 0 0 0 0 0 B_f_5.a14 zeros(1,9);...
   0 0 0 0 0 0 B_f_6.a8 zeros(1,8) 0 0 0 0 0 0 B_f_6.a9 zeros(1,8) 0 0 0 0 0 0 B_f_6.a10 zeros(1,8);...
   0 0 0 0 0 0 0 B_f_7.a8 zeros(1,7) 0 0 0 0 0 0 0 B_f_7.a9 zeros(1,7) 0 0 0 0 0 0 0 B_f_7.a10 zeros(1,7);...
   zeros(1,8) M_fg.a6 zeros(1,6) zeros(1,8) M_fg.a7 zeros(1,6) zeros(1,8) M_fg.a8 zeros(1,6);...
   zeros(1,9) M_fc.a6 zeros(1,5) zeros(1,9) M_fc.a7 zeros(1,5) zeros(1,9) M_fc.a8 zeros(1,5);...
   zeros(1,10) T_fg.a5 zeros(1,4) zeros(1,10) T_fg.a6 zeros(1,4) zeros(1,10) T_fg.a7 zeros(1,4);...
   zeros(1,11) T_f_1.a6 zeros(1,3) zeros(1,11) T_f_1.a7 zeros(1,3) zeros(1,11) T_f_1.a8 zeros(1,3);...
   zeros(1,12) T_f_2.a8 zeros(1,2) zeros(1,12) T_f_2.a9 zeros(1,2) zeros(1,12) T_f_2.a10 zeros(1,2);...
   zeros(1,13) T_f_3.a7 zeros(1,1) zeros(1,13) T_f_3.a8 zeros(1,1) zeros(1,13) T_f_3.a9 zeros(1,1);...
   zeros(1,14) T_f_4.a7 zeros(1,14) T_f_4.a8 zeros(1,14) T_f_4.a9];

E=[BM.a1 BM.a2 BM.a3 zeros(1,14) BM.a0;...
   B_f_1.a1 B_f_1.a2 0 B_f_1.a3 zeros(1,13) B_f_1.a0;...
   B_f_2.a1 B_f_2.a2 0 0 B_f_2.a3 zeros(1,12) B_f_2.a0;...
   B_f_3.a1 B_f_3.a2 0 0 0 B_f_3.a3 zeros(1,11) B_f_3.a0;...
   B_f_4.a1 B_f_4.a2 0 0 0 0 B_f_4.a3 zeros(1,10) B_f_4.a0;...
   B_f_5.a1 B_f_5.a2 0 0 0 0 0 B_f_5.a3 zeros(1,9) B_f_5.a0;...
   B_f_6.a1 B_f_6.a2 0 0 0 0 0 0 B_f_6.a3 zeros(1,8) B_f_6.a0;...
   B_f_7.a1 B_f_7.a2 0 0 0 0 0 0 0 B_f_7.a3 zeros(1,7) B_f_7.a0;...
   M_fg.a1 M_fg.a2 zeros(1,8) M_fg.a3 zeros(1,6) M_fg.a0;...
   M_fc.a1 M_fc.a2 zeros(1,9) M_fc.a3 zeros(1,5) M_fc.a0;...
   T_fg.a1 T_fg.a2 zeros(1,10) T_fg.a3 zeros(1,4) T_fg.a0;...
   T_f_1.a1 T_f_1.a2 zeros(1,11) T_f_1.a3 zeros(1,3) T_f_1.a0;...
   T_f_2.a1 T_f_2.a2 zeros(1,12) T_f_2.a3 zeros(1,2) T_f_2.a0;...
   T_f_3.a1 T_f_3.a2 zeros(1,13) T_f_3.a3 zeros(1,1) T_f_3.a0;...
   T_f_4.a1 T_f_4.a2 zeros(1,14) T_f_4.a3 T_f_4.a0];

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