clear,clc;close all;
tr = imread('./sign/TR.jpg');
tl = imread('./sign/TL.jpg');
llc = imread('./sign/LLC.jpg');
rlc = imread('./sign/RLC.jpg');
gs = imread('./sign/GS.jpg');
videoName = '118_07182017';
% feature_field = {'time','speed','GPS_long','GPS_lat','GPS_heading','distance'};
% event_field = {'TurnLeft','TurnRight','LaneChangeLeft','LaneChangeRight'};
% data = Dataset(videoName, feature_field, event_field);
% data = data.segtrip(0.05, 0.05,0.002,'distance');
% data = data.extractCurvature();
% data = data.extractVgg19();
% data = data.appendLabel()
% result_field = [data.eventField, data.negativeField]
load('data.mat')
vidObj =  VideoReader(data.videoPath);
FrameRate = vidObj.FrameRate;
NumberOfFrames = vidObj.NumberOfFrames;


vgg_net = vgg19;
lstm_net = load('./model/lstm_net.mat');
num_case = size(data.segData);
num_case = num_case(2);
X = cell(num_case,1);
for sequenceIndex = 1: num_case
    segData = data.segData(sequenceIndex);
    speedfeature = segData.data{:,'speed'};
    headingfeature = segData.data{:,'GPS_heading'};
    vggfeature = segData.vgg19;
    curfeature = segData.curvature(:,3);
    x=[speedfeature,headingfeature, vggfeature, curfeature]';
    X(sequenceIndex) = {(x)};
end
y = classify(lstm_net.net,X);
% prepare the speed arrary
obd_sample_vedio = (1/FrameRate) /0.01;
sampleIndex = [1 : obd_sample_vedio:   NumberOfFrames * obd_sample_vedio];
sampleIndex = round(sampleIndex);
speed = data.logData.speed(sampleIndex);
heading = data.logData.GPS_heading(sampleIndex);
%

vidObj = VideoReader(data.videoPath);
index = 0;
figure;hold on;
for sequenceIndex = 1: num_case
    segData = data.segData(sequenceIndex);
    while hasFrame(vidObj)
    %for frameIndex = segData.minFrame : segData.maxFrame
       
        index = index + 1;
        img = readFrame(vidObj);
        if index<6000
            if index >= segData.maxFrame
                break;
            else
                continue
            end
        end
        subplot(4,4,[1,2,3,5,6,7,9,10,11,13,14,15]);imshow(img,[]);
        % feature map
        featuremap = activations(vgg_net,img,'conv5_4','OutputAs','channels');
        imgSize = size(img);
        [maxValue,maxValueIndex] = max(max(max(featuremap)));
        featuremap = featuremap(:,:,maxValueIndex);
        featuremap = imresize(featuremap,[240 360]);
        subplot(4,4,4);title('VGG 19 Feature');imshow(featuremap,[]);
         %speed
        if (index - 50 >1)
            begin = index-50;
        else
            begin = 1;
        end
        showIndex= [begin:index];
        showspeed =  speed(showIndex);
        
        subplot(4,4,8);;title('Speed');plot(showIndex,showspeed,'-');
        ylim([0 200]);  
        if begin == 1 
            xlim([1 50])
        else
            xlim([begin index])
        end
        %heading
        showheading  =  heading(showIndex);
        subplot(4,4,12);;title('Heading');plot(showIndex,showheading,'-');
        ylim([0 360]);  
        if begin == 1 
            xlim([1 50])
        else
            xlim([begin index])
        end
        subplot(4,4,16);
        switch double(y(sequenceIndex))-1
            case 1
                imshow(tl)
            case 2
                imshow(tr)
            case 3
                imshow(llc)
            case 4
                imshow(rlc)
            otherwise
                imshow(gs)
        end
        
        drawnow();
        if index >= segData.maxFrame
            break;
        end
    end
end
        
    
    
    
    
% 
% while hasFrame(vidObj)
%     img = readFrame(vidObj);
%     I = activations(net,img,'conv5_4','OutputAs','channels');
%     imgSize = size(img);
%     I = mat2gray(I);
%     [maxValue,maxValueIndex] = max(max(max(I)));
%     I = I(:,:,maxValueIndex);
%     I = imresize(I,[480 720 ]);
%     imshowpair(img,I,'montage');
%     
% 
%     
%     
%     k = k+1;
% end