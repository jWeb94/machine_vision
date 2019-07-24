function[resulting_parameters] = determine_camera_parameters(R, A, t)
    % Berechne die Mapping-Matrix
    R_t = [R t];
    M = A*R_t;
    
    % Bestimme die Parameter nach S. 41 07_optics.pdf
    resulting_parameters.u_0 = dot(M(3, 1:3), M(2, 1:3)); 
    resulting_parameters.v_0 = dot(M(3, 1:3), M(1, 1:3));
    resulting_parameters.t(3) = M(3, 4); 
    resulting_parameters.rotation_matrix(3, 1:3) = M(3, 1:3); 
    
    temp_beta_sin = sqrt(abs(M(2, 1:3))^(2) - resulting_parameters.v_0); 
    
    resulting_parameters.t(2) = temp_beta_sin^(-1)*(M(2, 4) - resulting_parameters.v_0*resulting_parameters.t(3));
    resulting_parameters.t(2) = temp_beta_sin^(-1)*(M(2, 1:3) - resulting_parameters.v_0*resulting_parameters.rotation_matrix(3, 1:3)); 
    
    temp_beta_cot = temp_beta_sin^(-1)*(resulting_parameters.u_0*resulting_parameters.v_0 - dot(M(1, 1:3), M(2, 1:3)));
    resulting_parameters.alpha_s = sqrt(abs(M(1, 1:3))^(2) + temp_beta_cot^(2) - resulting_parameters.u_0^(2));
    resulting_parameters.rotation_matrix(1, 1:3) = resulting_parameters.alpha_s^(-1)*(M(1, 1:3) + temp_beta_cot*resulting_parameters.rotation_matrix(2, 1:3)- resulting_parameters.u_0*resulting_parameters.rotation_matrix(3, 1:3));
    resulting_parameters.t(1) = resulting_parameters.alpha_s^(-1) * (M(1, 4) + temp_beta_cot*resulting_parameters.t(2) - resulting_parameters.u_0*resulting_parameters.t(3));
    resulting_parameters.theta = acos(temp_beta_cot/temp_beta_sin);
    resulting_parameters.beta_s = temp_beta_sin*sin(resulting_parameters.theta); 
end