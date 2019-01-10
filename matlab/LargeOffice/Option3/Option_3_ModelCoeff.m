% clc
% clearvars
% close all


%% -------------Option 3------------------------
% GitHub notes: Zone 5: Plenum , Zone 4: Office, Zone 6: Basement


% Bottom floor
BM = '{"a0": 0.31549895519453131, "a1": -8.3912666672497554e-05, "a2": 2.1291630191183905e-05, "a3": 2.7797361723530764e-07, "a4": 0.98356367432778824, "a5": -0.035046016157242468, "a6": 0.00069060485481238227, "a7": -0.014187815143325953, "a8": 0.0022514274485005638, "a9": 0.049144183455748176, "a10": -0.0037377211006383178, "a11": 4.8642733809869744e-06}';
BM = jsondecode(BM);
B_f_1 = '{"a0": 0.63050562434845148, "a1": 0.0006421596133482499, "a2": 8.469431276538244e-05, "a3": 2.7669339673676714e-06, "a4": 0.93879394093024138, "a5": -0.023857203933665805, "a6": -0.0059033599901576056, "a7": -0.0017978371382707517, "a8": 0.01036930736829389, "a9": 0.00086881062672145015, "a10": 0.054133450030179803, "a11": -0.021678268578781051, "a12": 3.1341652642069562e-06}';
B_f_1 = jsondecode(B_f_1);
B_f_2 = '{"a0": 0.58285660616909851, "a1": 0.00031559999087026183, "a2": -2.501270843226829e-06, "a3": 1.2973484918160367e-06, "a4": 0.96447317238635966, "a5": 0.00047334070359567049, "a6": -0.054211480034738857, "a7": 0.0037657503377820922, "a8": -0.0070670484691207069, "a9": 0.0031613910169414616, "a10": 0.062029591965929359, "a11": 0.13476063339939262, "a12": 3.0834399389334521e-07}';
B_f_2 = jsondecode(B_f_2);
B_f_3 = '{"a0": 0.68697482443440094, "a1": 0.0011904675448229929, "a2": -2.4936064530432348e-06, "a3": 3.1459401937826079e-06, "a4": 0.82863045812601577, "a5": -0.0036141708520645022, "a6": -0.0015747106441381664, "a7": 0.0031632239723961009, "a8": 0.0016064105391156436, "a9": 0.0032847702357290398, "a10": 0.13906118598184242, "a11": -0.051313037467203296, "a12": 3.373966704522946e-06}';
B_f_3 = jsondecode(B_f_3);
B_f_4 = '{"a0": 0.51675542219897252, "a1": 0.00049699365560408354, "a2": 1.7323041629125697e-05, "a3": 3.5474860722604963e-06, "a4": 0.97642560728352634, "a5": -0.0053935906514372351, "a6": -0.022839546612472252, "a7": -0.0075594170557033982, "a8": -0.0021461046372074407, "a9": 0.039776330131805079, "a10": -0.012038867687452248, "a11": -5.6972024784633678e-07}';
B_f_4 = jsondecode(B_f_4);
B_f_5 = '{"a0": 0.78734076476430204, "a1": -0.0003224304171485495, "a2": 9.4019202477141352e-06, "a3": 1.3727144466556718e-06, "a4": 0.91786647870056681, "a5": -0.018203760587687356, "a6": 0.0036929075586171756, "a7": 0.015004726119480505, "a8": -0.006031371356989626, "a9": 0.04071363033650155, "a10": 0.0089798351707509605, "a11": 0.0062048885173677376, "a12": -0.018525687118097434, "a13": 2.5995221911156996e-06}';
B_f_5 = jsondecode(B_f_5);
B_p = '{"a0": -0.049699355616578345, "a1": 0.00027766928631171026, "a2": -2.0510428051003468e-06, "a3": 0.96886201463396882, "a4": 0.0066877755831353308, "a5": -0.000775172018373373, "a6": -0.0058531139713085285, "a7": 0.0090119345671199266, "a8": 0.024224932446319, "a9": -0.0003473513988485484}';
B_p = jsondecode(B_p);

