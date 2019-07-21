function [start_point, end_point] = calculate_start_end_point (pixellist, theta, c)
    % Berechne die Start- und Endpunkte der Geraden aus den geschaetzen Parametern der
    % Geraden
    n = [cos(theta); sin(theta)]; 
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

    start_point = (1 - tau_min)*p + tau_min*q;
    end_point = (1 - tau_max)*p + tau_max*q;  
end