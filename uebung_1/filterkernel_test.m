close all; 
clear; 
clc; 

%% Teste, ob man Filterkernel selbst schreiben kann

img = imread('kabel_salat.png'); 

d_u = [-1 0 1; -1 0 1; -1 0 1];
d_v = [-1 -1 -1; 0 0 0; 1 1 1];

img_d_u = imfilter(img, d_u, 'conv'); 
figure('Name', 'Ableitung in u-Richtung'); 
imshow(img_d_u); 

img_d_v = imfilter(img, d_v, 'conv');
figure('Name', 'Ableitung in v-Richtung'); 
imshow(img_d_v); 

grad_abs = imgradient(img_d_u, img_d_v); 
figure('Name', 'Gradientenbetrag'); 
imshow(grad_abs); 


