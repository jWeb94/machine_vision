close all
clear
clc

%% Test was passiert, wenn man den Gradient von 0, ..., 255 mit Datentyp uint8 bildet:

img = imread('postit2g.png');

filter_prewitt_u = [1 0 -1; 1 0, -1; 1 0 -1]; 
filter_prewitt_u = (1/6)*filter_prewitt_u; 

filter_prewitt_v = [1 1 1 ; 0 0 0; -1 -1 -1]; 
filter_prewitt_v = (1/6)*filter_prewitt_v; 

g_u = conv2(img, filter_prewitt_u); 
g_v = conv2(img, filter_prewitt_v); 

min_g_u = min(min(g_u))
max_g_u = max(max(g_u))

% conv2 wandelt das Ergebnis automatisch in double um. Ich vermute es kommt
% quasi auf das selbe hinaus, bloß, dass statt zwischen -1 und 1 die Werte
% zwischen -255 und 255 liegen. Anteilig am Intervall bleibt es das gleiche! 


figure('Name', 'g_u im Wertebereich 255');
% imshow(g_u);
imshow(abs(g_u), [0 255]); % Das ist das, was imshow im Hintergrund macht, wenn ein Wertebereich zwischen 0 und 1 im Bild ist!