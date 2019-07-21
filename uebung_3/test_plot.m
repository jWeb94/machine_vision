close all
clear
clc

%% Test Plot Funktion um Linie zwischen zwei Punkten zu zeichen

img = imread('postit2g.png');
imshow(img); 
hold on; 

plot([1 100],[50 200], '-', 'LineWidth', 3); 

Zeichnet eine Linie zwischen den Punkten [Start_x End_x][Start_y End_y]