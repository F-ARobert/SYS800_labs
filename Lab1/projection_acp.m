function [T] = projection_acp(X, V)

% 1) Calcule et soustraction de la moyenne empirique
moyenne_empirique = mean(X);

% 2) Normalization des donn�es
B = X - ones(size(X,1),1)*moyenne_empirique;

% 3) Projections des donn�es
T = B*V;