function [distance] = calculate_distance(theta, c, point)
    n = [cos(theta), sin(theta)]; 
    distance = abs((n*point + c)); 
end