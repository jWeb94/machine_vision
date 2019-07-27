close all
clear
clc

%% Daten laden: 
load 'smileys_test.mat';        % test Daten: 111 'Bilder' mit jeweils 400 Pixeln -> 20 x 20 auf Zeilenvektor ausgerollt, da SVM nur Vektoren nehmen kann, nicht 2D Informationen
load 'smileys_train.mat';       % train Daten: 400 'Bilder' mit jeweils 400 Pixeln


%% Aufgabe 1: test_svm ausprobieren: 

% Trainiere eine SVM auf den gesamten Trainingsdaten (ohne k-Fold-Crossvalidation)
svm_test = fitcsvm( train, trainlabel, 'KernelFunction', 'rbf', 'KernelScale', 2.0, 'BoxConstraint', 5.0);

% Teste test_svm: 
[error_svm_test, confusion_matrix_svm_test] = test_svm(svm_test, test, testlabel); 

% Visualisiere Ergebnis: 
figure('Name', 'test_svm Test: '); 
heatmap({'Happy', 'Sad'}, {'Happy' 'Sad'}, confusion_matrix_svm_test); 
title('Confusion Matrix der besten SVM auf den Test Daten'); 
xlabel('Prädiktionen');
ylabel('Ground Truth Labels');
disp('Test-Error des SVM-Tests betraegt: '); 
error_svm_test



%% Aufgabe 2: k-fold validation zur Bestimmung der besten SVM

% Parameter fuer das Training: 
k = 5; 
c_vals = 10.^[-2:5];%2 : 0.1 : 4;
sigma_vals = 10.^[-2:5];%6 : 0.1 : 8;  


% k-fold Validation ist vorimplementiert: 
[ svm, cverror, confmat, cmin, sigmamin] = train_svm_cv (train, trainlabel, k, c_vals, sigma_vals); % beste SVM, validation error der besten SVM, Confusion Matrix der besten SVM, C-Parameter (Gewichtung/Bestrafug des Fehlers) der besten SVM, Sigma der besten SVM

% teste das ergebnis auf den Test-Daten nach dem Training
[test_error, test_conf_matrix] = test_svm(svm, test, testlabel); 

figure('Name', 'k-Fold-Validation'); 
heatmap({'Happy', 'Sad'}, {'Happy' 'Sad'}, test_conf_matrix); 
title('Confusion Matrix der besten SVM auf den Test Daten'); 
xlabel('Prädiktionen');
ylabel('Ground Truth Labels');

disp('Der Test-Error betraegt: '); 
test_error 

disp('Programm beendet'); 