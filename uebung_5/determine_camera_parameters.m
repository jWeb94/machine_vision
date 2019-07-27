function[resulting_parameters] = determine_camera_parameters(R, A, t)
    % Bestimmung der intrinsischen Kameraparameter (extrinsische Kameraparameter kommen direkt aus dem gegebenen Tsai-Ausgaben)

    % Berechne die Mapping-Matrix
    R_t = [R t];
    M = A*R_t;
    
    % Bestimme die Parameter nach S. 41 07_optics.pdf
    resulting_parameters.u_0 = dot(M(3, 1:3), M(2, 1:3)); 
    resulting_parameters.v_0 = dot(M(3, 1:3), M(1, 1:3));
    resulting_parameters.u_0_test = A(1, 3);                % ACHTUNG: Kann es sein, dass ein Fehler im Skript ist? Ich bekomme rum gedrehte Ergebnisse raus, wenn ich die intrinsischen Parameter aus A oder aus M berechne!
    resulting_parameters.v_0_test = A(2, 3);  
    
    
    temp_beta_sin = sqrt((sqrt(M(2, 1)^(2) + M(2, 2)^(2) + M(2, 3)^(2)))^(2) - resulting_parameters.v_0); 
    temp_beta_cot = temp_beta_sin^(-1)*(resulting_parameters.u_0*resulting_parameters.v_0 - dot(M(1, 1:3), M(2, 1:3)));
    
    resulting_parameters.alpha_s = sqrt((sqrt(M(1, 1)^(2) + M(1, 2)^(2) + M(1, 3)^(2)))^(2) + temp_beta_cot^(2) - resulting_parameters.u_0_test^(2)); % ACHTUNG: Richtiges Ergebnis nur mit den _test - Parametern
    resulting_parameters.alpha_s_test = A(1, 1); % vgl S. 8 07_optics.pdf 
    resulting_parameters.theta = rad2deg(acos(temp_beta_cot/temp_beta_sin));
    resulting_parameters.beta_s = temp_beta_sin*sin(deg2rad(resulting_parameters.theta)); 
end