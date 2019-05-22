clear, close all
%% regression
N=2;%# of zones

coef=zeros(4,8);%every column is coefficients of each zone
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
    
    
    
    Tout=data_train(1:end-1,ind_Tout);
    
    Tzone1_input_train=data_train(1:end-1,ind_Tzone);%as input
    Tzone1_output_train=data_train(2:end,ind_Tzone);%as output

    m_train=data_train(1:end-1,ind_m);
    Qrh_train=data_train(1:end-1,ind_Qrh);
    Qint_train=data_train(1:end-1,ind_Qint);%internal heat gain
    
    
    input_train=[Tout-Tzone1_input_train Qint_train+Qrh_train m_train Tzone1_input_train];
    output_train=Tzone1_output_train;
%     coef(:,ii)=input_train\output_train;
    coef(:,jj)=quadprog(input_train'*input_train, -output_train'*input_train, -eye(4),-1e-4*ones(4,1));
    coef(:,jj)
    
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
        Tin(tt+1)=input_test*coef(:,jj);
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

    a0=coef(1,jj);
    a1=coef(2,jj);
    a2=coef(3,jj);
    a3=coef(4,jj);
    
        struct_name=struct('a0',coef(1,jj),'a1',coef(2,jj),'a2',coef(3,jj),'a3',coef(4,jj));

     if jj==1
        eval(sprintf('floor1_zone1_%d_result=struct_name',jj-1));

        pic_name= sprintf('zone2dvalidation_result.png');
        saveas(gcf,pic_name);
        save('floor1',sprintf('floor1_zone1_%d_result',jj-1))
    else
                eval(sprintf('floor1_zone1_%d_result=struct_name',jj-1));

        pic_name= sprintf('zone27dvalidation_result.png');
        saveas(gcf,pic_name);
        save('floor1',sprintf('floor1_zone1_%d_result',jj-1),'-append')
    end
    %%
%     return
end
