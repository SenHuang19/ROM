%-----Bottom floor and basement-------------------------------------------

fid = fopen(fullfile('floor1_opt3\zone1-1rawdata.csv'),'r');
%fid = fopen('zone1-1rawdata.csv');
databot1= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Botfloor11 = ExtractZone_info(databot1);

fid = fopen(fullfile('floor1_opt3\zone1-2rawdata.csv'),'r');
%fid = fopen('zone1-2rawdata.csv');
databot2= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Botfloor12 = ExtractZone_info(databot2);

fid = fopen(fullfile('floor1_opt3\zone1-3rawdata.csv'),'r');
%fid = fopen('zone1-3rawdata.csv');
databot3= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Botfloor13 = ExtractZone_info(databot3);

fid = fopen(fullfile('floor1_opt3\zone1-4rawdata.csv'),'r');
%fid = fopen('zone1-4rawdata.csv');
databot4= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Botfloor14 = ExtractZone_info(databot4);

fid = fopen(fullfile('floor1_opt3\zone1-5rawdata.csv'),'r');
%fid = fopen('zone1-5rawdata.csv');
databot5= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Botfloor15 = ExtractZone_info(databot5);

fid = fopen(fullfile('floor1_opt3\zone1-6rawdata.csv'),'r');
%fid = fopen('zone1-6rawdata.csv');
databot6= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Botfloor16 = ExtractZone_info(databot6);

fid = fopen(fullfile('floor1_opt3\zone1-7rawdata.csv'),'r');
%fid = fopen('zone1-7rawdata.csv');
databot7= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Botfloor17 = ExtractZone_info(databot7);

fid = fopen(fullfile('floor1_opt3\zone1-8rawdata.csv'),'r');
%fid = fopen('zone1-8rawdata.csv');
databaseb= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Basement = ExtractZone_info(databaseb);


%-----------Mid floor --------------------------------------------------

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

%---------Top floor ---------------------------------------------
fid = fopen(fullfile('floor3_opt3\zone61rawdata.csv'),'r');
%fid = fopen('zone61rawdata.csv');
datatop61= textscan(fid,'%C%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Topfloor1 = ExtractZone_info(datatop61);

fid = fopen(fullfile('floor3_opt3\zone62rawdata.csv'),'r');
%fid = fopen('zone62rawdata.csv');
datatop62= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Topfloor2 = ExtractZone_info(datatop62);


fid = fopen(fullfile('floor3_opt3\zone63rawdata.csv'),'r');
%fid = fopen('zone63rawdata.csv');
datatop63= textscan(fid,'%C%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Topfloor3 = ExtractZone_info(datatop63);


fid = fopen(fullfile('floor3_opt3\zone64rawdata.csv'),'r');
%fid = fopen('zone64rawdata.csv');
datatop64= textscan(fid,'%C%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
Topfloor4 = ExtractZone_info(datatop64);

fid = fopen(fullfile('floor3_opt3\zone6rawdata.csv'),'r');
%fid = fopen('zone6rawdata.csv');
datatopg= textscan(fid,'%C%s%s%s%s%s%s%s%s%s%s%s%s%s','delimiter',',');
fclose(fid);
TopfloorG = ExtractZone_info(datatopg);





