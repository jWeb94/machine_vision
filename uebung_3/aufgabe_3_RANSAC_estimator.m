close all
clear
clc

%% Aufgabe 3: RANSAC Estimator fuer Linien im Bild

img = imread('postit2g.png'); 
load 'pixellist_postit2g.mat';

n_lines = length(pixellist); 
k_max = 10000;     % Anzahl der RANSAC Iterationen (Ausgleich zwischen Genauigkeit und Laufzeit)
epsilon = 5;    % +- Bereich in dem die Datenpunkte um die Schaetzung herum liegen duerfen, um noch Teil des Consensus-Sets zu sein

% Erstelle Plot zur Visualisierung
figure('Name', 'RANSAC-Schaetzung')
imshow(img); 
hold on; 

for i = 1 : 1 : n_lines
    n_datapoints = length(pixellist(i).list(:,1)); 
    consensus_set = [0 0];
    
    for k = 1 : 1 : k_max
        
        % Mache einen random Sample
        rand_idx_1 = ceil(rand()*n_datapoints);
        rand_idx_2 = ceil(rand()*n_datapoints);
        
        random_sample_dataset = [pixellist(i).list(rand_idx_1, :); pixellist(i).list(rand_idx_2, :)];
        
        [n, c] = least_square_ransac_line(random_sample_dataset); 
        
        % Bestimme das zugehoerige Consensus-Set
        temp_consensus_set = determine_consensus_set(n, c, pixellist(i).list, epsilon);
        
        % Checke ob es ein besseres Consensus Set mit mehr Datenpunkten
        % gibt und ersetze dieses, falls das aktuelle Consensus-Set
        % groesser ist
        if length(temp_consensus_set(:,1)) > length(consensus_set(:,1)) 
            consensus_set = temp_consensus_set; 
        end
        
    end
    
    % Mache die Schaetzung der finalen Geraden durch das beste
    % Consensus-Set mit dem Least-Square-Schaetzer
    if length(consensus_set(:,1)) < 2
        disp('Kein zulaessiges Consensus-Set gefunden'); 
    else
        [n_i, c_i] = least_square_ransac_line(consensus_set); 
        % Bestimme Start- und Endpunkte der Schaetzung
        theta = atan2(n_i(2),n_i(1)); 
        [start_point, end_point] = calculate_start_end_point (consensus_set, theta, c);
    
        % Visualisiere das Ergebnis und die Datenpunkte des Consensus-Sets
        plot(consensus_set(:,1), consensus_set(:,2), 'cx');                             % Datenpunkte
        hold on; 
        plot([start_point(1), end_point(1)], [start_point(2), end_point(2)], 'r-o');    % Schaetzung
        hold on; 
    end
end

disp('Programm beendet');
