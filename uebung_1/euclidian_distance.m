%% Aufgabe 5: Schreibe eine Funktion, die den euklidischen Abstand von zwei Vektoren berechnet

function [result]=euclidian_distance(u, v)
    result = sqrt(sum((u-v).^(2)));
end