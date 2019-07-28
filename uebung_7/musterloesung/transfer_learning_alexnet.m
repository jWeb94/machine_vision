clear all;

labeled_image_dir = '/home/jens/Schreibtisch/machine_vision/uebung/git_jens/uebung_7/Images_scaled'; % HHier liegen die Trainingsdaten

labeledImages = imageDatastore(labeled_image_dir,...
    'IncludeSubfolders',true,...
    'LabelSource','foldernames');
    % Erstellt ein Datareader-Objekt, das alle Daten enthaelt, statistiken
    % ueber die Labels erstellen kann und die Daten zufaellig geshuffelt an
    % das Netz uebergeben kann

[trainingImages, validationImages] = splitEachLabel(labeledImages,0.85,'randomized');
    % Aufteilung in Train- und Test-Set

net = alexnet;  % Lade vortrainiertes Netz

layersTransfer = net.Layers(1:end-3); % nimm alle vortrainierten Layer bis auf die letzten 3

numClasses = numel(categories(trainingImages.Labels));
    % numel -> Anzahl der Elemente im Array (egal wie sie angeordnet sind, die Funktion zaehlt einfach nur)
    % categories -> erstellt Cell-Array aus dem Datentyp categorical
    % trainingImages.Labels enthaelt ein categorical Array
    
layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];
    % Liste aller moeglichen Layer in Matlab: https://de.mathworks.com/help/deeplearning/ug/list-of-deep-learning-layers.html
    % ACHTUNG: layers ist im Resultat ein eignener Datentyp, der das
    % Untereinanderschreiben (OHNE KOMMA) der Layer erfordert!
    %
    % fullyConnectedLayer(AnzahlNeuronen, 'WeightLearnRateFactor' -> Multiplikator, der layerspezifisch auf die Lernrate multipliziert wird, um zu steuern wie stark der Layer trainiert werden soll, 'BiasLearnRateFactor' -> Analog nur fuer Bias-Vektor)
    % Per Default sind die layerspezifischen Lernraten bei 1 (entsprechen also dann der globalen Lernrate)
    
    
miniBatchSize = 100; % Number of training examples in each fw/bw-pass -> Anzahl der Bilder auf denen der Loss pro Iteration berechnet wird. Ist quasi eine Regularisierungstechnik, da wir den Fehler ueber mehrere Bilder berechnen und darauf trainieren

numIterationsPerEpoch = floor(1/2*numel(trainingImages.Labels)/miniBatchSize); %validate twice per epoch -> trainingImages.Labels listet alle Labels auf, also das Ergebnis aller Trainingsdaten im Datensatz
                                                                               % (1/2*AnzahlTrainingsdaten)/miniBatchSize -> Anzahl der Iterationen bis die haelfte aller Daten 1x trainiert wurden/ans Netz uebergeben wurden
options = trainingOptions('sgdm',...
    'CheckpointPath', '/home/jens/Schreibtisch/machine_vision/uebung/git_jens/uebung_7/musterloesung', ... %change to an existing folder -> Hier werden Zwischenpunkte gespeichert um das Training, falls es abbricht, nicht komplett neu zu starten
    'MiniBatchSize',miniBatchSize,...
    'MaxEpochs',30,...
    'InitialLearnRate',1e-4,... %prevent large changes to old layers
    'Verbose',false,...
    'ValidationData', validationImages,...  % Validierungsdatensatz uebergeben
    'Plots','training-progress',...
    'ValidationFrequency',numIterationsPerEpoch); % Validierungsfrequenz

netTransfer = trainNetwork(trainingImages,layers,options); % Training
                                                           % Checkpoints
                                                           % werden nach
                                                           % jeder Epoche
                                                           % mit einem
                                                           % eindeutigen
                                                           % Namen
                                                           % gespeichert
