clear 
clc

%% Aufgabe 3: Zahlensequenzen

% Erstelle eine Sequenz von -3 bis 5 in 0.1 Schritten: 
seq_1 = -3:0.1:5;

% Erstelle eine logarithmische Sequenz mit Hilfe der "Elementwise Power
% Function":
temp_seq = -3:1:5; 
seq_log = 10.^temp_seq;
% Alternativ: 
seq_log_alternative = 10.^([-5:1:3]);

% Berechne die angegebene Summe, in dem man eine aufsteigende und eine
% absteigende Sequenz erstellt: 

% Eigene Loesung: Keine absteigende Sequenz verwendet!
%k = 0:1:100; 
%u = k; 
%v = u'; 
%result = sum(k.*101)-u*v; 

% Musterloesung: 
result = [1:1:100]*[100:-1:1]';

sprintf("Berechnung der Folge mit gegenlaeufigen Sequenzen: ")
result

% Gegenrechnen:
sum  = 0; 
for k = 1:1:100
    sum = sum + (k*(101-k));  
end 
sprintf("Gegengerechnet mit for-Schleife:")
sum
