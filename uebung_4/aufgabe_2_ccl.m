close all
clear
clc

% Gute Parameter: 
% min_pixel = 100
% thresh_rgb = 0.05 % Muss im Bereich 0...1 liegen, da so der RGB-Raum beschrieben wird!
% thresh_luv = 5 % L liegt im Bereich 0...100; u & v im Bereich -100 - 100
% thresh_l = 1.5
% thresh_uv = 3

%% Aufgabe 2: Verwende den vorgefertigten CCL (Connected Components Labeling-Algorithmus) auf verschiedenen Farbraeumen mit verschiedenen Thresholds

% Lade das Bild
img = imread('stack.png'); % RGB8

% Extrahiere die Versuchskanaele
img_rgb = im2double(img);       % Konvertiere in Double im Bereich 0...1; RGB-Bild
img_luv = rgb2lab(img);         % Konvertiere in L*u*v
l_channel = img_luv(:, :, 1); 
uv_channel = img_luv(:, :, 2:3); 

% Wende CCL an: 
%[ labels hist ] = ccl( I, theta, minpixel ) % Funktionsdeklaration
min_pixel = 100; % Mindestanzahl an Pixeln um ein Segment zu erstellen - fuer CCL

% Parametervariation ermoeglichen
while_flag = true; 
figure('Name', 'Qualitativer Vergleich der Ergebnisse');
while while_flag
    % Variation der Mindestanzahl an Pixeln fuer ein Segment ueber thresh_X
    %
    % Die Threshs beschreiben den maximalen euklidischen Abstand im
    % Farbraum zwischen zwei Farben, die zu einem Segment gehoeren sofern
    % sie innerhalb des Threshs liegen
    %
    % min_pixel = input('Bitte gebe die Mindestanzahl an Pixeln ein um ein Segment zu bilden: '); 
    
    % RGB
    thresh_rgb = input('Gebe den Threshold fuer den CCL-Algorithmus fuer RGB ein: '); 
    [labeled_img_rgb, hist_rgb] = ccl(img_rgb, thresh_rgb, min_pixel);
    
    % L*u*v
    thresh_luv = input('Gebe den Threshold fuer den CCL-Algorithmus fuer L*u*v ein: '); 
    [labeled_img_luv, hist_luv] = ccl(img_luv, thresh_luv, min_pixel);
    
    % L
    thresh_L = input('Gebe den Threshold fuer den CCL-Algorithmus fuer L-Kanal des L*u*v ein: '); 
    [labeled_img_L, hist_L] = ccl(l_channel, thresh_L, min_pixel);
    
    % u*v
    thresh_uv = input('Gebe den Threshold fuer den CCL-Algorithmus fuer u- und v-Kanal des L*u*v ein: '); 
    [labeled_img_uv, hist_uv] = ccl(uv_channel, thresh_uv, min_pixel);

    
    % Visualisierung/Qualitativer Vergleich
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

    % Parametervariation abgeschlossen?
    while_flag = input('Nochmal? (ja = true, nein = false)');
end

disp('Programm beendet');