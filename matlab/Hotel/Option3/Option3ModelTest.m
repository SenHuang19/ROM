% clc
% clearvars
% close all
%% Data Preparation

%Option_3_ModelCoeff

ExtractSimData
%%-----------------Zone temperatures--------------------------------%%

% X=[Basement,Bot_floor_zones,Mid_floor_guest,Mid_floor_corridor,Top_floor_guest,Top_floor_zones] total = 15 states
%U = [T_ref_i'; m_i';Prh_i'];
%D = [Tamb(i_sch);Sol_rad(i_sch);Qint(i_sch,:)';1];


% CTtemp(:,1)=[Basement.t1(1);Botfloor11.t1(1);Botfloor12.t1(1);Botfloor13.t1(1);Botfloor14.t1(1);Botfloor15.t1(1);Botfloor16.t1(1);Botfloor17.t1(1);...
%     MidfloorG.t1(1);MidfloorC.t1(1);...
%     TopfloorG.t1(1);Topfloor1.t1(1);Topfloor2.t1(1);Topfloor3.t1(1);Topfloor4.t1(1)];
% 
% Zone.T_ref_i= [Basement.sp0,Botfloor11.sp0,Botfloor12.sp0,Botfloor13.sp0,Botfloor14.sp0,Botfloor15.sp0,Botfloor16.sp0,Botfloor17.sp0,...
%     MidfloorG.sp0,MidfloorC.sp0,...
%     TopfloorG.sp0,Topfloor1.sp0,Topfloor2.sp0,Topfloor3.sp0,Topfloor4.sp0];
% 
% Zone.m_i=[Basement.mf,Botfloor11.mf,Botfloor12.mf,Botfloor13.mf,Botfloor14.mf,Botfloor15.mf,Botfloor16.mf,Botfloor17.mf,...
%     MidfloorG.mf,MidfloorC.mf,...
%     TopfloorG.mf,Topfloor1.mf,Topfloor2.mf,Topfloor3.mf,Topfloor4.mf];
% 
% 
% Zone.Prh_i= [Basement.rh,Botfloor11.rh,Botfloor12.rh,Botfloor13.rh,Botfloor14.rh,Botfloor15.rh,Botfloor16.rh,Botfloor17.rh,...
%     MidfloorG.rh,MidfloorC.rh,...
%     TopfloorG.rh,Topfloor1.rh,Topfloor2.rh,Topfloor3.rh,Topfloor4.rh];


Qint_total=[Basement.Qint,Botfloor11.Qint,Botfloor12.Qint,Botfloor13.Qint,Botfloor14.Qint,Botfloor15.Qint,Botfloor16.Qint,Botfloor17.Qint,...
    MidfloorG.Qint,MidfloorC.Qint,...
    TopfloorG.Qint,Topfloor1.Qint,Topfloor2.Qint,Topfloor3.Qint,Topfloor4.Qint];

Tout=TopfloorG.Tamb;
Qsol=TopfloorG.Sol_rad;
%save extvar_option3_hotel.mat Tout Qsol Qint_total

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
% subplot(4,2,1)
% plot(CTtemp(1,:),'r')
% hold on
% plot(Zone.T_ref_i(:,1),'b')
% xlabel('time')
% ylabel('Basement temperature')
% legend('actual','setpoint')
% subplot(4,2,2)
% plot(CTtemp(2,:),'r')
% hold on
% plot(Zone.T_ref_i(:,2),'b')
% xlabel('time')
% ylabel('BotFloor1 ')
% subplot(4,2,3)
% plot(CTtemp(3,:),'r')
% hold on
% plot(Zone.T_ref_i(:,3),'b')
% xlabel('time')
% ylabel('BotFloor2 ')
% subplot(4,2,4)
% plot(CTtemp(4,:),'r')
% hold on
% plot(Zone.T_ref_i(:,4),'b')
% xlabel('time')
% ylabel('BotFloor3 ')
% subplot(4,2,5)
% plot(CTtemp(5,:),'r')
% hold on
% plot(Zone.T_ref_i(:,5),'b')
% xlabel('time')
% ylabel('BotFloor4 ')
% subplot(4,2,6)
% plot(CTtemp(6,:),'r')
% hold on
% plot(Zone.T_ref_i(:,6),'b')
% xlabel('time')
% ylabel('BotFloor5 ')
% subplot(4,2,7)
% plot(CTtemp(7,:),'r')
% hold on
% plot(Zone.T_ref_i(:,7),'b')
% xlabel('time')
% ylabel('BotFloor6 ')
% subplot(4,2,8)
% plot(CTtemp(8,:),'r')
% hold on
% plot(Zone.T_ref_i(:,8),'b')
% xlabel('time')
% ylabel('BotFloor7 ')
% 
% %-------------Middle floor & Top floor zones -------------------------
% figure(2)
% subplot(2,1,1)
% plot(CTtemp(9,:),'r')
% hold on
% plot(Zone.T_ref_i(:,9),'b')
% xlabel('time')
% ylabel('Midfloor guest temperature')
% legend('actual','setpoint')
% subplot(2,1,2)
% plot(CTtemp(10,:),'r')
% hold on
% plot(Zone.T_ref_i(:,10),'b')
% xlabel('time')
% ylabel('Midfloor corridor temperature ')
% figure(3)
% subplot(3,2,1)
% plot(CTtemp(11,:),'r')
% hold on
% plot(Zone.T_ref_i(:,11),'b')
% xlabel('time')
% ylabel('Topfloor guest temperature ')
% legend('actual','setpoint')
% subplot(3,2,2)
% plot(CTtemp(12,:),'r')
% hold on
% plot(Zone.T_ref_i(:,12),'b')
% xlabel('time')
% ylabel('Topfloor banquet ')
% subplot(3,2,3)
% plot(CTtemp(13,:),'r')
% hold on
% plot(Zone.T_ref_i(:,13),'b')
% xlabel('time')
% ylabel('Topfloor Corridor ')
% subplot(3,2,4)
% plot(CTtemp(14,:),'r')
% hold on
% plot(Zone.T_ref_i(:,14),'b')
% xlabel('time')
% ylabel('Topfloor dining ')
% subplot(3,2,5)
% plot(CTtemp(15,:),'r')
% hold on
% plot(Zone.T_ref_i(:,15),'b')
% xlabel('time')
% ylabel('Topfloor kitchen ')
% 
% 
% 
% for i=1:1:3
%  saveas(figure(i),fullfile('C:\Users\vchinde\Box Sync\EDCOptimization\Hotel\hotel_newmodel\Option3\Plots',['figure' num2str(i) '.jpeg']));
% end
