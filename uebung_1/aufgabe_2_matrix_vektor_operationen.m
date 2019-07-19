clear
clc

%% Matrix-Vektor Berechnung:

% Definitionen
A = [3, 5, 1; 2, 0, 1; -1, 1, 0];
b = [-2; 1; -4]; 

% Berechnung
sprintf("Berechnung fuer c: ")
c = inv(A)*b 

sprintf("Groesse der Matrix: ")
[rows, cols] = size(A)

sprintf("Aufgabe 2 beendet")
