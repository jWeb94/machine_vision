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
measured_points = [133 417; 306 398; 435 354; 550 313; 79 281; 55 215; 38 167; 215 177; 391 213; 28 54; 178 42; 300 42; 370 74; 410 92; 530 150; 261 279]; 
point_image_coordinates(:, 4:5) = measured_points; 
                                            
% Visualisierung der Punkte
subplot(1, 2, 2); 
imagesc(calibration_img); 
hold on; 
for i = 1 : 1 : length(point_image_coordinates(:,1))    % Zeichne die gefundenen Punkte ins Bild
    plot(point_image_coordinates(i, 4), point_image_coordinates(i, 5), 'cx'); 
end
title('Bild mit Kalibrierungsmarkierungen und Schaetzungen aus den 3D Punkten'); 
hold on; 
                                            
                                            
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

%% Aufgabe 2: Bestimme Bildkoordinaten aus Weltkoordinaten (pos_calibration_points) und der geschaetzten Mapping-Matrix
r_t_temp = rotation_matrix; 
r_t_temp(:, 4) = translation_vector; % 3x4
mapping_matrix = intrinsic_matix*r_t_temp; 
est_u_v = []; 
for i = 1 : 1 : length(pos_calibration_points(:,1)); 
    [temp_u, temp_v] = calculate_image_points_from_wold_points(mapping_matrix, pos_calibration_points(i,:)');
    est_u_v = [est_u_v; temp_u, temp_v];
    plot(est_u_v(i, 1), est_u_v(i, 2), 'ro'); 
    hold on; 
    
    
end

avg_error = calculate_projection_error(measured_points, est_u_v)


%% Aufgabe 3: Bestimme die Weltkoordinaten der Punkte A,...,F und die Hoehe des Tischs

image_coordinates = [386 188; 526 281; 606 260; 467 173; 397 67; 559 141]; % vgl Bild 'weltkoordinaten_bild.png'

% Ueber die Bodenebene wissen wir aus dem Bild der Aufgabenstellung durch 'scharfes Hinsehen': 
p_ground = [0; 0; 0]; 
a_ground = [1; 0; 0]; 
b_ground = [0; 1; 0]; 

for j = 1 : 1 : 4 % Weltkoordinaten fuer A, B, C und D -> Liegen auf der Bodenebene.
    resulting_points(j, :) = world_coordinates_from_image_coordinates(intrinsic_matix, rotation_matrix, translation_vector, p_ground, a_ground, b_ground, image_coordinates(j, 1), image_coordinates(j, 2)); 
end

% Ueber die Punkte E und F wissen wir, dass sie auf der selben vertikalen
% Ebene liegen wie A und B, damit folgt:
p_table = resulting_points(1, :)'; % zuvor bestimmten Weltkoordinatenpunkt A
a_table = resulting_points(2, :) -  resulting_points(1, :); % Richtungsvektor von Punkt A nach B
a_table = a_table'; 
b_table = [0; 0; 1]; % Zeta-Achse zeigt nur nach oben

for j = 5 : 1 : 6
    resulting_points(j, :) = world_coordinates_from_image_coordinates(intrinsic_matix, rotation_matrix, translation_vector, p_table, a_table, b_table, image_coordinates(j, 1), image_coordinates(j, 2)); 
end

disp('Die geschaetzten Punkte sind (Zeilenweise): '); 
resulting_points

% Berechung der Hoehe des Tischs: 
heigh_table = (1/2)*(resulting_points(5, 3) + resulting_points(6, 3)); % Mittele die Schaetzungen da E und F kinematisch gleich hoch sein muessen!
disp('Die Hoehe des Tischs ist: '); 
heigh_table


disp('Programm beendet');