close all
clear
clc

%% Test Musterloesung Aufgabe 1
img = imread('postit2g.png');
d_img = im2double(img);

figure(1) 
subplot(2,3,1);
imshow(d_img);

filter_type='sobel';
fv=fspecial(filter_type);
fu=fv';

img_gr_u = conv2(d_img,double(fu));
img_gr_v = conv2(d_img,double(fv));
img_gr = sqrt(img_gr_u.^2 + img_gr_v.^2);
img_angle = atan2(img_gr_v, img_gr_u);

figure('Name', 'Winkel des Gradienten'); 
imshow(img_angle, 'colormap', hsv); 

