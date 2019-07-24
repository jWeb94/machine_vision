close all
clear
clc

%% Aufgabe 4: Morphologische-Operatoren zum Nachbearbeitung der segmentierten Bilder 

img = imread('segments.png'); % Binaerbild
img = im2double(img); 

figure('Name', 'Originalbild'); 
imshow(img); 
title('Orginalbild segmentiert - unbearbeitet'); 


% Wende die Morphologischen Operatoren an
%
% <imoperator>(img, structure_element) -> img muss ein Binaerbild sein;
% structure_element ist eine NxN-Matrix, die die Nachbarschaftsbeziehung
% fuer die morphologischen Operatoren beschreibt

% Definiere strukturierende Elemente
s_4 = [0 1 0; 1 1 1; 0 1 0];
s_8 = ones(3); 
s_rect_5 = [1 1 1 1 1; 1 0 0 0 1; 1 0 0 0 1; 1 0 0 0 1; 1 1 1 1 1];
s_cross_5 = [1 0 0 0 1; 0 1 0 1 0; 0 0 1 0 0; 0 1 0 1 0; 1 0 0 0 1]; 

% Erosion: 
img_erode_s_4 = imerode(img, s_4);
img_erode_s_8 = imerode(img, s_8); 
img_erode_s_rect_5 = imerode(img, s_rect_5); 
img_erode_s_cross_5 = imerode(img, s_cross_5); 

% Dilatation: 
img_dilat_s_4 = imdilate(img, s_4);
img_dilat_s_8 = imdilate(img, s_8); 
img_dilat_s_rect_5 = imdilate(img, s_rect_5); 
img_dilat_s_cross_5 = imdilate(img, s_cross_5); 

% Oeffnen
img_open_s_4 = imopen(img, s_4);
img_open_s_8 = imopen(img, s_8); 
img_open_s_rect_5 = imopen(img, s_rect_5); 
img_open_s_cross_5 = imopen(img, s_cross_5); 

% Schliessen
img_close_s_4 = imclose(img, s_4);
img_close_s_8 = imclose(img, s_8); 
img_close_s_rect_5 = imclose(img, s_rect_5); 
img_close_s_cross_5 = imclose(img, s_cross_5); 


% Visualisierung der Ergebnisse
figure('Name', 'Visualisierung der Ergebnisse'); 

% Erosion
subplot(4, 4, 1); 
imshow(img_erode_s_4); 
title('Erosion 4er-Nachbarschaft');

subplot(4, 4, 2); 
imshow(img_erode_s_8); 
title('Erosion 8er-Nachbarschaft');

subplot(4, 4, 3); 
imshow(img_erode_s_rect_5); 
title('Erosion 25er-Nachbarschaft Rechteck');

subplot(4, 4, 4); 
imshow(img_erode_s_cross_5)
title('Erosion 25er-Nachbarschaft Kreuz');


% Dilatation
subplot(4, 4, 5); 
imshow(img_dilat_s_4); 
title('Dilatation 4er-Nachbarschaft');

subplot(4, 4, 6); 
imshow(img_dilat_s_8); 
title('Dilatation 8er-Nachbarschaft');

subplot(4, 4, 7); 
imshow(img_dilat_s_rect_5); 
title('Dilatation 25er-Nachbarschaft Rechteck');

subplot(4, 4, 8); 
imshow(img_dilat_s_cross_5)
title('Dilatation 25er-Nachbarschaft Kreuz');


% Oeffnen
subplot(4, 4, 9); 
imshow(img_open_s_4); 
title('Öffnen 4er-Nachbarschaft');

subplot(4, 4, 10); 
imshow(img_open_s_8); 
title('Öffnen 8er-Nachbarschaft');

subplot(4, 4, 11); 
imshow(img_open_s_rect_5); 
title('Öffnen 25er-Nachbarschaft Rechteck');

subplot(4, 4, 12); 
imshow(img_open_s_cross_5)
title('Öffnen 25er-Nachbarschaft Kreuz');

% Schliessen
subplot(4, 4, 13); 
imshow(img_close_s_4); 
title('Schließen 4er-Nachbarschaft');

subplot(4, 4, 14); 
imshow(img_close_s_8); 
title('Schließen 8er-Nachbarschaft');

subplot(4, 4, 15); 
imshow(img_close_s_rect_5); 
title('Schließen 25er-Nachbarschaft Rechteck');

subplot(4, 4, 16); 
imshow(img_close_s_cross_5)
title('Schließen 25er-Nachbarschaft Kreuz');


disp('Programm beendet');