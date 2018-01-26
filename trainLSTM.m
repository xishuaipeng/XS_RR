function net = trainLSTM(X, Y,outputSize)
[num_feature, temp] = size(X{1});
inputSize = num_feature;
% outputSize = 40;
outputMode = 'last';
numClasses = 5;
layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(outputSize,'OutputMode',outputMode)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

maxEpochs = 300;
miniBatchSize = 50;
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.001,...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize,...
    'Shuffle', 'every-epoch');
%every-epoch
net = trainNetwork(X,Y,layers,options);

end