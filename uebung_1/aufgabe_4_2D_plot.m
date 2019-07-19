clear
clc

%% Aufgabe 4: Plots in 2D

% Plotte einen Sinus mit einer roten, durchgehenden Linie im Intervall [-10, 10]
x = -10:0.01:10; 
y = sin(x); 
figure('Name', 'Sinus-Plot')
plot(x, y, 'r-'); 

% Weitere Funktionen in Fenster plotten: 
hold on; 
function_1 = 1./(pi.*x);
function_2 = -1./(pi.*x); 
% Musterloesung: 
% function_1 = 1/pi*x.^(-1)

plot(x, function_1, 'k:');
hold on; 
plot(x, function_2, 'k:');

% Resize die y-Achse auf das Intervall [-1.5, 1.5]
axis([-10 10 -1.5 1.5]) % [x_min x_max y_min y_max]

% Fuege ein blaues Kreuz im Ursprung des Koordinatensystems ein: 
plot(0, 0, 'bx')

