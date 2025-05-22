close all
clc
clear
dbstop if error

%%
[V,F] = readOBJ('../models/cube_open.obj');


[K] = discrete_gaussian_curvature(V,F);

K= (K-min(K))/(max(K)-min(K));

drawMesh(V,F,'FaceVertexCData',K, 'facecolor','interp', 'edgecolor','none');
        view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
        
k = find(K>0.5);
plot3(V(k,1),V(k,2),V(k,3),'ks',...
    'LineWidth',2,...
    'MarkerSize',4,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor',[0.25,0.85,0.75]);