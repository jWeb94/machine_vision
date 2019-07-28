close all
clear
clc


%% Aufgabe 2: Transferlearning zur Praediktion der Schilder

% Lade das Ausgangsnetwork
pretrained_net = alexnet; 
disp('Das gegebene AlexNet hat die Struktur: '); 
pretrained_net.Layers


% Teile das Netz auf und generiere neue Ausgabelayer mit einem fully
% connected Layer: 
adapted_net = init(pretrained_net); 
% adapted_net = pretrained_net; % .Layers(1:length(pretrained_net.Layers) - 3); 
adapted_net.Layers(23) = fullyConnectedLayer(200);  % Zufaellig gewaehlt! 200 ist in https://www.youtube.com/watch?v=vq2nnJ4g6N0&t=37s bei 1:06:45 gewaehlt worden
adapted_net.Layers(24) = softmaxLayer(43);          % 43 Klassen zu praedizieren
adapted_net.Layers(25) = classificationLayer; 

disp('Das angepasste Netz hat die Struktur: '); 
adapted_net.Layers







disp('Programm beendet'); 





%% Referenzcode

%% 2. tranfer net
% % import image data
% imds = imageDatastore('machine vision/Assignment7/Images_scaled','IncludeSubfolders',true,'LabelSource','foldernames');
% % Use 70% of the images for training and 30% for validation
% [train_ims, valid_ims] = splitEachLabel(imds,0.7,'randomized');
% % Extract all layers, except the last three
% layersTransfer = net.Layers(1:end-3);
% % Replace the last three layers with a fully connected layer, a softmax layer, and a classification output layer
% numClasses = numel(categories(train_ims.Labels))
% layers = [
%     layersTransfer
%     fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
%     softmaxLayer
%     classificationLayer];
% 
% % Train Network
% miniBatchSize = 100;
% numIterationsPerEpoch = floor(1/2*numel(train_ims.Labels)/miniBatchSize);
% % options
% options = trainingOptions('sgdm',...
%     'MiniBatchSize',miniBatchSize,...
%     'MaxEpochs',30,...
%     'InitialLearnRate',1e-3,...
%     'Verbose',true,...
%     'Plots','training-progress',...
%     'ValidationData',valid_ims,...
%     'ExecutionEnvironment','parallel',...
%     'ValidationFrequency',numIterationsPerEpoch);
% % train
% netTransfer = trainNetwork(train_ims,layers,options);
% 
% % Classify Validation Images
% predictedLabels = classify(netTransfer,valid_ims);
% % Display four sample validation images with their predicted labels
% idx = [1 5 10 15];
% figure(2);
% for i = 1:numel(idx)
%     subplot(2,2,i)
%     I = readimage(valid_ims,idx(i));
%     label = predictedLabels(idx(i));
%     imshow(I)
%     title(char(label))
% end
% % Calculate the classification accuracy on the validation set
% valLabels = valid_ims.Labels;
% accuracy = mean(predictedLabels == valLabels)




