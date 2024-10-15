%flip_edges
close all
clc
clear
dbstop if error
%%
[V,F]=subdivided_sphere(1);
T=drawMesh(V,F, 'FaceVertexCData',V(:,1),'facecolor','interp', 'edgecolor','y','facealpha',0.5);
Edges=edges(F);
E = Edges(3:8,:);
[FF] = flip_edges(F,E);

T=drawMesh(V,FF, 'FaceVertexCData',V(:,1),'facecolor','interp', 'edgecolor','r');
view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);