clear,clc;
videoName = '118_07182017';
feature_field = {'time','speed','GPS_long','GPS_lat','GPS_heading','distance'};
event_field = {'TurnLeft','TurnRight','LaneChangeLeft','LaneChangeRight'};
data = Dataset(videoName, feature_field, event_field);
data = data.reSample('distance', 0.002);
data = data.extractCurvature();
% % % % % % % % data = data.reSync();
data = data.segtrip(0.05, 0.02,0.001,'distance');
data = data.extractCurvature();
data = data.extractVgg19();
% data = data.checkCurvature;
% load('matlab.mat');
data = data.appendLabel();
save('028data.mat','data');


clear,clc;
feature_field = {'time','speed','GPS_long','GPS_lat','GPS_heading','distance'};
event_field = {'TurnLeft','TurnRight'};
data = Dataset('023',feature_field,event_field);
% % % % % % % % data = data.reSync();
data = data.segtrip(0.05, 0.02,0.001,'distance');
data = data.extractCurvature();
data = data.extractVgg19();
% data = data.checkCurvature;
% load('matlab.mat');
data = data.appendLabel();
save('023data.mat','data');

clear,clc;
feature_field = {'time','speed','GPS_long','GPS_lat','GPS_heading','distance'};
event_field = {'TurnLeft','TurnRight'};
data = Dataset('106_07142017',feature_field,event_field);
% % % % % % % % data = data.reSync();
data = data.segtrip(0.05, 0.02,0.001,'distance');
data = data.extractCurvature();
data = data.extractVgg19();
% data = data.checkCurvature;
% load('matlab.mat');
data = data.appendLabel();
save('106data.mat','data');


clear,clc;
feature_field = {'time','speed','GPS_long','GPS_lat','GPS_heading','distance'};
event_field = {'TurnLeft','TurnRight'};
data = Dataset('118_07182017',feature_field,event_field);
% % % % % % % % data = data.reSync();
data = data.segtrip(0.05, 0.02,0.001,'distance');
data = data.extractCurvature();
data = data.extractVgg19();
% data = data.checkCurvature;
% load('matlab.mat');
data = data.appendLabel();
save('118_07182017.mat','data');


clear,clc;
feature_field = {'time','speed','GPS_long','GPS_lat','GPS_heading','distance'};
event_field = {'TurnLeft','TurnRight'};
data = Dataset('112_07172017',feature_field,event_field);
% % % % % % % % data = data.reSync();
data = data.segtrip(0.05, 0.02,0.001,'distance');
data = data.extractCurvature();
data = data.extractVgg19();
% data = data.checkCurvature;
% load('matlab.mat');
data = data.appendLabel();
save('112_07172017.mat','data');
% data.checkSeg;
% load('matlab.mat');
% y = {data.segData.Label};
