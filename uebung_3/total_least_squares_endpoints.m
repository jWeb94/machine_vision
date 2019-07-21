function [startpoint endpoint] = total_least_squares_endpoints(pixellist)
    % Bestimme die Schaetzermatrix
    alpha = sum((pixellist(:,1)).^(2)) - (1/length(pixellist(:,1)))*(sum(pixellist(:,1))).^(2); 
    beta = sum(pixellist(:,1).*pixellist(:,2)) - (1/length(pixellist(:,1)))*sum(pixellist(:,1))*sum(pixellist(:,2));
    gamma = sum((pixellist(:,2)).^2) - (1/length(pixellist(:,1)))*((sum(pixellist(:,2))).^(2));
    
    A = [alpha beta; beta gamma]; 
    
    % Loesung des Eigenwertproblems
    n = zeros(2,1); 
    [vectors values] = eig(A);
    if values(1, 1) < values(2,2)
        n = vectors(:,1);
    else
        n = vectors(:,2); 
    end
    theta = atan2(n(2),n(1)); % Winkel des Normalenvektors - Formel aus dme Skript
        % ACHTUNG:  atan gibt Werte (in Radiant) zwischen +- 90 Grad aus
        %           atan2 gibt Werte (in Radiant) zwischen +- 180 Grad aus
    
    
    % Berechnung c
    c = -sum(pixellist*n)/length(pixellist(:,1)); % vgl Formel im Skript
    
    % Baue Geraden auf in Parameterform auf: 
    support_vector = -c*n; 
    direction_vector = [-n(2); n(1)];
    
    % Bestimme Model (vgl S. 6 04_Curvefitting)
    p = support_vector; 
    q = support_vector + 1000*direction_vector; % Beliebiger zweiter Punkt auf der Gerade
    
    tau = [];
    for i = 1 : 1 : length(pixellist(:,1))
        tau = [tau, dot((p-(pixellist(i, :))'), (p-q))/(dot((p-q),(p-q)))];
    end
    
    tau_min = min(tau); 
    tau_max = max(tau); 

    startpoint = (1 - tau_min)*p + tau_min*q;
    endpoint = (1 - tau_max)*p + tau_max*q; 
    
%     % Test Code aus Musterloesung: 
%     tau = pixellist*direction_vector; 
%     
%     tau_min = min(tau); % Startpunkt -tau
%     tau_max = max(tau); % Endpunkt - tau
%     
%     startpoint = support_vector + tau_min*direction_vector;
%     endpoint = support_vector + tau_max*direction_vector; 
end