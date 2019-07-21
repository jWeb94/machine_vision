function [normal_vector, c] = calculate_initial_guess(p, q)
    % Die Funktion erwartet 2 zufaellig aus dem Daten der zu-schaetzenden
    % Linie ausgewaehlte Punkte
    %
    % Berechne eine Linie aus 2 Punkten, um den initial Guess fuer die
    % Geradenparameter (n stellvertretend fuer theta und c) zu bestimmen.
    
    direction_vector = p - q;
    normal_vector = 1/(sqrt(direction_vector(1)^2 + direction_vector(2)^2)).*[-direction_vector(2); direction_vector(2)];
    c = -dot(normal_vector, p); 
    
end