clear, close all
%% regression
N=4;%# of zones

coef=zeros(4,N+1);%every column is coefficients of each zone
for ii=1:N
    file_train = sprintf('zone6%dtrain3.csv',ii);
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
    coef(:,ii)=quadprog(input_train'*input_train, -output_train'*input_train, -eye(4),-1e-4*ones(4,1));
    coef(:,ii)
    
    %% test
    
    file_test = sprintf('zone6%dtest2.csv',ii);
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
        Tin(tt+1)=input_test*coef(:,ii);
    end
    error=Tin(1:end-1)-Tzone1_output_test';
    % plot(error)
    %%
    gcf(ii)=figure
    plot(Tin(1:1440))
    hold on
    plot(Tzone1_output_test(1:1440))
    legend('predicted','actual')
    
    pic_name= sprintf('zone6%dvalidation_result.png',ii);
    saveas(gcf(ii),pic_name);
    
    a0=coef(1,ii);
    a1=coef(2,ii);
    a2=coef(3,ii);
    a3=coef(4,ii);
    
    struct_name=struct('a0',coef(1,ii),'a1',coef(2,ii),'a2',coef(3,ii),'a3',coef(4,ii));
    
    eval(sprintf('floor3_zone6_%d_result=struct_name',ii));
    if ii==1
        save('floor3',sprintf('floor3_zone6_%d_result',ii))
        
    else
        save('floor3',sprintf('floor3_zone6_%d_result',ii),'-append')
    end
    %%
    %     return
end
%%
ii=ii+1;
file_train = sprintf('zone6train3.csv');
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
coef(:,ii)=quadprog(input_train'*input_train, -output_train'*input_train, -eye(4),-1e-4*ones(4,1));
coef(:,ii)

%% test

file_test = sprintf('zone6test2.csv');
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
    Tin(tt+1)=input_test*coef(:,ii);
end
error=Tin(1:end-1)-Tzone1_output_test';
% plot(error)
%%
figure
gcf=figure
plot(Tin(1:1440))
hold on
plot(Tzone1_output_test(1:1440))
legend('predicted','actual')

pic_name= sprintf('zone6validation_result.png',ii);
saveas(gcf,pic_name);

a0=coef(1,ii);
a1=coef(2,ii);
a2=coef(3,ii);
a3=coef(4,ii);

struct_name=struct('a0',coef(1,ii),'a1',coef(2,ii),'a2',coef(3,ii),'a3',coef(4,ii));

eval(sprintf('floor3_zone6_result=struct_name',ii));
save('floor3',sprintf('floor3_zone6_result',ii),'-append')

