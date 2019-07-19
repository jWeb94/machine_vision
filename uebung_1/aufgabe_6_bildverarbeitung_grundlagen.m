clear
clc
close all

%% Aufgabe 6: Bildverarbeitung Grundlagen

%% Einfache Analyse

% Lade das Bild und zeige es an: 
img = imread('kabel_salat.png'); 
figure('Name', 'Bildanzeige')
imshow(img); 

% Berechne size, minimaler Grauwert, maximaler Grauwert, mittlerer Grauwert

% size:
[rows_img, cols_img] = size(img); 
disp("Die Groesse des Bilder (Zeilen, Spalten) ist: ")
rows_img
cols_img

% minimaler- und maximaler Grauwert
min_grey = min(min(img));   % min gibt fuer eine Matrix einen Vektor mit den Spaltenweise kleinsten 
                            % Elementen (WERT (!)) der Matrix zurueck. 
                            % Wendet man den min-Operator auf einen Vektor
                            % an, bekommt man den kleinsten WERT (!) des
                            % Vektors

max_grey = max(max(img)); 
disp("Der minimale- und maximale Grauwert des Bildes ist: ")
min_grey
max_grey

% mittlerer Grauwert
mean_grey = mean(mean(img)) % Analog zur min/max Berechnung: Matrix ergibt die spaltenweisen, mittleren Grauwerte
                            % Vektor ergibt den Mittelwert des Vektors
disp("Der mittlere Grauwert des Bildes ist: ")
mean_grey


%% Filtern des Bildes: 

% definiere Filterkernel
filterkernel_gaussian = fspecial('gaussian', 11, 4); % 'filtertyp', Groesse Kernel (1 Wert: nxn; Vektor: [w, h]), Sigma

% filtere Bild
filtered_img = imfilter(img, filterkernel_gaussian, 'conv'); % Gib 'conv' als Option an, da Matlab per Default eine Korrelation durchfuehrt! (vgl Robotik 1)
                                                             % Im Falle
                                                             % eines
                                                             % symetrischen
                                                             % Filters ist
                                                             % das aber
                                                             % quasi egal
figure('Name', 'Gauss-gefiltertes Bild')                                                             
imshow(filtered_img)                                                             


%% Wiener Deconvolution: 

deconv_img = deconvwnr(filtered_img, filterkernel_gaussian, 0.1);
figure('Name', 'Wiener Deconvolution')
imshow(deconv_img)



disp('Variation Sigma fuer die Wiener Deconvolution. Das SNR der letzten Eingabe wird verwendet. Abbruch mit Eingabe von 666')
sigma = 4; 
last_sigma = 0; 
figure('Name', 'Variation Sigma')
while sigma >= 0 && sigma < 666
    last_sigma = sigma; 
    sigma = input('Bitte Sigma fuer die Gauss-Filtermaske eingeben:');
    temp_kernel = fspecial('gaussian', 11, sigma);
    sigma_test_img = deconvwnr(filtered_img, temp_kernel, 0.01); 
    imshow(sigma_test_img); 
end


figure('Name', 'SNR-Test'); 
snr = 0.1; % Startwert
snr_test_img = deconv_img; 
last_snr = 0; % Um den letzten Wert zu merken
disp('Variation des Signal-to-Noise Ratios. Abbruch mit Eingabe von -1!')
while snr >= 0
   last_snr = snr; 
   snr = input("Bitte Signal-to-Noise Ratio eingeben: ");
   snr_test_img = deconvwnr(filtered_img, filterkernel_gaussian, snr); 
   imshow(snr_test_img); 
end
disp('Variation des Signal-to-Noise Ratio beendet')


disp('Variation Sigma beendet. Die finalen Parameter sind: ')
last_sigma
last_snr




