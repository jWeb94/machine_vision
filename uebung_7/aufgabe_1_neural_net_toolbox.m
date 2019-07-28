close all
clear
clc

%% Aufgabe 1: Neural Network Toolbox und AlexNet

% Load Network
network = alexnet; % benoetogt Deep Learning Toolbox™ Model for AlexNet Network Toolbox um das Netz zu laden!
class_overview = network.Layers(end).ClassNames; 

disp('Aufbau des AlexNet: '); 
network.Layers


% Lade Testbild um Classifizierung zu testen: 
[file, path] = uigetfile('*.jpg');
addpath(path); 
test_img = imread(file); 
test_img_resized = imresize(test_img, [227, 227]); 

figure('Name', 'Resized Image'); 
imagesc(test_img_resized); 

disp('Das uebergebene Bild zeigt: '); 
classification_result = network.classify(test_img_resized) 

disp('Programm beendet'); 