function [u, v] = calculate_hesse_points(theta, c, heigh, width)
    
    % Parameterform einer Geraden: 
    n = [cos(theta), sin(theta)]; 
    support_vector = -c*n; 
    direction_vector = [n(2), -n(1)]; 
    r = -1000:1:1000;
    u_temp = floor(support_vector(1)+r*direction_vector(1)); 
    v_temp = floor(support_vector(2)+r*direction_vector(2));
   
   % Initialisiere Ergebnisvektoren
    u = [];
    v = [];
    % Suche zulaessige Punkte im Ergebnis
    for i = 1 : 1 : length(r)
       if u_temp(i) >= 1 && u_temp(i) <= width && v_temp(i) >= 1 && v_temp(i) <= heigh
           u = [u, u_temp(i)];
           v = [v, v_temp(i)];
       end
    end 

%       FRAGE: Warum geht das so nicht?
%
%     % DEBUG/TEST: Mit hessescher Normalform
%     u_temp = 1 : 1 : width;  
%     v_temp = floor((c-u_temp*cos(theta))/sin(theta)); 
%     u = [];
%     v = [];
%     % Suche zulaessige Punkte im Ergebnis
%     for i = 1 : 1 : width
%        if u_temp(i) >= 1 && u_temp(i) <= width && v_temp(i) >= 1 && v_temp(i) <= heigh
%            u = [u, u_temp(i)];
%            v = [v, v_temp(i)];
%        end
%     end 
end