function [trainData,trainLabel] = generateTraindata(data,istrain)
segData = data.segData;
num_samples = size(segData,2);

if istrain
    true_index=[];
    fake_index = [];
    for  i= 1:num_samples
        maxCurvature = max(segData(i).curvature(:,3));
        label = segData(i).Label;
        if maxCurvature > 0.001 && strcmp(label,data.negativeField)
            fake_index =[fake_index;i];
            continue;      
        elseif ~strcmp(label,data.negativeField)
            true_index =[true_index;i]; 
        end
    end
end
    index = randi(length(fake_index), [ length(true_index),1]);
    index = fake_index(index);
    index = [index;true_index];
    data.segData = segData(index);
    segData = segData(index);
    
    
obd_feature = {'speed','GPS_heading'};
num_samples = size(segData,2);
[num_step,num_vggfeature] = size(segData(1).vgg19);
[num_step,num_curfeature] = size(segData(1).curvature);
perRecode = zeros(num_step, length(obd_feature) + num_vggfeature + 1);
trainData = cell(num_samples,1);
trainLabel =  transferLabel(data);
trainData = cell(num_samples,1);
for  i= 1:num_samples
    for j = 1: length(obd_feature) 
        perRecode(:,j)=segData(i).data{:,obd_feature(j)};
    end
    perRecode(:,length(obd_feature)+1:length(obd_feature)+ num_vggfeature ) = segData(i).vgg19;
    perRecode(:, length(obd_feature)+ num_vggfeature+1 : end) = segData(i).curvature(:,3);
    trainData(i) = {(perRecode')};%normalize
end
end

function data = normalize(data)
[row, col] = size(data);
mean_v = mean(data,[],2);
var_v = var(data,[],2);
mean_v = repmat(mean_v,1,col);
var_v = repmat(var_v,1,col);

data = (data - mean_v)./((var_v.^2+ 1e-5).^(0.5));
end


function Label = transferLabel(data)
num_samples = size(data.segData,2);
Label = zeros(num_samples,1);
num_label = size(data.eventField,2);
for i = 1:num_samples
    label = data.segData(i).Label;
    for j = 1: num_label
        if strcmp(label,data.eventField{j})
            Label(i) = j;
            break;
        end
    end
end

end