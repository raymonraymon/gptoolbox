clc 
clear
close all
dbstop if error
[V,F] = subdivided_sphere(2);

[H] = discrete_mean_curvature(V,F);

drawMesh(V,F,'FaceVertexCData',H, 'facecolor','interp', 'edgecolor','none');
        view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);