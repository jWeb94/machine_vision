close all
clear
clc

%% Aufgabe 1: Gradientenbilder

% Lade Bild
img = imread('postit2g.png');   % Werte zwischen 0 und 255, Datentyp uint8
img = im2double(img);           % Werte zwischen 0 und 1, Datentyp double -> auch negative Werte moeglich!
% Filterauswahl
filter_type = input('Waehlen Sie den Filter (1 fuer Sobel, 2 fuer Prewitt): '); 
% Erzwinge korrekte Eingabe
while filter_type ~= 1 && filter_type ~= 2
    disp('Keine zulaessige Eingabe! Bitte geben Sie (1) fuer Sobel oder (2) fuer Prewitt ein.');
    filter_type = input('Eingabe: '); 
end

% Erstelle Filter
filter_u = zeros(3); % 3x3 Matrix mit 0 initialisiert als Default-Wert
filter_v = zeros(3);

if filter_type == 1 % Sobel
   filter_u = [1 0 -1; 2 0 -2; 1 0 -1];  
   filter_u = (1/8)*filter_u;  
   filter_v = filter_u'; 
   
   % Oder mit fspecial: 
   %filter_u = fspecial('sobel');
   %filter_v = filter_u'; 
    
else % Prewitt
   filter_u = [1 0 -1; 1 0 -1; 1 0 -1]; 
   filter_u = (1/6)*filter_u; 
   filter_v = filter_u'; 

   % Oder mit fspecial
   %filter_u = fspecial('prewitt'); 
   %filter_v = filter_u'; 
end

filter_u = im2double(filter_u); 
filter_v = im2double(filter_v); 

% Gradientenbild erstellen und anzeigen: 
g_u = conv2(img, filter_u); 
g_v = conv2(img, filter_v); 
    % Anmerkung: Da wir ueber im2double die Werte auf 0 bis 1 beschraenken
    % und der Ableitungsfilter den Werteberech durch die Normalisierung
    % nicht veraendert, entsteht das Gradientenbild im Wertebereich
    % zwischen -1 und 1 (negative Werte sind moeglich durch Hell->Dunkel Uebergang + Double Datentyp)
    
% Debug
max_g_u = max(max(g_u)); 
max_g_v = max(max(g_v)); 
min_g_u = min(min(g_u)); 
min_g_v = min(min(g_v)); 

% ANMERKUNG: Wenn man Werte zwischen -1 und 1 in imshow rein gibt (wie es
% bei g_u und g_v der Fall ist), rechnet imshow im Hintergrund abs(g_u) und
% setzt den Anzeigewertebereich auf [0 1]! Dadurch werden die Kanten weiss
% angezeigt und alles andere schwarz! Normal muesste 0 grau sein und -1
% (bzw -255) schwarz und 1 (bzw +255) weiss!
figure('Name', 'Ableitung in u-Richtung'); 
imshow(g_u); 
% figure('Name', '0 entspricht grau'); 
% imshow(g_u, [-1 1])
figure('Name', 'Ableitung in v-Richtung'); 
imshow(g_v)

% Gradientenbetrag: 
M = (g_u.^2 + g_v.^2).^(1/2);           % Bildet auf Werte zwischen 0 und 1 ab, da ^2 alle Werte ins Positive drueckt und <1*<1 immer <1 bleibt
figure('Name', 'Gradientenbetrag'); 
imshow(M); 

% Debug
% max_M = max(max(M)); 
% min_M = min(min(M)); 

% Winkel des Gradienten: 
angle_img = atan2(g_v, g_u); % Werte von -pi bis pi -> Keine uebliche Farbdarstellung moeglich zum Interpretieren -> versuche auf vollstaendigen Wertebereich abzubilden um gut visualisieren zu koennen
angle_img= (angle_img/(2*pi) + 0.5);    % Skalliere auf Werte zwischen 0 und 1, um als 'normales' Grauwertimage darzustellen 

figure('Name', 'Gradientenwinkel'); 
imshow(angle_img, 'Colormap', hsv);     % In HSV-Farben darstellen, damit das etwas schoener und anschaulicher aussieht


disp('Programm beendet'); 