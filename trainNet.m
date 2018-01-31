clear; clc; close all;
eva = {};
for node= 20:5:200
% load('118_07182017_vgg.mat');
% [trainData,trainLabel] = generateTraindata(data,1);
% 
% load('028_vgg.mat');
% [Data,Label] = generateTraindata(data,1);
% trainData = [trainData; Data];
% trainLabel = [trainLabel;Label];
% clear data;
% load('106_07142017_vgg.mat');
% [Data,Label] = generateTraindata(data,1);
% trainData = [trainData; Data];
% trainLabel = [trainLabel;Label];
% clear data;
% load('112_07172017_vgg.mat');
% [Data,Label] = generateTraindata(data,1);
% 
% load('023_vgg.mat');
% [Data,Label] = generateTraindata(data,1);
% trainData = [trainData; Data];
% trainLabel = [trainLabel;Label];
load('trainData.mat');
load('trainLabel.mat')
accuracy = zeros(10,1);
for j=1:10
randomIndex = randperm( length(trainLabel));
trainData = trainData(randomIndex);
trainLabel = trainLabel(randomIndex);

trainNum = round(0.75 *length(trainLabel));
trainD = trainData(1:trainNum);
trainL =  categorical(trainLabel(1:trainNum));
testD =  trainData(trainNum+1:end);
testL =  categorical(trainLabel(trainNum+1:end));

net = trainLSTM(trainD, trainL,node);


y = classify(net,testD );
accuracy(j) =  sum(y == testL)/numel(testL);
end
eva = [eva;{node,accuracy,mean(accuracy)}]
end

