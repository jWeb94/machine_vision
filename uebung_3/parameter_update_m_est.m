function [n, c] = parameter_update_m_est(pixellist, weights)
    
    w_ges = sum(weights); 

    alpha = sum(weights.*(pixellist(:,1)).^(2)) - (1/w_ges)*(sum(weights.*pixellist(:,1))).^(2); 
    beta = sum(weights.*pixellist(:,1).*pixellist(:,2)) - (1/w_ges)*sum(weights.*pixellist(:,1))*sum(weights.*pixellist(:,2));
    gamma = sum(weights.*(pixellist(:,2)).^2) - (1/w_ges)*((sum(weights.*pixellist(:,2))).^(2));
    
    A = [alpha beta; beta gamma]; 
    n = zeros(2,1); 
    
    % Loesung des Eigenwertproblems
    [vectors values] = eig(A);
        % In der Matrix values sind die Eigenwerte in den Diagonalelementen
        % In der Matrix vectors sind die Eigenvektoren spaltenweise!
        % Korrespondenzen: values(1,1) -> vectors(:,1); values(2,2) -> vectors(:,2)
    
    % Waehle den kleineren Eigenwert und zugehoerigen Eigenvector aus -
    % dieser minimiert den Abstand. Der groessere Eigenwert wuerde den
    % Abstand maximieren
    if values(1, 1) < values(2,2)
        n = vectors(:,1);
    else
        n = vectors(:,2); 
    end
        
    % Berechnung Theta als Winkel in der hesseschen Normalform
    % theta = atan2(n(2),n(1)); % Wir arbeiten mit n stellvertretend fuer
    % theta

    
    
    % Berechnung c
    c = -sum(pixellist*n)/length(pixellist(:,1)); % vgl Formel im Skript
    
    
end