close all
clear
clc

%% Aufgabe 3: least trimmed sum of squares (LTS) - Schaetzer


img = imread('postit2g.png');
load 'pixellist_postit2g.mat';

num_lines = length(pixellist);
num_iterations = 10; 
percentage_lts = 0.8; % *100%

figure('Name', 'Least trimmed sum of squares - Schaetzer');
imshow(img); 
hold on; 

for i = 1 : 1 : num_lines
   % Initial Guess
   rand_idx_1 = ceil(rand()*length(pixellist(i).list(:,1)));
   rand_idx_2 = ceil(rand()*length(pixellist(i).list(:,1)));
   [normal_vector, c] = calculate_initial_guess(pixellist(i).list(rand_idx_1,:), pixellist(i).list(rand_idx_2,:));
   
   for j = 1 : 1 : num_iterations
       % Bestimme Beste 'percentage' der Datenpunkte
       valid_datapoints = calculate_valid_datapoints_lts(normal_vector, c, pixellist(i).list, percentage_lts); 
       % Schaetze mit den validen Datenpunkten
       [normal_vector, c] = least_square_line_lts(valid_datapoints); 
       temp_theta = atan2(normal_vector(2), normal_vector(1));
       [temp_start_point, temp_end_point] = calculate_start_end_point (pixellist(i).list, temp_theta, c);
   end
   
   plot(valid_datapoints(:,1), valid_datapoints(:,2), 'mx');
   hold on; 
   plot([temp_start_point(1), temp_end_point(1)], [temp_start_point(2), temp_end_point(2)], 'g-');
   hold on;  
end