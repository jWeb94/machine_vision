function [ labels prototypes ] = color_kmeans ( I, k )
%COLOR_KMEANS segments an image using k-means clustering
%   [ labels prototypes ] = color_kmeans ( I, k )
%   with I          the input image
%        k          the number of clusters
%        labels     an array that assigns to each pixel the segment number
%        prototypes an array with k rows. The i-th row represents 
%                   the prototype color of the i-th segment

% ANMERKUNG: 
% in labels ist das Ausgabebild mit den Eintragsmoeglichkeiten {0,...,k} ->
% Also der Index des zugeordneten Clusters


[rows cols cdepth] = size(I);
I1 = reshape (double(I), rows*cols, cdepth);

% repeat the clustering 3 times to avoid local minima
[cluster_idx prototypes] = kmeans(I1, k, 'distance','sqEuclidean', 'Replicates',3); 
    % Erklaerung kmeans-Befehl aus Matlab: 
    %
    %   ACHTUNG: k-Means in Matlab will nur einen liegenden Vektor aus Datenpunkten N x P (im Beispiel: N = rows*cols; P = Channels) -> Deshalb wird der reshape-Befehl notwendig
    %
    %   I1 = Input-Daten mit der Dimension N x P, wobei N = Anzahl der Datenpunkte und P = Anzahl der Komponenten die einen Datenpunkt beschreiben
    %   k = Anzahl der Clusterzentren
    %   'distance' = 'sqEuclidian' -> Euklidisches Abstandsmass der Datenpunkte (Pixelwerte) zu den ausgewaehlten Farben des Bildes (= zufaellig ausgewaehlte Centrodis beim ersten Aufruf; Centroids als Avg aller dem Cluster zugeordneten Datenpunkte beim n-ten Aufruf)
    %   'Replicates' = 3 -> Anzahl der Durchfuehrung des k-Means Algorithmus mit unterschiedlichen (zufaellig ausgewaehlten) Initialen Centroids
    %
    % prototypes = Positionen der berechneten Centroids
    % cluster_idx = Vektor mit den Clusterindices -> N x 1 Dimension
labels = reshape(cluster_idx, rows, cols);  % Zurueck Reshapen in Bildformat
end
