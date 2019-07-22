function [n, c] = least_square_ransac_line(pixellist)
    alpha = sum((pixellist(:,1)).^(2)) - (1/length(pixellist(:,1)))*(sum(pixellist(:,1))).^(2); 
    beta = sum(pixellist(:,1).*pixellist(:,2)) - (1/length(pixellist(:,1)))*sum(pixellist(:,1))*sum(pixellist(:,2));
    gamma = sum((pixellist(:,2)).^2) - (1/length(pixellist(:,1)))*((sum(pixellist(:,2))).^(2));
    
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
    %theta = atan2(n(2),n(1)); % Winkel des Normalenvektors - Formel aus dme Skript
        % ACHTUNG:  atan gibt Werte (in Radiant) zwischen +- 90 Grad aus
        %           atan2 gibt Werte (in Radiant) zwischen +- 180 Grad aus
        % ACHTUNG: Wir arbeiten mit n (Normalenvektor), stellvertretend
        % fuer Theta
    
    % Berechnung c
    c = -sum(pixellist*n)/length(pixellist(:,1)); % vgl Formel im Skript
end