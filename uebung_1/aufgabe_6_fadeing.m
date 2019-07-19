close all
clear
clc

%% Aufgabe 6: Fadeing und Wiener Deconvolution

img = imread('kabel_salat.png');

% Bluring
gaussian_kernel = fspecial('gaussian', 11, 4); 
blured_img = imfilter(img, gaussian_kernel, 'conv'); 

figure('Name', 'Blured Image');
imshow(blured_img); 


% Fade Out
faded_img = fadeout(blured_img, 100); % 100 Pixel vom Rand aus gesehen werden gefaded
figure('Name', 'Fade Out Image');
imshow(faded_img); 

% Deconvolution

% Startwerte
snr = 0.1; 
sigma_deconv = 2.5;
last_snr = 0; 
last_sigma = 0; 
deconv_filter = fspecial('gaussian', 11, sigma_deconv);

disp('Variation des Signal-to-Noise Ratio. Abbruch mit Eingabe von -1.'); 
figure('Name', 'Deconvoluted Image'); 
while snr > 0
    last_snr = snr; 
    snr = input('Gebe Signal-to-Noise Ratio an: ');    
    deconv_img = deconvwnr(faded_img, deconv_filter, snr); 
    imshow(deconv_img); 
end
disp('Ende der Variation fuer SNR.')


disp('Variation Sigma. Abbruch mit Eingabe von 666.')
figure('Name', 'Variation Sigma')
while sigma_deconv > 0 && sigma_deconv < 666
    last_sigma = sigma_deconv; 
    sigma_deconv = input('Gebe Sigma fuer die Wiener Deconvolution ein: '); 
    deconv_filter_variation_sigma = fspecial('gaussian', 11, sigma_deconv);
    deconv_img = deconvwnr(faded_img, deconv_filter_variation_sigma, last_snr); 
    imshow(deconv_img); 
end
disp('Ende der Variation fuer Sigma')

disp('Die resultierenden Parameter sind: ')
last_sigma 
last_snr

final_deconv_filter = fspecial('gaussian', 11, last_sigma); 
final_img = deconvwnr(faded_img, final_deconv_filter, last_snr); 
figure('Name', 'Finales Deconvolution Image'); 
imshow(final_img); 

disp('Programm beendet')