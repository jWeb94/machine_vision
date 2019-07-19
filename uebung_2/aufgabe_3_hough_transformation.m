close all
clear
clc


%% Aufgabe 3: Hough-Transformation

img = imread('postit2g.png'); 
img = im2double(img);           % Wir wollen mit Werten zwischen 0 und 1 arbeiten

% Wende Kantendetektor an, um ein Binaerbild aus Kanten und nicht-Kanten zu
% erhalten - Parameter aus Musterloesung
img_edge = edge(img, 'canny', [0.11 0.15], 2);  % Canny-Kantendetektor
% img_edge = edge(img, 'log', 0.0008, 3);       % LoG-Kantendetektor

% Abfrage der Parameter fuer die Hough-Transformation: 
num_lines = input('Wie viele Linien sollen dedektiert werden? (0...N Linien moeglich): '); 

% Wende die gegebene Hough-Transformation an: 
hough_result_struct = robust_hough(img_edge); 
lines_struct = robust_hough_lines(hough_result_struct, num_lines, img_edge);
robust_hough_plot_lines(img_edge, lines_struct);        % Keine Rueckgabeparameter

% Visualisiere den Hough-Raum: 
figure('Name', 'Hough-Raum');
imagesc(hough_result_struct.accumulator);
colormap hot;
hold on;
peaks = hough_result_struct.peaks(1:num_lines,:);
plot(peaks(:,2),peaks(:,1),'wo');
