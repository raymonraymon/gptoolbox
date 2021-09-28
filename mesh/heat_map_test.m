close all
clc
clear
% build heat map
    [M,C] = heat_map(256);
%     [V,F] = subdivided_sphere(3);
%     drawMesh(V,F);
    % set colormap in current figure
    colormap(M);
    % set color axis in current figure
    caxis(C);