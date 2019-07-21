close all
clear
clc

%% Test einer Schaetzung fuer den Initial Guess des M-Estimators: 

load 'pixellist_postit2g.mat';

num_lines = length(pixellist);

for i = 1 : 1 : num_lines
   % Zufaellige Punkte fuer Initial Guess:
   num_points = length(pixellist(i).list(:,1)); 
   % disp('num_points ist: '); 
   % disp(num_points); 
   % disp('rand_idx ist: '); 
   rand_idx_1 = ceil(rand()*num_points); % ceil = runde mathematisch auf den naechsten Integer
   rand_idx_2 = ceil(rand()*num_points); 
   % disp(rand_idx_1);  
    
   if rand_idx_1 > num_points || rand_idx_2 > num_points
       disp('ERROR! Index out of bound');
       break;
   end
   
   % Bestimme die initiale Gerade
   p = [pixellist(i).list(rand_idx_1, 1); pixellist(i).list(rand_idx_1, 2)];  
   q = [pixellist(i).list(rand_idx_2, 1); pixellist(i).list(rand_idx_2, 2)];  
   
   direction_vector = q - p;
   n = (1/(sqrt((direction_vector(1))^2 + (direction_vector(2))^2))).*[-direction_vector(2); direction_vector(1)];
   %abs_n = sqrt(n(1)^2 + n(2)^2); % Muss = 1 sein!
   
   c = -dot(n,p); % Berechnung fuer c aus <n, x_i> + c = 0 <=> c = -<n, x_i>
   
   s = [-c*n(1); -c*n(2)]; % -c*n beschreibt einen Punkt auf der Geraden! (vgl Skript S. 6 04_Curvefitting.pdf)
   
   r = -1000:0.1:1000; 
   x = s(1) + r*direction_vector(1); 
   y = s(2) + r*direction_vector(2); 
   figure('Name', 'Test Line Initial Guess'); 
   plot(x, y); 
   hold on; 
   plot(pixellist(i).list(rand_idx_1, 1), pixellist(i).list(rand_idx_1, 2), 'cx')
end
