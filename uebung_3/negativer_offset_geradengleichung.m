close all
clear
clc

%% Test: Wie sieht eine Gerade mit negativem Offset aus?

offset = -240;
theta = 2.465;

n = [cos(theta), sin(theta)]; 
support_vector = offset*n; 
direction_vector = [-n(2), n(1)];

figure('Name', 'Stuetz-Vektor')
plot(support_vector(1), support_vector(2), 'cx');
figure('Name', 'Richtungsvektor')
plot(direction_vector(1), direction_vector(2),'rx'); 

r = -1000:0.01:1000; 
x = support_vector(1) + r * direction_vector(1);
y = support_vector(2) + r * direction_vector(2); 
figure('Name', 'Gerade'); 
plot(x, y); 
