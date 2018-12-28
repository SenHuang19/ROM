%-----Bottom floor and basement-------------------------------------------
fid = fopen(fullfile('Bot_floor\opt3\zone4-1rawdata.csv'),'r');
%fid = fopen('zone4-1rawdata_bot.csv');
databot1= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Botfloor1 = ExtractZone_info(databot1);

fid = fopen(fullfile('Bot_floor\opt3\zone4-2rawdata.csv'),'r');
%fid = fopen('zone4-2rawdata_bot.csv');
databot2= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Botfloor2 = ExtractZone_info(databot2);

fid = fopen(fullfile('Bot_floor\opt3\zone4-3rawdata.csv'),'r');
%fid = fopen('zone4-3rawdata_bot.csv');
databot3= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Botfloor3 = ExtractZone_info(databot3);

fid = fopen(fullfile('Bot_floor\opt3\zone4-4rawdata.csv'),'r');
%fid = fopen('zone4-4rawdata_bot.csv');
databot4= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Botfloor4 = ExtractZone_info(databot4);

fid = fopen(fullfile('Bot_floor\opt3\zone4-5rawdata.csv'),'r');
%fid = fopen('zone4-5rawdata_bot.csv');
databot5= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Botfloor5 = ExtractZone_info(databot5);

fid = fopen(fullfile('Bot_floor\opt3\zone5rawdata.csv'),'r');
%fid = fopen('zone5rawdata_bot.csv');
databasep= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
BasePlenum = ExtractZone_info(databasep);

fid = fopen(fullfile('Bot_floor\opt3\zone6rawdata.csv'),'r');
%fid = fopen('zone6rawdata_bot.csv');
databaseb= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Basement = ExtractZone_info(databaseb);


%-----------Mid floor --------------------------------------------------

fid = fopen(fullfile('Mid_floor\opt3\zone4-1rawdata.csv'),'r');
%fid = fopen('zone4-1rawdata_mid.csv');
datamid1= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Midfloor1 = ExtractZone_info(datamid1);

fid = fopen(fullfile('Mid_floor\opt3\zone4-2rawdata.csv'),'r');
%fid = fopen('zone4-2rawdata_mid.csv');
datamid2= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Midfloor2 = ExtractZone_info(datamid2);

fid = fopen(fullfile('Mid_floor\opt3\zone4-3rawdata.csv'),'r');
%fid = fopen('zone4-3rawdata_mid.csv');
datamid3= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Midfloor3 = ExtractZone_info(datamid3);

fid = fopen(fullfile('Mid_floor\opt3\zone4-4rawdata.csv'),'r');
%fid = fopen('zone4-4rawdata_mid.csv');
datamid4= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Midfloor4 = ExtractZone_info(datamid4);

fid = fopen(fullfile('Mid_floor\opt3\zone4-5rawdata.csv'),'r');
%fid = fopen('zone4-5rawdata_mid.csv');
datamid5= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Midfloor5 = ExtractZone_info(datamid5);

fid = fopen(fullfile('Mid_floor\opt3\zone5rawdata.csv'),'r');
%fid = fopen('zone5rawdata_mid.csv');
datamidp= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
MidPlenum = ExtractZone_info(datamidp);




%----------- Top floor -------------------------------------------------
fid = fopen(fullfile('Top_floor\opt3\zone4-1rawdata.csv'),'r');
%fid = fopen('zone4-1rawdata_top.csv');
datatop1= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Topfloor1 = ExtractZone_info(datatop1);

fid = fopen(fullfile('Top_floor\opt3\zone4-2rawdata.csv'),'r');
%fid = fopen('zone4-2rawdata_top.csv');
datatop2= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Topfloor2 = ExtractZone_info(datatop2);


fid = fopen(fullfile('Top_floor\opt3\zone4-3rawdata.csv'),'r');
%fid = fopen('zone4-3rawdata_top.csv');
datatop3= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Topfloor3 = ExtractZone_info(datatop3);


fid = fopen(fullfile('Top_floor\opt3\zone4-4rawdata.csv'),'r');
%fid = fopen('zone4-4rawdata_top.csv');
datatop4= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Topfloor4 = ExtractZone_info(datatop4);


fid = fopen(fullfile('Top_floor\opt3\zone4-5rawdata.csv'),'r');
%fid = fopen('zone4-5rawdata_top.csv');
datatop5= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Topfloor5 = ExtractZone_info(datatop5);


fid = fopen(fullfile('Top_floor\opt3\zone5rawdata.csv'),'r');
%fid = fopen('zone5rawdata_top.csv');
datatopp= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
TopPlenum = ExtractZone_info(datatopp);
