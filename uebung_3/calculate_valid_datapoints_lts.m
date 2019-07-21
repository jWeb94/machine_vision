function [valid_datapoints] = calculate_valid_datapoints_lts(n, c, datapoints, percentage) 
    
    % Berechne den Abstand
    d_unsorted = datapoints*n;
    d_unsorted = d_unsorted + c; 
    d_unsorted = abs(d_unsorted); % Mich interessiert nur der betragsmaessige Abstand, das Vorzeichen ist egal! Ich will nur die mit dem groessten betragsmaessigen(!) Abstand raus werfen!
    
    % Sortiere die Datenpunkts
    temp_dataset = [d_unsorted, datapoints];
    dataset_sorted = sortrows(temp_dataset); % Sortiert zeilenweise nach dem Wert der ersten Spalte vom kleinsten Wert zum groessten Wert!
    
    % Bestimme die zu-verwendenden Datenpunkte
    num_valid_points = floor(percentage*length(datapoints(:,1)));
    valid_datapoints = dataset_sorted(1:num_valid_points, 2:3); % Nur die zweite Spalte, da wir nur die Datenpunkte (nicht die Abstaende) fuer die Parameterschaetzung brauchen 
    
end