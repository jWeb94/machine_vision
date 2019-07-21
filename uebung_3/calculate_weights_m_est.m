function [w_update] = calculate_weights_m_est(datapoints, normal_vector, c, cost_term, k)
    % Berechne den Punkteabstand fuer alle Datenpunkte
    d = datapoints*normal_vector;
    d = d + c; 
    d_abs = abs(d); 
    
    % Berechne die neuen Gewichte auf Basis der Kostenfunktion
    if cost_term == 1% huber
        % DEBUG
        debug_1 = [d_abs<=k];
        debug_2 = [d_abs>k];
        debug_3 = (k/d_abs)'; 
        % [absd<=parameter]+[absd>parameter]*parameter./absd %
        % Musterloesung
        w_update = [d_abs<=k] + [d_abs>k]*k./d_abs;
    elseif cost_term == 2 % cauchy
        % (d.^2/(parameter*parameter)+1).^-1 % Musterloesung
        w_update = (d.^(2)/(k*k) + 1).^-1;    
    else
       disp('ERROR: wrong input for the cost term!'); 
    end
end