% Middle floor

M_f_1 = '{"a0": 0.61222572306212442, "a1": 2.637071069694871e-05, "a2": 5.5763008437556475e-05, "a3": 3.6083911362593624e-08, "a4": 0.92342287894760677, "a5": 0.013545429955291326, "a6": 0.035989846975982988, "a7": -0.0057224365472732189, "a8": 0.0017912784958995886, "a9": 0.0048801604781241086, "a10": -0.00058126844786516045, "a11": 7.6039629750312219e-09}';
M_f_1 = jsondecode(M_f_1);
M_f_2 = '{"a0": 0.53607530676491422, "a1": 7.3794496799620666e-05, "a2": -9.7406054876406645e-07, "a3": 1.8815172586935006e-06, "a4": 0.96530786131696, "a5": -0.0010177638422494307, "a6": -0.71676808389133173, "a7": -0.0079316700674841624, "a8": 0.0022800411290401007, "a9": 0.73218557970321108, "a10": 0.015623147802969282, "a11": -9.6589382474678827e-09}';
M_f_2 = jsondecode(M_f_2);
M_f_3 = '{"a0": 0.61164023937018897, "a1": 0.00014520420201666133, "a2": -3.3906578213562957e-06, "a3": 5.6304247263084786e-07, "a4": -0.18781858900482981, "a5": 0.020629476849624753, "a6": 0.020650896278054907, "a7": -0.0036845268822039219, "a8": 0.0015610114085190983, "a9": 1.1225357273644758, "a10": 0.00033845574975736794, "a11": -1.9519257543049892e-08}';
M_f_3 = jsondecode(M_f_3);
M_f_4 = '{"a0": 0.54960080996629301, "a1": 5.1321799247914622e-05, "a2": 1.8177765329753486e-05, "a3": 1.2200111899583111e-07, "a4": 0.97854545701311224, "a5": -0.025174751385281587, "a6": -0.69128541662605913, "a7": -0.0076323908768669664, "a8": 0.002399644082334485, "a9": 0.7180312453439095, "a10": 0.0083683047902127078, "a11": -6.8938670022660395e-08}';
M_f_4 = jsondecode(M_f_4);
M_f_5 = '{"a0": 0.73390484375183007, "a1": -0.00042171700229876518, "a2": 3.2531783031673705e-06, "a3": 1.4180231754105269e-06, "a4": 0.9367375837001215, "a5": -0.010373558695422593, "a6": 0.012190311067244913, "a7": -0.9055569901196846, "a8": 0.010678018221733088, "a9": 0.029078597407914006, "a10": 0.89682182606235883, "a11": -0.0017251378957760799, "a12": 4.3159914897561436e-07}';
M_f_5 = jsondecode(M_f_5);
M_p = '{"a0": -0.19258812220989086, "a1": 9.7784178561824328e-05, "a2": 6.2768819864848978e-08, "a3": 0.98823805711132895, "a4": 0.0044226837876029049, "a5": 0.00087910310277599171, "a6": -0.0010586164586036863, "a7": 0.0060879072453632515, "a8": 0.0091343135239194493, "a9": 0.00016320511282189192}';
M_p = jsondecode(M_p);

% Top floor

