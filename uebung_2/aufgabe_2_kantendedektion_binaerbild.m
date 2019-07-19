close all
clear
clc

%% Aufgabe 2: Kantendedektion Binaerbild

img = imread('postit2g.png');
img = im2double(img);           % Wir wollen mit Werten zwischen 0 und 1 arbeiten

% Filterauswahl
filter_type = input('Waehlen Sie den Edge-Detector (1 fuer Canny, 2 fuer LoG): '); 
% Erzwinge korrekte Eingabe
while filter_type ~= 1 && filter_type ~= 2
    disp('Keine zulaessige Eingabe! Bitte geben Sie (1) fuer Canny oder (2) fuer LoG ein.');
    filter_type = input('Eingabe: '); 
end


% Erstelle Plot-Fenster
figure('Name', 'Edge Image'); 

% Kantendetektor
stop_flag = true;
if filter_type == 1
    % Canny Edges
    
    % Finale Konfiguration
     
    last_low_thresh = -1; 
    last_high_thresh = -1; 
    % Variablen Initialisierung
    last_sigma = -1; 
    low_thresh = -1; 
    high_thresh = -1; 
    sigma = -1; 
    
    % Iteration um die optimalen Parameter auszuprobieren
    while stop_flag
        % Konfiguration Musterloesung: 
        %  threshold = [0.05 0.15]
        %  sigma = 2
        
        last_low_thresh = low_thresh; 
        last_high_thresh = high_thresh; 
        last_sigma = sigma; 
        low_thresh = input('Gebe den unteren Threshold fuer die Kantenklassifikation fuer Canny ein: '); 
        high_thresh = input('Gebe den oberen Threshold fuer die Kantenklassifikation fuer Canny ein: '); 
        sigma = input('Gebe Sigma fuer das Bluring im Canny-Algorithmus ein: '); 
        edge_img = edge(img, 'canny', [low_thresh, high_thresh], sigma);  % img, method (= canny), threshold, sigma 
                                    % threshold ist ein 2-Elemente Vekor
                                    % mit [low_thresh, high_thresh] fuer
                                    % die minimalen/maximalen Gradienten,
                                    % bei denen die Kante als starke (über
                                    % max) oder als schwache (unter min)
                                    % Kante eingeteilt wird - Wertebereich:
                                    % 0 bis 1 
                                    %
                                    % sigma beschreibt die Varianz des
                                    % Gauss-Filters um Rauschen zu
                                    % verhindern. Die Abmasse des
                                    % Gauss-Kernels werden automatisch aus
                                    % Sigma bestimmt !
        
        
        imshow(edge_img); 
        stop_flag = input('Fertig? (true = nein, false = ja): ');  
    end
    
    
else % Muss 2 -> LoG sein, da ich mit keinem anderen Wert aus der While-Schleife raus komme
    % LoG-Edges
    % Musterloesung: 
    %   img_edge_log = edge(d_img, 'log', 0.0008, 3);
    thresh_log = -1; 
    sigma_log = -1; 
    last_thresh_log = -1; 
    last_sigma_log = -1; 
    
    while stop_flag
        last_sigma_log = sigma_log; 
        last_thresh_log = thresh_log; 
        
        thresh_log = input('Gebe den Threshold fuer den LoG-Kantendetektor ein (Alle Werte unterhalb des Thresholds werden nicht als Kanten betrachtet, sondern als Rauschen): ');
        sigma_log = input ('Gebe Sigma fuer den Laplace-of-Gaussian Kantendetektor ein: '); 
        
        edge_img_log = edge(img, 'log', thresh_log, sigma_log); 
        
        imshow(edge_img_log); 
        
        
        stop_flag = input('Fertig? (true = nein, false = ja): '); 
    end
    
    
end

disp('Programm beendet');

