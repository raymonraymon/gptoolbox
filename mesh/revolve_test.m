clc
clear
close all
dbstop if error    
% surface of revolution from .svg file
    [P,C,I,F,S,SW,D] = readSVG_cubics('../models/famoustiger.svg');
    P(:,2) = max(P(:,2))-P(:,2);
    P(:,1) = P(:,1)-520;
    [PR,CR] = flatten_splines(P,C,I,F,S,SW,D);
    [PR,~,J] = remove_duplicate_vertices(PR,1e-5);
    CR = J(CR);
    [PV,PE] = spline_to_poly(PR,CR,1);
    [V,F] = revolve(PV,PE,314);
    tsurf(F,V,'FaceColor',blue,falpha(0.7,0));axis equal;camlight;view(0,50);
    view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);