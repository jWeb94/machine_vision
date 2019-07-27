function [ svm, cverror, confmat, cmin, sigmamin] = train_svm_cv (train, trainlabel, k, c_vals, sigma_vals)
% train SVM with k-fold-crossvalidation; test various values for sigma and
% C and choose the best one
% [ svm cverror confmat cmin sigmamin] = train_svm_cv (training-patterns, training-labels, k, cvals, sigmavals)
%      svm: best svm trained on all training data
%      cverror: validation error of best svm
%      confmat: confusion matrix of best svm
%      cmin, sigmamin: parameters C and sigma of best svm
%      training-patterns: set of training patterns (array), each row
%           represents one pattern, each column one feature
%      training-labels: labels of training patterns (vector), one entry for
%           each pattern
%      k: perform k-fold cross-validation
%      sigmavals: a list of sigma values which should be tested
%      cvals: a list of C-values which should be tested

parameterlist = [];
n = length( trainlabel);


for ci = 1:length(c_vals)                   % Iteriere ueber C
    for si = 1:length(sigma_vals)           % Iteriere ueber Sigma
        try
            c=c_vals(ci);                   % Waehle das jeweilige C aus
            sigma=sigma_vals(si);           % Waehle das jeweilige Sigma aus
            % check C-value c and sigma-value sigma in this iteration
            confusionmatrix = [ 0 0; 0 0];
            validerror = 0;
            
            % bei k-fold werden die Trainings immer auf anderen Daten durch gefuehrt. 
            % Der Error und die Confusion Matrix bleibt aber gleich, da wir immer die gleichen 
            % Parameter verwenden und damit immer die gleiche SVM nur auf anderen Daten trainieren und validieren. 
            % So wird erreicht, dass wir quasi den gesamten Datensatz absichern!!!
            
            for kk=1:k                      
                % execute the k iterations of k-fold cross validation
                validindeces = round((kk-1)*n/k+1):round(kk*n/k);  % use the data with these indeces for validation -> S. 33 10_pattern_recognition.pdf: k-1/k ist der Anteil der Daten pro k Datensatz -> Daten: (k-1/k)*num_datapoints 
                trainindeces = 1:n;
                trainindeces(validindeces)=[];  % use the data with the remaining indeces for training -> Loesche alle Validierungsdatenindices aus den Trainingsdatenindices raus
                % train SVM on subset of trainingdata:
                svm = fitcsvm (train(trainindeces,:), trainlabel(trainindeces), 'DeltaGradientTolerance', 1e-06, 'KernelFunction', 'rbf', 'KernelScale', sigma, 'BoxConstraint', c);
                % calculate validation error:
                [ err cm ] = test_svm (svm, train(validindeces,:), trainlabel(validindeces));
                confusionmatrix = confusionmatrix + cm;
                validerror = validerror + length(validindeces)*err;
            end
            % store result for these parameters in parameterlist:
            parameterlist = [ parameterlist; c sigma validerror/length(train) confusionmatrix(1,1) confusionmatrix(1,2) confusionmatrix(2,1) confusionmatrix(2,2)];
        catch e
            disp(e.identifier);
            disp(e.message);
            disp(['Ignore parameters due to numerical problems. c=' num2str(c) ', sigma=' num2str(sigma)])
        end
    end
end
% search best parameterset in parameterlist:
parameterlist=sortrows (parameterlist, 3); % Sortierung nach drittem Element der parameterlist -> validation error
% retrain SVM on all trainingdata for best parameters: -> Nimm die
% Parameter der besten SVM aus k-fold + Parametervariation und trainiere
% eine SVM damit
svm = fitcsvm (train, trainlabel,'DeltaGradientTolerance', 1e-06, 'KernelFunction', 'rbf', 'KernelScale', parameterlist(1,2), 'BoxConstraint', parameterlist(1,1));

% Ausgaben der Funktion
cverror = parameterlist(1,3);
cmin = parameterlist(1,1);
sigmamin = parameterlist(1,2);
confmat = [ parameterlist(1,4) parameterlist(1,5); parameterlist(1,6) parameterlist(1,7)];
