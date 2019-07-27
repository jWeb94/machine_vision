function [resulting_point] = world_coordinates_from_image_coordinates(A, R, t, q, a, b, u, v)
    % Berechne die Weltkoordinaten aus den Bildkoordinaten
    % Schwierigkeit: 
    %   Die Abbildung von 2D in 3D ist nicht eindeutig! Beschreibung nur
    %   als Strahl der von der Kamera weg geht moeglich!
    % Loesung: 
    %   p + rho*d = q + lambda*a + mue*b
    %   , wobei p = Stuetzvektor Gerade; q = Stuetzvektor Ebene; a & b =
    %   Spannvektoren der Ebene.
    %   Alle Vektoren im Weltkoordinatensystem !!!
    % Umstellen nach den Parametern und mit Ebenengleichung den
    % Schnittpunkt = gesuchten Weltkoordinatenpunkt berechnen:
    % [lambda mue rho] = [a, b, -d]^(-1)*(p - q) 
    
    % Stelle Geradenvektoren aus bekannten Zusammenhaengen (vgl Skript S.
    % 10 ff. - 07_optics.pdf) auf: 
    p = -R'*t; % Ursprung des Kamerakoordinatensystems im Weltkoordinatensystem
    d = R'*inv(A)*[u; v; 1]; % *z
    
    % Bestimmung der Parameter
    parameters = [a, b, -d]^(-1)*(p - q); % [lambda , mue, rho]
    
    % Berechnung des Schnittpunkts -> Es ist egal ob ich dann die Ebene
    % oder die Gerade nehme!
    resulting_point = q + parameters(1)*a + parameters(2)*b; 
    resulting_point_test = p + parameters(3)*d; 
    
end