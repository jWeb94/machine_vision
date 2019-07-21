close all
clear
clc

%% Aufgabe 3,a : Robuste Schaetzung mit dem M-Estimator

% Lade Daten
img = imread('postit2g.png');
load 'pixellist_postit2g.mat';

num_lines = length(pixellist);
num_iterations = 5; % Iterationen zur Anpassung der Weights
k = 10;

est_params = []; % [theta, c] pro Zeile

for i = 1 : 1 : num_lines
    [theta_temp, c_temp] = m_estimator_line(pixellist(i).list, num_iterations, k);
    est_params = [est_params; [theta_temp, c_temp]];
end

% Visualisierung des Ergebnisses
figure('Name', 'Visualisierung der Schaetzung mit dem M-Estimator'); 
imshow(img); 
hold on; 
for j = 1 : 1 : num_lines
    [start_point, end_point] = calculate_start_end_point(pixellist(j).list, est_params(j,1), est_params(j,2));
    
    % Datenpunkte
    plot(pixellist(j).list(:,1), pixellist(j).list(:,2), 'cx');
    % Geschaetze Linie
    plot([start_point(1), end_point(1)], [start_point(2), end_point(2)], 'r-o');
    hold on;
    
end