T_f_1 = '{"a0": 0.70678775019919726, "a1": 0.00071720119275339484, "a2": 3.8124498568144183e-05, "a3": 1.0100990504865906e-06, "a4": 0.94952504234503365, "a5": -0.042916035303793933, "a6": 0.031917310046524962, "a7": -0.026063924545570404, "a8": -0.0048270613022784407, "a9": 0.061405140446710242, "a10": 0.0011279956826318002, "a11": 4.1733367919572994e-07}';
T_f_1 = jsondecode(T_f_1);
T_f_2 = '{"a0": 0.60089892821244106, "a1": 0.00019995988753485782, "a2": -6.0235171384632467e-06, "a3": 1.1492603561577969e-06, "a4": 0.84122901897350788, "a5": 0.0095621068796160266, "a6": -0.97628168257971837, "a7": -0.0093830483690813902, "a8": -0.0003713822140917238, "a9": 1.10844539928283, "a10": 0.057035375437445947, "a11": -3.1873729166191451e-07}';
T_f_2 = jsondecode(T_f_2);
T_f_3 = '{"a0": 0.61748143108866671, "a1": 2.6898012526037308e-05, "a2": -3.2769205680984985e-06, "a3": 6.0954936367742357e-07, "a4": -0.27665995570624352, "a5": 0.019543054194205871, "a6": 0.014676985056741223, "a7": -0.0061258576181101292, "a8": 0.0017173196152596272, "a9": 1.2205410886247587, "a10": 0.0016478418256827474, "a11": -4.6982676569044933e-08}';
T_f_3 = jsondecode(T_f_3);
T_f_4 = '{"a0": 0.43436107478814279, "a1": 3.1788045596049968e-05, "a2": 1.5647413792949185e-06, "a3": 2.9257086282655755e-07, "a4": 0.95237691759433385, "a5": -0.00067017394390215287, "a6": -1.1869207252820726, "a7": -0.012605392952025968, "a8": 0.00078242263137507447, "a9": 1.2214973266166018, "a10": 0.31030009766384486, "a11": -5.6479803980232756e-07}';
T_f_4 = jsondecode(T_f_4);
T_f_5 = '{"a0": 0.83635704694917834, "a1": 0.00030638090285306431, "a2": -9.0100843332285652e-06, "a3": 6.8263263719805806e-07, "a4": 0.89304670424101307, "a5": 0.0096751487388877788, "a6": -0.092073265755285572, "a7": -1.1991256726612967, "a8": 0.034216224682536933, "a9": 0.0030344587835573478, "a10": 1.313391160738369, "a11": 0.0093721425484399878, "a12": 9.2229927138587353e-07}';
T_f_5 = jsondecode(T_f_5);
T_p = '{"a0": -0.041121429077325189, "a1": 0.0023044218762596088, "a2": 6.6362846826772102e-05, "a3": 0.97422092933200066, "a4": -0.013357527327146913, "a5": 0.15345321880637283, "a6": -0.082487149088618789, "a7": -0.053349230103525817, "a8": 0.021406794340458671, "a9": -0.0029618662196897834}';
T_p = jsondecode(T_p);

% X=[Basement,Bot_floor_zones,Bot_plenum,Mid_floor_zones,Mid_plenum,Top_floor_zones,Top_plenum] total = 19 states

