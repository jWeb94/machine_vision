function [u v] = calculate_image_points_from_world_points(M, point)
    % p wird als stehender Vektor erwartet!
    p_addon = point; 
    p_addon(4) = 1; % Erweitern auf 4tes Element
    z = dot(M(3, :), p_addon);
    
    % Abrunden, da wir es mit diskreten Pixeln zu tun haben
    u = floor(dot(M(1, :), p_addon)/z); 
    v = floor(dot(M(2, :), p_addon)/z);
end