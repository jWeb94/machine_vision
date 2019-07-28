clc; clf; clear all;
camera = webcam;    % Initialisiere Webcam als Objekt
nnet = alexnet;     % Lade AlexNet 
while true          % Endlosschleife -> webcam macht dauerhaft Bilder und diese werden klassifiziert
    picture = snapshot(camera);                 % Generiere ein Bild durch die Webcam
    picture = imresize(picture, [227, 227]);    % resize, um das Bild auf die Eingabegroesse des AlexNets anzupassen (keine variablen Input-Daten-Dimensionen mit MatLab moeglich!)
    label = classify(nnet, picture);            % Inferenz mit AlexNet
    image(picture);                             % Anzeige der Klassefikation und Bild
    title(char(label));
    drawnow;
end