function [ error, confusionmatrix] = test_svm( svm, patterns, labels )
%TEST_SVM calculate relative test error of a svm on a testset
%[ error confusionmatrix ] = test_svm( svm, patterns, labels )
%   where:
%     'error' refers to the relative classification error
%     'confusionmatrix' refers to the confusion matrix
%     'svm' contains the support vector machine
%     'patterns' (matrix) contains the test patterns, one pattern per row
%     'labels' (vector) contains the true labels of the patterns

% Wende svm auf den uebergebenen Datensatz an: 
pred = predict (svm, patterns);

% Bestimmung der Klassifikationsergebnisse ~ In der Musterloesung
% effizienter implementiert!
tp = 0; 
tn = 0; 
fp = 0; 
fn = 0; 

for i = 1 : 1 : length(pred)
   if  pred(i) == labels(i) && pred(i) == 1
       tp = tp + 1; 
   elseif pred(i) == labels(i) && pred(i) == -1
       tn = tn + 1; 
   elseif pred(i) ~= labels(i) && pred(i) == 1
       fp = fp + 1; 
   elseif pred(i) ~= labels(i) && pred(i) == -1
       fn = fn + 1; 
   else
       disp('ERROR: Keine zulaessige Praediktion')
   end
end

error = (fn + fp)/length(pred);     % (fn+fp)/n
confusionmatrix = zeros (2,2);      % Zeilen = labels; Spalten = Praediktionen
confusionmatrix(1, 1) = tp;  
confusionmatrix(2, 2) = tn; 
confusionmatrix(1, 2) = fn; 
confusionmatrix(2, 1) = fp; 
%   Aufbau Confusion Matrix - fuer binaere Klassifikation
%               Praediktionen
%               +1      -1 
%           +1  tp      fp
% Labels
%           -1  fn      tn

% normalized_confusion_matrix(1, 1) = confusion_matrix(1, 1)/sum(confusion_matrix(1, :)); 
% normalized_confusion_matrix(1, 2) = confusion_matrix(1, 2)/sum(confusion_matrix(1, :)); 
% normalized_confusion_matrix(2, 1) = confusion_matrix(2, 1)/sum(confusion_matrix(2, :));
% normalized_confusion_matrix(2, 2) = confusion_matrix(2, 2)/sum(confusion_matrix(2, :));
% 
% disp('normalized_confusion_matrix: '); 
% normalized_confusion_matrix

end