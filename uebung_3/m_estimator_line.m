function [theta, c] = m_estimator_line(pixellist, num_iterations, k)
    % Nimm zufaelligen Punkt um die Parameter zu schaetzen: 
    num_points = length(pixellist); 
    rand_idx_1 = ceil(rand()*num_points); 
    rand_idx_2 = ceil(rand()*num_points); 
    if rand_idx_1 > num_points || rand_idx_2 > num_points
        disp('ERROR: rand_idx out of bound.'); 
        return;
    end
    
    % Berechne den initial Guess zur Bestimmung des ersten Parametersatzes:
    [n, c] = calculate_initial_guess(pixellist(rand_idx_1, :), pixellist(rand_idx_2, :));
    
    for i = 1 : 1 : num_iterations
       %Berechne Gewichte
       %
       % cost_term: 1 = Huber; 2 = Cauchy
       %weights = calculate_weights_m_est(pixellist, n, c, 1, k); %datapoints, normal_vector, c, cost_term, k
       weights = calculate_weights_m_est(pixellist, n, c, 2, k);
       
       % Berechne Schaetzung
       [n, c] = parameter_update_m_est(pixellist, weights);
       
    end
    theta = atan2(n(2),n(1)); 
end