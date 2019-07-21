close all
clear
clc

%% Aufgabe 2: Plotten der abgeschnittenen Linien

% Bild und Daten laden
img = imread('postit2g.png'); 
load 'pixellist_postit2g.mat';    
[size_pixellist_row, size_pixellist_col] = size(pixellist);  

% Berechnen und Visulisieren
figure('Name', 'Getrimmte Linien'); 
imshow(img);  
hold on; 
for l = 1 : 1 : size_pixellist_col
    [start_pt, end_pt] = total_least_squares_endpoints(pixellist(l).list);  
    plot([start_pt(1), end_pt(1)], [start_pt(2), end_pt(2)], 'r-o');
    hold on;
end