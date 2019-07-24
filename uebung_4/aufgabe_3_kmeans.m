close all
clear
clc

% Auffaellig: 
% u*v - Segmentierung funktioniert mit k-Means am besten!


%% Aufgabe 3: k-Means Algorithmus fuer Farbsegmentierung

% Lade die Bilddaten
img = imread('stack.png'); 

% Setze Parameter
k = 4; 


% Extrahiere die Versuchskanaele
img_rgb = im2double(img);       % Konvertiere in Double im Bereich 0...1; RGB-Bild
img_luv = rgb2lab(img);         % Konvertiere in L*u*v
l_channel = img_luv(:, :, 1); 
uv_channel = img_luv(:, :, 2:3); 


% Berechne die Segmentierung
%
% Funktionsdeklaration color_kmeans
% [ label_image prototypes ] = color_kmeans ( I, k )
    
% RGB
[labeled_img_rgb, prototype_rgb] = color_kmeans(img_rgb, k);
% L*u*v
[labeled_img_luv, prototype_luv] = color_kmeans(img_luv, k);
% L
[labeled_img_L, prototype_L] = color_kmeans(l_channel, k);  
% u*v
[labeled_img_uv, prototype_uv] = color_kmeans(uv_channel, k);

    
% Visualisierung/Qualitativer Vergleich
figure('Name', 'Qualitativer Vergleich der Ergebnisse');

% RGB
subplot(2, 2, 1); 
imagesc(labeled_img_rgb, [0, max(max(labeled_img_rgb))]);
colormap(gray)
title('Labeled RGB'); 
    
% L*u*v
subplot(2, 2, 2); 
imagesc(labeled_img_luv, [0, max(max(labeled_img_luv))]);
colormap(gray)
title('Labeled L*u*v'); 
    
% L
subplot(2, 2, 3); 
imagesc(labeled_img_L, [0, max(max(labeled_img_L))]);
colormap(gray)
title('Labeled L'); 
    
% u*v
subplot(2, 2, 4); 
imagesc(labeled_img_uv, [0, max(max(labeled_img_uv))]);
colormap(gray)
title('Labeled u*v'); 

disp('Programm beendet'); 