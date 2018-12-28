% clc
% clearvars
% close all
%% Data Preparation

%Option_1_ModelCoeff

fid = fopen(fullfile('floor1_opt1\zone18rawdata.csv'),'r');
%fid = fopen('zone18rawdata.csv');
database= textscan(fid,'%C%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Basement = ExtractZone_info(database);

fid = fopen(fullfile('floor1_opt1\zone1rawdata.csv'),'r');
%fid = fopen('zone1rawdata.csv');
databot= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',','); %22
fclose(fid);
Botfloor = ExtractZone_info(databot);

fid = fopen(fullfile('floor2_opt1\zone2rawdata.csv'),'r');
%fid = fopen('zone2rawdata.csv');
datamidg= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
MidfloorG = ExtractZone_info(datamidg);

fid = fopen(fullfile('floor2_opt1\zone27rawdata.csv'),'r');
%fid = fopen('zone27rawdata.csv');
datamidc= textscan(fid,'%C%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
MidfloorC = ExtractZone_info(datamidc);

fid = fopen(fullfile('floor3_opt1\zone6rawdata.csv'),'r');
%fid = fopen('zone6rawdata.csv');
datatopg= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
TopfloorG = ExtractZone_info(datatopg);

fid = fopen(fullfile('floor3_opt1\zone61rawdata.csv'),'r');
%fid = fopen('zone61rawdata.csv');
datatopc= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
TopfloorC = ExtractZone_info(datatopc);

%%-----------------Zone temperatures--------------------------------%%

%X=[Basement,Bot_floor,Bot_plenum,Mid_floor,Mid_plenum,Top_floor,Top_plenum]
%U = [T_ref_i'; m_i';Prh_i'];
%D = [Tamb(i_sch);Sol_rad(i_sch);Qint(i_sch,:)';1];


%CTtemp(:,1)=[Basement.t1(1);Botfloor.t1(1);MidfloorG.t1(1);MidfloorC.t1(1);TopfloorG.t1(1);TopfloorC.t1(1)];
%Zone.T_ref_i=[Basement.sp0 Botfloor.sp0 MidfloorG.sp0 MidfloorC.sp0 TopfloorG.sp0 TopfloorC.sp0];
%Zone.m_i=[Basement.mf,Botfloor.mf,MidfloorG.mf,MidfloorC.mf,TopfloorG.mf,TopfloorC.mf];
%Zone.Prh_i=[Basement.rh,Botfloor.rh,MidfloorG.rh,MidfloorC.rh,TopfloorG.rh,TopfloorC.rh];
Qint_total=[Basement.Qint,Botfloor.Qint,MidfloorG.Qint,MidfloorC.Qint,TopfloorG.Qint,TopfloorC.Qint];

Tout=TopfloorG.Tamb;
Qsol=TopfloorG.Sol_rad;
%save extvar_option1_hotel.mat Tout Qsol Qint_total
%% zone temperature simulation

% for i_sch=1:length(Qint_total)
%     
%     U = [Zone.T_ref_i(i_sch,:)'; Zone.m_i(i_sch,:)';Zone.Prh_i(i_sch,:)'];
%     D = [TopfloorG.Tamb(i_sch);TopfloorG.Sol_rad(i_sch);Qint_total(i_sch,:)';1];
%    
%      CTtemp(:,i_sch+1)=A*CTtemp(:,i_sch)+B*U+E*D;
% end
% figure(1)
% plot(CTtemp(1,:),'r')
% hold on
% plot(Zone.T_ref_i(:,1),'b')
% xlabel('time')
% ylabel('Basement temperature')
% legend('actual','setpoint')
% figure(2)
% plot(CTtemp(2,:),'r')
% hold on
% plot(Zone.T_ref_i(:,2),'b')
% xlabel('time')
% ylabel('BotFloor temperature')
% legend('actual','setpoint')
% figure(3)
% plot(CTtemp(3,:),'r')
% hold on
% plot(Zone.T_ref_i(:,3),'b')
% xlabel('time')
% ylabel('MiddleFloorGuest temperature')
% figure(4)
% plot(CTtemp(4,:),'r')
% hold on
% plot(Zone.T_ref_i(:,4),'b')
% xlabel('time')
% ylabel('MiddleFloorCorridor temperature')
% legend('actual','setpoint')
% figure(5)
% plot(CTtemp(5,:),'r')
% hold on
% plot(Zone.T_ref_i(:,5),'b')
% xlabel('time')
% ylabel('TopFloorGuest temperature')
% figure(6)
% plot(CTtemp(6,:),'r')
% hold on
% plot(Zone.T_ref_i(:,6),'b')
% xlabel('time')
% ylabel('TopFloorCorridor temperature')
% legend('actual','setpoint')
% 
% 
% for i=1:1:6
%  saveas(figure(i),fullfile('C:\Users\vchinde\Box Sync\EDCOptimization\Hotel\hotel_newmodel\Option1\Plots',['figure' num2str(i) '.jpeg']));
% end
