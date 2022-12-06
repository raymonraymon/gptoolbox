close all
clc
clear

% [x,y] = meshgrid(1:15,1:15);
% tri = delaunay(x,y);
% z = peaks(15);
% T = trisurf(tri,x,y,z);
[V,F]=subdivided_sphere(2);
E=edges(F);
[A,AE] = adjacency_incident_angle_matrix(V,E);