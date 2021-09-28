close all
clc
clear

% [x,y] = meshgrid(1:15,1:15);
% tri = delaunay(x,y);
% z = peaks(15);
% T = trisurf(tri,x,y,z);
[V,F]=subdivided_sphere(2);
T=drawMesh(V,F, 'FaceVertexCData',V(:,1),'facecolor','interp', 'edgecolor','none');

p = add_isolines(T);
view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);