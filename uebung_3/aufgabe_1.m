close all
clear
clc

%% Aufgabe 1: Berechnungsskript Parameterschaetzung Linien

img = imread('postit2g.png'); 
load 'pixellist_postit2g.mat';
    % pixellist(i).list gibt die Punkte im Raum (u|v) der Linie wieder
    % Debug:
    % figure('Name', 'Debug Plot: Visualisierung der gegebenen Datenpunkte');
    % plot(pixellist(1).list(:,1), pixellist(1).list(:,2));
    % axis([0 640 0 383]); 


    
    
[size_pixellist_row, size_pixellist_col] = size(pixellist); 

% Initialisierung
resulting_parameters = zeros(size_pixellist_col, 2); % [Winkel (in Radiant), Offset]

for i = 1 : 1 : size_pixellist_col
    %temp_datapoints = pixellist(i).list;
    [resulting_parameters(i, 1), resulting_parameters(i, 2)] = least_sum_of_squares_estimation(pixellist(i).list);  
end
    
% Visualisierung
figure('Name', 'Plot mit Linien')
imshow(img); 
hold on; 
for j = 1 : 1 : size_pixellist_col
    % Wir kriegen aus der hesseschen Normalform die x und y - Koordinaten
    % der Linie
    [temp_line_u, temp_line_v] = calculate_hesse_points(resulting_parameters(j,1), resulting_parameters(j,2), 383, 640); % Das Bild ist 640 Pixel breit
%     % Plot der Messdatenpunkte
%     figure('Name', 'Test');
%     plot(pixellist(j).list(:,1), pixellist(j).list(:,2), 'cx');
%     hold on; 
%     % Plot der Linie
%     plot(temp_line_u, temp_line_v); 
%     hold off;
%     
    
    % Richtiger Plot:
    plot(pixellist(j).list(:,1), pixellist(j).list(:,2), 'rp');
    hold on; 
    plot(temp_line_u, temp_line_v, 'c-')
    hold on; 
        % Anmerkung: 
        %   Der plot-Befehl und hold on funktioniert auch wenn man zuvor
        %   ein Bild in die Figure geplottet hat
end 

disp('Programm beendet')

