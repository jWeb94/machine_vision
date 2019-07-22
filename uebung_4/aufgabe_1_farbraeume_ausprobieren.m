close all
clear
clc

%% Aufgabe 1: Vergleich der Kanaele des HSV- und L*u*v-Raums

figure('Name', 'Geladenes Rohbild');
img_loaded = imread('stack.png'); %480x640x3 = h x w x c; RGB von 0 bis 255 -> uint8-Datatype
subplot(1, 2, 1); % Zeilen, Spalten, Nr des Plots von links nach rechts und oben nach unten 
imshow(img_loaded); % hold on waere im Fall von subplot(...) in den selben Subplot rein zeichnen
title('Geladenes Bild (RGB) vor der Konvertierung zu Werten zwischen 0 und 1');

%img_loaded = im2double(img_loaded); % Umformen in Werte zwischen 0 und 1 
subplot(1, 2, 2); 
imshow(img_loaded); 
title('Geladenes Bild (RGB) nach der Konvertierung zu Werten zwischen 0 und 1');

% Konvertiere Bild in den HSV-Raum:
img_hsv = rgb2hsv(img_loaded); % ALLE Werte zwischen 0 und 1; type Double
h_channel = img_hsv(:, :, 1); 
s_channel = img_hsv(:, :, 2); 
v_channel = img_hsv(:, :, 3); 

% Konvertiere Bild in den L*u*v-Raum: 
img_luv = rgb2lab(img_loaded); % l: 0-100; u, v = -100 - 100
l_channel = img_luv(: ,: , 1); 
% DEBUG: 
% max_l = max(max(img_luv(:,:,1)));
% min_l = min(min(img_luv(:,:,1)));
% max_u = max(max(img_luv(:,:,2)));
% min_u = min(min(img_luv(:,:,2)));
% max_v = max(max(img_luv(:,:,3)));
% min_v = min(min(img_luv(:,:,3)));


% Visualisiere im Vergleich: 
subplot(2, 3, 1); 
imshow(h_channel); 
title('H-Kanal des HSV-Images');

subplot(2, 3, 2); 
imshow(s_channel); 
title('S-Kanal des HSV-Images');

subplot(2, 3, 3)
CLIM_V = [0, 1];
imagesc(v_channel, CLIM_V); 
colormap(gray)
title('V-Kanal des HSV-Images (entspricht Luminace)');

subplot(2, 3, 4);
CLIM_L = [0, 100]; % [CLOW, CHIGH]
imagesc(l_channel, CLIM_L);
colormap(gray);
title('L-Kanal des L*u*v-Bildes'); 


disp('Programm beendet'); 