%U = [T_ref_i'; m_i';Prh_i'];
%D = [Tamb(i_sch);Sol_rad(i_sch);Qint(i_sch,:)';1];

A_bot=[BM.a4 BM.a5 BM.a6 BM.a7 0 BM.a8 0;...
    B_f_1.a9 B_f_1.a4 B_f_1.a5 0 B_f_1.a6 B_f_1.a7 B_f_1.a8;...
    B_f_2.a9 B_f_2.a5 B_f_2.a4 B_f_2.a6 0 B_f_2.a7 B_f_2.a8;...
    B_f_3.a9 0 B_f_3.a5 B_f_3.a4 B_f_3.a6 B_f_3.a7 B_f_3.a8;...
    0 B_f_4.a5 0 B_f_4.a6 B_f_4.a4 B_f_4.a7 B_f_4.a8;...
    B_f_5.a10 B_f_5.a5 B_f_5.a6 B_f_5.a7 B_f_5.a8 B_f_5.a4 B_f_5.a9;...
    0 B_p.a4 B_p.a5 B_p.a6 B_p.a7 B_p.a8 B_p.a3];

A_mid=[M_f_1.a4 M_f_1.a5 0 M_f_1.a6 M_f_1.a7 M_f_1.a8;...
    M_f_2.a5 M_f_2.a4 M_f_2.a6 0 M_f_2.a7 M_f_2.a8;...
    0 M_f_3.a5 M_f_3.a4 M_f_3.a6 M_f_3.a7 M_f_3.a8;...
    M_f_4.a5 0 M_f_4.a6 M_f_4.a4 M_f_4.a7 M_f_4.a8;...
    M_f_5.a5 M_f_5.a6 M_f_5.a7 M_f_5.a8 M_f_5.a4 M_f_5.a9;...
    M_p.a4 M_p.a5 M_p.a6 M_p.a7 M_p.a8 M_p.a3];


A_top=[T_f_1.a4 T_f_1.a5 0 T_f_1.a6 T_f_1.a7 T_f_1.a8;...
    T_f_2.a5 T_f_2.a4 T_f_2.a6 0 T_f_2.a7 T_f_2.a8;...
    0 T_f_3.a5 T_f_3.a4 T_f_3.a6 T_f_3.a7 T_f_3.a8;...
    T_f_4.a5 0 T_f_4.a6 T_f_4.a4 T_f_4.a7 T_f_4.a8;...
    T_f_5.a5 T_f_5.a6 T_f_5.a7 T_f_5.a8 T_f_5.a4 T_f_5.a9;...
    T_p.a4 T_p.a5 T_p.a6 T_p.a7 T_p.a8 T_p.a3];



A=[A_bot zeros(7,12); zeros(6,7) A_mid zeros(6,6);zeros(6,13) A_top];

B=[BM.a9  zeros(1,15) BM.a10 zeros(1,18) BM.a11 zeros(1,15);... 
   0 B_f_1.a10 zeros(1,14) 0 B_f_1.a11 zeros(1,17) 0 B_f_1.a12 zeros(1,14);... 
   0 0 B_f_2.a10 zeros(1,13) 0 0 B_f_2.a11 zeros(1,16) 0 0 B_f_2.a12 zeros(1,13);...
   0 0 0 B_f_3.a10  zeros(1,12) 0 0 0 B_f_3.a11 zeros(1,15) 0 0 0 B_f_3.a12 zeros(1,12);...
   0 0 0 0 B_f_4.a9 zeros(1,11) 0 0 0 0 B_f_4.a10 zeros(1,14) 0 0 0 0 B_f_4.a11 zeros(1,11);...
   0 0 0 0 0 B_f_5.a11 zeros(1,10) 0 0 0 0 0 B_f_5.a12 zeros(1,13) 0 0 0 0 0 B_f_5.a13 zeros(1,10);...
   zeros(1,22) B_p.a9 zeros(1,28);...
   zeros(1,6) M_f_1.a9 zeros(1,9) zeros(1,7) M_f_1.a10 zeros(1,11) zeros(1,6) M_f_1.a11 zeros(1,9);...
   zeros(1,7) M_f_2.a9 zeros(1,8) zeros(1,8) M_f_2.a10 zeros(1,10) zeros(1,7) M_f_2.a11 zeros(1,8);...
   zeros(1,8) M_f_3.a9 zeros(1,7) zeros(1,9) M_f_3.a10 zeros(1,9) zeros(1,8) M_f_3.a11 zeros(1,7);...
   zeros(1,9) M_f_4.a9 zeros(1,6) zeros(1,10) M_f_4.a10 zeros(1,8) zeros(1,9) M_f_4.a11 zeros(1,6);...
   zeros(1,10) M_f_5.a10 zeros(1,5) zeros(1,11) M_f_5.a11 zeros(1,7) zeros(1,10) M_f_5.a12 zeros(1,5);...
   zeros(1,28) M_p.a9 zeros(1,22);...
   zeros(1,11) T_f_1.a9 zeros(1,4) zeros(1,13) T_f_1.a10 zeros(1,5) zeros(1,11) T_f_1.a11 zeros(1,4);...
   zeros(1,12) T_f_2.a9 zeros(1,3) zeros(1,14) T_f_2.a10 zeros(1,4) zeros(1,12) T_f_2.a11 zeros(1,3);...
   zeros(1,13) T_f_3.a9 zeros(1,2) zeros(1,15) T_f_3.a10 zeros(1,3) zeros(1,13) T_f_3.a11 zeros(1,2);...
   zeros(1,14) T_f_4.a9 0 zeros(1,16) T_f_4.a10 zeros(1,2) zeros(1,14) T_f_4.a11 0;...
   zeros(1,15) T_f_5.a10 zeros(1,17) T_f_5.a11  0 zeros(1,15) T_f_5.a12;...
   zeros(1,34) T_p.a9 zeros(1,16)];

E=[BM.a1 BM.a2 BM.a3 zeros(1,15) BM.a0;...
   B_f_1.a1 B_f_1.a2 0 B_f_1.a3 zeros(1,14) B_f_1.a0;...
   B_f_2.a1 B_f_2.a2 0 0 B_f_2.a3 zeros(1,13) B_f_2.a0;...
   B_f_3.a1 B_f_3.a2 0 0 0 B_f_3.a3 zeros(1,12) B_f_3.a0;...
   B_f_4.a1 B_f_4.a2 0 0 0 0 B_f_4.a3 zeros(1,11) B_f_4.a0;...
   B_f_5.a1 B_f_5.a2 0 0 0 0 0 B_f_5.a3 zeros(1,10) B_f_5.a0;...
   B_p.a1 B_p.a2 zeros(1,16) B_p.a0;...
   M_f_1.a1 M_f_1.a2 zeros(1,6) M_f_1.a3 zeros(1,9) M_f_1.a0;...
   M_f_2.a1 M_f_2.a2 zeros(1,7) M_f_2.a3 zeros(1,8) M_f_2.a0;...
   M_f_3.a1 M_f_3.a2 zeros(1,8) M_f_3.a3 zeros(1,7) M_f_3.a0;...
   M_f_4.a1 M_f_4.a2 zeros(1,9) M_f_4.a3 zeros(1,6) M_f_4.a0;...
   M_f_5.a1 M_f_5.a2 zeros(1,10) M_f_5.a3 zeros(1,5) M_f_5.a0;...
   M_p.a1 M_p.a2 zeros(1,16)  M_p.a0;...
   T_f_1.a1 T_f_1.a2 zeros(1,11) T_f_1.a3 zeros(1,4) T_f_1.a0;...
   T_f_2.a1 T_f_2.a2 zeros(1,12) T_f_2.a3 zeros(1,3) T_f_2.a0;...
   T_f_3.a1 T_f_3.a2 zeros(1,13) T_f_3.a3 zeros(1,2) T_f_3.a0;...
   T_f_4.a1 T_f_4.a2 zeros(1,14) T_f_4.a3 zeros(1,1) T_f_4.a0;...
   T_f_5.a1 T_f_5.a2 zeros(1,15) T_f_5.a3 T_f_5.a0;...
   T_p.a1 T_p.a2 zeros(1,16) T_p.a0];


%Xnew=A*X+B*U+E*D;

%% Chiller Coefficients
Chiller='{"d2": 0.021064377886322604, "d0": 31831.133045203038, "d1": 1669.3381694021118}';
Chiller = jsondecode(Chiller);
%% Boiler Coefficients
Boiler = '{"e1": -7427.858331724743, "e0": 87326.430571052188, "e2": 1.2194084496701703}';
Boiler = jsondecode(Boiler);
%% Fan Coefficients
Fan_basement= '{"c2": -2.8299603300043187e-07, "c1": 1426.8404675121399, "c0": -3.4106051316484809e-08}';
Fan_base= jsondecode(Fan_basement);
Fan_bot='{"c2": 84.480355951858115, "c1": 471.14579801443278, "c0": -500.86675472088518}';
Fan_bot = jsondecode(Fan_bot);
Fan_mid='{"c2": 10.318117204413147, "c1": 397.49369172728188, "c0": -2306.8985871172627}';
Fan_mid = jsondecode(Fan_mid);
Fan_top='{"c2": 188.45849258878928, "c1": -645.32297405719748, "c0": 2583.7729155549769}';
Fan_top = jsondecode(Fan_top);
Fan=[Fan_base,Fan_bot,Fan_mid,Fan_top];