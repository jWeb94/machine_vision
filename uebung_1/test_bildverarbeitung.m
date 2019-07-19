clear
clc

%% Test Code, um die Funktionen fuer Aufgabe 6 nachzuvollziehen

test_img = [3, 212, 22, 55, 6; 121, 44, 232, 76, 5; 33, 98, 46, 23, 112; 66, 21, 77, 49, 10; 99, 188, 121, 32, 77]

sprintf("Test des min-Operators auf einer Matrix: ")
test_min_1 = min(test_img)
sprintf("Jeder Eintrag ist der spaltenweise kleinste WERT (!) der Matrix")

sprintf("Kleinster Wert des gesamten Bildes: ")
min_grey_val = min(min(test_img))

% Analog mit dem max-Operator:
sprintf("Der maximale Wert im Bild ist: ")
max_grey_val = max(max(test_img))