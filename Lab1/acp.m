function [V, G] = acp(X, thres)

% 1) Calcule et soustraction de la moyenne empirique

moyenne_empirique = mean(X);

B = X - ones(size(X,1),1)*moyenne_empirique;

% 2) Calcule de la covariance
C = cov(B);

% 3) Calcule des vecteurs propres et des valeurs propres
[V, D] = eig(C);

lambda = diag(D);

% Triage des vecteurs propres selon l'ordre des valeurs propres du plus
% grand au plus petit
[lambda, ind] = sort(lambda, 'descend');
V = V(:,ind);

% Calcule du contenue d'energy cumulative de chaque vecteurs propre
G = cumsum(lambda)/sum(lambda)*100;

% Seuillage juste audessus du seuil%
nb_dim = length(G) - length(G(G >= thres)) + 1;

% Reduction du nombre de dimension
V = V(:,1:nb_dim);

% % Calcule des valeurs projetées
% T = B*V;
