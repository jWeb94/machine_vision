close all
clear
clc

%% Aufgabe 1: Kamerkalibierung mit der Methode von Tsai

calibration_img = imread('calibration.png');
calibration_img = im2double(calibration_img);
pos_calibration_points = load('calibration_worldpos.txt');

% Visualisierung des Originalbildes:
figure('Name', 'Original Kalibrierungsbild'); 
subplot(1, 2, 1); 
imagesc(calibration_img);
title('Original Kalibrierungsbild');

% Korrespondierende Datenpunkte sammeln:
point_image_coordinates = zeros(16, 5);     % Initialisierung der Datenpunkte  16 Punkte mit 5 Komponenten: [xi, eta, zeta, u_corresponding, v_corresponding] -> Als Uebergabeset an die Methode von Tsai
                                            % xi, eta, zeta = Koordinaten
                                            % im Raum; u_corresponding und
                                            % v_corresponding beschreiben
                                            % die korrespondierenden
                                            % Bildkoordinaten
point_image_coordinates(:,1:3)  = pos_calibration_points; 
point_image_coordinates(:, 4:5) = [133 417; 306 398; 435 354; 550 313; 79 281; 55 215; 38 167; 215 177; 391 213; 28 54; 178 42; 300 42; 370 74; 410 92; 530 150; 261 279]; 
                                            
% Visualisierung der Punkte
subplot(1, 2, 2); 
imagesc(calibration_img); 
hold on; 
for i = 1 : 1 : length(point_image_coordinates(:,1))    % Zeichne die gefundenen Punkte ins Bild
    plot(point_image_coordinates(i, 4), point_image_coordinates(i, 5), 'cx'); 
end
title('Bild mit Kalibrierungsmarkierungen'); 
                                            
                                            
% Wende den Kalibrierungsalgorithmus nach Tsai an:
[intrinsic_matix, rotation_matrix, translation_vector] = tsai(point_image_coordinates); % Wende Tsai an

% Sind die Ergebnisse sinnvoll?
%   -> Checke ob rotation_matrix eine zulaessige Rotationsmatrix darstellt
%   Das heisst: Die Matrix muss orthogonal sein => det(R) = 1
det_rotation_matrix = det(rotation_matrix); 
if(det_rotation_matrix == 1)
    disp('Rotationsmatrix ist zulaessig!');
end

est_camera_parameters = determine_camera_parameters(rotation_matrix, intrinsic_matix, translation_vector)









disp('Programm beendet');