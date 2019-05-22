clear, close all
%% regression
N=2;%# of zonesind_hour=zeros(60*31,24);
for hh=1:24;
    for dd=1:31;
        ind_hour((1:60)+(dd-1)*60,hh)=1440*(dd-1)+(60*(hh-1)+1:60*hh);
    end
end
coef=zeros(4,24,N);%every column is coefficients of each zone
for jj=1:N
    if jj==1
        ii=2;
    else ii=27;
    end
    
    file_train = sprintf('zone%dtrain3.csv',ii);
    [data_train,text] = xlsread(file_train);
    
    for kk=1:length(text)
        if length(char(text(kk)))==length('tout') & char(text(kk))=='tout'
            ind_Tout=kk+1;
        elseif length(char(text(kk)))==length('t1') & char(text(kk))=='t1'
            ind_Tzone=kk+1;
        elseif length(char(text(kk)))==length('m') & char(text(kk))=='m'
            ind_m=kk+1;
        elseif length(char(text(kk)))==length('rh') & char(text(kk))=='rh'
            ind_Qrh=kk+1;
        elseif length(char(text(kk)))==length('i') & char(text(kk))=='i'
            ind_Qint=kk+1;
        end
    end
    
    for hh=1:24
        ind_input=ind_hour(mod(ind_hour(:,hh),60)~=0,hh);
        ind_output=ind_input+1;
        
        ind_input_s(:,hh)=ind_input;
        
        Tout=data_train(ind_input,ind_Tout);
        
        Tzone1_input_train=data_train(ind_input,ind_Tzone);%as input
        Tzone1_output_train=data_train(ind_output,ind_Tzone);%as output
        
        m_train=data_train(ind_input,ind_m);
        Qrh_train=data_train(ind_input,ind_Qrh);
        Qint_train=data_train(ind_input,ind_Qint);%internal heat gain
        input_train=[Tout-Tzone1_input_train Qint_train+Qrh_train m_train Tzone1_input_train];
        output_train=Tzone1_output_train;
%         coef(:,hh,jj)=quadprog(input_train'*input_train, -output_train'*input_train, -eye(4),-1e-4*ones(4,1));
        coef(:,hh,jj)=quadprog(input_train'*input_train, -output_train'*input_train, [],[],[],[],1e-4*ones(4,1),[]);

    end
    
    
    %% test
    
    file_test = sprintf('zone%dtest2.csv',ii);
    data_test = xlsread(file_test);
    % data_test=xlsread('zone1-1test.csv');
    Tout=data_test(1:end-1,ind_Tout);
    Tzone1_output_test=data_test(2:end,ind_Tzone);%as output
    % Tzone1_ini=data_test(1,5);
    Qrh_test=data_test(1:end-1,ind_Qrh);
    Qint_test=data_test(1:end-1,ind_Qint);%internal heat gain
    m_test=data_test(1:end-1,ind_m);
    % clearvars data_test
    
    Tin(1)=Tzone1_output_test(1);
    for tt=1:length(Tout)
        input_test=[Tout(tt)-Tin(tt) Qrh_test(tt)+Qint_test(tt) m_test(tt) Tin(tt)];
        
        if mod(tt,60)~=0
            [mm,nn]=find(ind_input_s==tt);
        else nn=mod(tt/60,24);
            if nn==0
                nn=24;
            end
        end
        coef_now=coef(:,nn,jj);
        Tin(tt+1)=input_test*coef_now;
    end
    error=Tin(1:end-1)-Tzone1_output_test';
    % plot(error)
    %%
    gcf=figure
    plot(Tin(1:1440))
    hold on
    plot(Tzone1_output_test(1:1440))
    legend('predicted','actual')
    
    pic_name= sprintf('zone1-%dvalidation_result.png',ii);
    saveas(gcf,pic_name);
    
    
    %     a0=coef(1,ii);
    %     a1=coef(2,ii);
    %     a2=coef(3,ii);
    %     a3=coef(4,ii);
    %
    %         struct_name=struct('a0',coef(1,ii),'a1',coef(2,ii),'a2',coef(3,ii),'a3',coef(4,ii));
    %
    %     eval(sprintf('floor1_zone1_%d_result=struct_name',ii));
    %     if ii==1
    %         save('floor1',sprintf('floor1_zone1_%d_result',ii))
    %
    %     else
    %     save('floor1',sprintf('floor1_zone1_%d_result',ii),'-append')
    %     end
    %%
    %     return
end
save('f2_coef','coef')
