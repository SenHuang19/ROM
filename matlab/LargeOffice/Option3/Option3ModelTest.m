% clc
% clearvars
% close all
%% Data Preparation

%Option_3_ModelCoeff

ExtractSimData
%%-----------------Zone temperatures--------------------------------%%

% X=[Basement,Bot_floor_zones,Bot_plenum,Mid_floor_zones,Mid_plenum,Top_floor_zones,Top_plenum] total = 19 states
%U = [T_ref_i'; m_i';Prh_i'];
%D = [Tamb(i_sch);Sol_rad(i_sch);Qint(i_sch,:)';1];


% CTtemp(:,1)=[Basement.t1(1);Botfloor1.t1(1);Botfloor2.t1(1);Botfloor3.t1(1);Botfloor4.t1(1);Botfloor5.t1(1);BasePlenum.t1(1);...
%     Midfloor1.t1(1);Midfloor2.t1(1);Midfloor3.t1(1);Midfloor4.t1(1);Midfloor5.t1(1);MidPlenum.t1(1);...
%     Topfloor1.t1(1);Topfloor2.t1(1);Topfloor3.t1(1);Topfloor4.t1(1);Topfloor5.t1(1);TopPlenum.t1(1)];
% 
% Zone.T_ref_i= [Basement.sp0 Botfloor1.sp0 Botfloor2.sp0 Botfloor3.sp0 Botfloor4.sp0 Botfloor5.sp0 ...
%     Midfloor1.sp0 Midfloor2.sp0 Midfloor3.sp0 Midfloor4.sp0 Midfloor5.sp0...
%    Topfloor1.sp0 Topfloor2.sp0 Topfloor3.sp0 Topfloor4.sp0 Topfloor5.sp0];
% 
% Zone.m_i=[Basement.mf Botfloor1.mf Botfloor2.mf Botfloor3.mf Botfloor4.mf Botfloor5.mf BasePlenum.mf ...
%     Midfloor1.mf Midfloor2.mf Midfloor3.mf Midfloor4.mf Midfloor5.mf MidPlenum.mf ...
%    Topfloor1.mf Topfloor2.mf Topfloor3.mf Topfloor4.mf Topfloor5.mf TopPlenum.mf];
% 
% 
% Zone.Prh_i= [Basement.rh Botfloor1.rh Botfloor2.rh Botfloor3.rh Botfloor4.rh Botfloor5.rh ...
%     Midfloor1.rh Midfloor2.rh Midfloor3.rh Midfloor4.rh Midfloor5.rh...
%    Topfloor1.rh Topfloor2.rh Topfloor3.rh Topfloor4.rh Topfloor5.rh];


Qint_total=[Basement.Qint Botfloor1.Qint Botfloor2.Qint Botfloor3.Qint Botfloor4.Qint Botfloor5.Qint ...
    Midfloor1.Qint Midfloor2.Qint Midfloor3.Qint Midfloor4.Qint Midfloor5.Qint...
   Topfloor1.Qint Topfloor2.Qint Topfloor3.Qint Topfloor4.Qint Topfloor5.Qint];

Tout=Topfloor1.Tamb;
Qsol=Topfloor1.Sol_rad;
% save extvar_option3.mat Tout Qsol Qint_total
% %% zone temperature simulation
% 
% for i_sch=1:length(Qint_total)
%     
%     U = [Zone.T_ref_i(i_sch,:)'; Zone.m_i(i_sch,:)';Zone.Prh_i(i_sch,:)'];
%     D = [Topfloor1.Tamb(i_sch);Topfloor1.Sol_rad(i_sch);Qint_total(i_sch,:)';1];
%    
%      CTtemp(:,i_sch+1)=A*CTtemp(:,i_sch)+B*U+E*D;
% end
% 
% %--------------Basement and Bottom floor zones ------------------------
% figure(1)
% subplot(3,2,1)
% plot(CTtemp(1,:),'r')
% hold on
% plot(Zone.T_ref_i(:,1),'b')
% xlabel('time')
% ylabel('Basement temperature')
% legend('actual','setpoint')
% subplot(3,2,2)
% plot(CTtemp(2,:),'r')
% hold on
% plot(Zone.T_ref_i(:,2),'b')
% xlabel('time')
% ylabel('BotFloor1 ')
% %legend('actual','setpoint')
% subplot(3,2,3)
% plot(CTtemp(3,:),'r')
% hold on
% plot(Zone.T_ref_i(:,3),'b')
% xlabel('time')
% ylabel('BotFloor2 ')
% subplot(3,2,4)
% plot(CTtemp(4,:),'r')
% hold on
% plot(Zone.T_ref_i(:,4),'b')
% xlabel('time')
% ylabel('BotFloor3 ')
% %legend('actual','setpoint')
% subplot(3,2,5)
% plot(CTtemp(5,:),'r')
% hold on
% plot(Zone.T_ref_i(:,5),'b')
% xlabel('time')
% ylabel('BotFloor4 ')
% subplot(3,2,6)
% plot(CTtemp(6,:),'r')
% hold on
% plot(Zone.T_ref_i(:,6),'b')
% xlabel('time')
% ylabel('BotFloor5 ')
% %legend('actual','setpoint')
% 
% %-------------Middle floor zones -------------------------
% figure(2)
% subplot(3,2,1)
% plot(CTtemp(8,:),'r')
% hold on
% plot(Zone.T_ref_i(:,7),'b')
% xlabel('time')
% ylabel('MidFloor1 temperature')
% legend('actual','setpoint')
% subplot(3,2,2)
% plot(CTtemp(9,:),'r')
% hold on
% plot(Zone.T_ref_i(:,8),'b')
% xlabel('time')
% ylabel('MidFloor2 ')
% %legend('actual','setpoint')
% subplot(3,2,3)
% plot(CTtemp(10,:),'r')
% hold on
% plot(Zone.T_ref_i(:,9),'b')
% xlabel('time')
% ylabel('MidFloor3 ')
% subplot(3,2,4)
% plot(CTtemp(11,:),'r')
% hold on
% plot(Zone.T_ref_i(:,10),'b')
% xlabel('time')
% ylabel('MidFloor4 ')
% %legend('actual','setpoint')
% subplot(3,2,5)
% plot(CTtemp(12,:),'r')
% hold on
% plot(Zone.T_ref_i(:,11),'b')
% xlabel('time')
% ylabel('MidFloor5 ')
% 
% %---------------Top floor zones ----------------------------
% figure(3)
% subplot(3,2,1)
% plot(CTtemp(14,:),'r')
% hold on
% plot(Zone.T_ref_i(:,12),'b')
% xlabel('time')
% ylabel('TopFloor1 temperature')
% legend('actual','setpoint')
% subplot(3,2,2)
% plot(CTtemp(15,:),'r')
% hold on
% plot(Zone.T_ref_i(:,13),'b')
% xlabel('time')
% ylabel('TopFloor2 ')
% %legend('actual','setpoint')
% subplot(3,2,3)
% plot(CTtemp(16,:),'r')
% hold on
% plot(Zone.T_ref_i(:,14),'b')
% xlabel('time')
% ylabel('TopFloor3 ')
% %legend('actual','setpoint')
% subplot(3,2,4)
% plot(CTtemp(17,:),'r')
% hold on
% plot(Zone.T_ref_i(:,15),'b')
% xlabel('time')
% ylabel('TopFloor4 ')
% %legend('actual','setpoint')
% subplot(3,2,5)
% plot(CTtemp(18,:),'r')
% hold on
% plot(Zone.T_ref_i(:,16),'b')
% xlabel('time')
% ylabel('TopFloor5 ')
% %legend('actual','setpoint')
% 
% %-------------- Pleunum in different floors -------------------
% figure(4)
% subplot(3,1,1)
% plot(CTtemp(7,:),'r')
% xlabel('time')
% ylabel('BotPlenum temperature')
% subplot(3,1,2)
% plot(CTtemp(13,:),'r')
% xlabel('time')
% ylabel('MidPlenum ')
% subplot(3,1,3)
% plot(CTtemp(19,:),'r')
% xlabel('time')
% ylabel('TopPlenum ')
% 
% 
% 
% for i=1:1:4
%  saveas(figure(i),fullfile('C:\Users\vchinde\Box Sync\EDCOptimization\LargeOffice\ROM-NewEPlusModel\ROM-NewEPlusModel\office\winter\zone\Simulation_option3\Plots',['figure' num2str(i) '.jpeg']));
% end
