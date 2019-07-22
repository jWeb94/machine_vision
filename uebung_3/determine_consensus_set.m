function [consensus_set] = determine_consensus_set(n, c, dataset, epsilon)
    % Berechne Abstand zur geschaetzten Geraden
    d_unsorted = dataset*n;
    d_unsorted = d_unsorted + c; 
    d_unsorted = abs(d_unsorted); % Mich interessiert nur der betragsmaessige Abstand, das Vorzeichen ist egal! Ich will nur die mit dem groessten betragsmaessigen(!) Abstand raus werfen!
    
    % Sortiere die Datenpunkts
    temp_dataset = [d_unsorted, dataset];
    dataset_sorted = sortrows(temp_dataset); % Sortiert zeilenweise nach dem Wert der ersten Spalte vom kleinsten Wert zum groessten Wert!
    
    % Bestimme die zu-verwendenden Datenpunkte
    max_idx_sorted = 1; 
    for i = 1 : 1 : length(dataset_sorted(:,1))
        if dataset_sorted(i,1) > epsilon
            max_idx_sorted = i;
            break; % Beende die Schleife
        end
    end
    
    consensus_set = dataset_sorted(1:max_idx_sorted, 2:3);  
end