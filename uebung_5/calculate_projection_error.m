function [avg_error] = calculate_projection_error(real_points, est_points)
    
    % Sicherheitsabfrage
    if length(real_points(:, 1)) ~= length(est_points(:, 1)); 
        disp('ERROR: Falsche Eingabe in die mittlere Fehlerberechnung!'); 
    end
    
    % Berechnung der Summe
    sum_error = 0; 
    for i = 1 : 1 : length(real_points(:, 1))
        sum_error = sum_error + sqrt((real_points(i, 1) - est_points(i, 1))^(2) + (real_points(i, 2) - est_points(i, 2))^(2));
    end
    
    avg_error = sum_error/length(real_points(:, 1)); 
    
end 