
fid = fopen(fullfile('Bot_floor\opt1\zone6rawdata.csv'),'r');
database= textscan(fid,'%C%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Basement = ExtractZone_info(database);

fid = fopen(fullfile('Bot_floor\opt1\zone4rawdata.csv'),'r');
databot= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Botfloor = ExtractZone_info(databot);

fid = fopen(fullfile('Bot_floor\opt1\zone5rawdata.csv'),'r');
databotple= textscan(fid,'%C%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Botplenum = ExtractZone_info(databotple);


fid = fopen(fullfile('Mid_floor\opt1\zone4rawdata.csv'),'r');
datamid= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Midfloor = ExtractZone_info(datamid);

fid = fopen(fullfile('Mid_floor\opt1\zone5rawdata.csv'),'r');
datamidple= textscan(fid,'%C%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Midplenum = ExtractZone_info(datamidple);


fid = fopen(fullfile('Top_floor\opt1\zone4rawdata.csv'),'r');
datatop= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Topfloor = ExtractZone_info(datatop);

fid = fopen(fullfile('Top_floor\opt1\zone5rawdata.csv'),'r');
datatopple= textscan(fid,'%C%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Topplenum = ExtractZone_info(datatopple);

%%-----------------Zone temperatures--------------------------------%%

%X=[Basement,Bot_floor,Bot_plenum,Mid_floor,Mid_plenum,Top_floor,Top_plenum]
%U = [T_ref_i'; m_i';Prh_i'];
%D = [Tamb(i_sch);Sol_rad(i_sch);Qint(i_sch,:)';1];

%Q_input=Midfloor.mf.*1.2.*(12.8-Midfloor.t1);

% CTtemp(:,1)=[Basement.t1(1);Botfloor.t1(1);Botplenum.t1(1);Midfloor.t1(1);Midplenum.t1(1);Topfloor.t1(1);Topplenum.t1(1)];
% Zone.T_ref_i=[Basement.sp0 Botfloor.sp0 Midfloor.sp0 Topfloor.sp0];
% Zone.m_i=[Basement.mf Botfloor.mf Midfloor.mf Topfloor.mf];
% Zone.Prh_i=[Basement.rh Botfloor.rh Midfloor.rh Topfloor.rh];
Qint_total=[Basement.Qint Botfloor.Qint Midfloor.Qint Topfloor.Qint];

Tout=Topfloor.Tamb;
Qsol=Topfloor.Sol_rad;
%save extvar_option1.mat Tout Qsol Qint_total
% %% zone temperature simulation
% 
% for i_sch=1:length(Qint_total)
%     
%     U = [Zone.T_ref_i(i_sch,:)'; Zone.m_i(i_sch,:)';Zone.Prh_i(i_sch,:)'];
%     D = [Topfloor.Tamb(i_sch);Topfloor.Sol_rad(i_sch);Qint_total(i_sch,:)';1];
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
% xlabel('time')
% ylabel('Botplenum temperature')
% figure(4)
% plot(CTtemp(4,:),'r')
% hold on
% plot(Zone.T_ref_i(:,3),'b')
% xlabel('time')
% ylabel('Midfloor temperature')
% legend('actual','setpoint')
% figure(5)
% plot(CTtemp(5,:),'r')
% xlabel('time')
% ylabel('Midplenum temperature')
% figure(6)
% plot(CTtemp(6,:),'r')
% hold on
% plot(Zone.T_ref_i(:,4),'b')
% xlabel('time')
% ylabel('Topfloor temperature')
% legend('actual','setpoint')
% figure(7)
% plot(CTtemp(7,:),'r')
% xlabel('time')
% ylabel('Topplenum temperature')
% 
% for i=1:1:7
%  saveas(figure(i),fullfile('C:\Users\vchinde\Box Sync\EDCOptimization\LargeOffice\ROM-NewEPlusModel\ROM-NewEPlusModel\office\winter\zone\Simulation_option1\Plots',['figure' num2str(i) '.jpeg']));
% end
