clc 
clear
close all
dbstop if error
%[V,F] = subdivided_sphere(2);
[V,F] = readOBJ('../models/117544_uppercasting.obj');
[H] = discrete_mean_curvature(V,F);

[k,H,K,M,T] = discrete_curvatures(V,F);

kk = find(k<0.0001);

plot3(V(kk,1),V(kk,2),V(kk,3),'ks',...
    'LineWidth',2,...
    'MarkerSize',4,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor',[0.25,0.85,0.75]);

%[K] = discrete_gaussian_curvature(V,F);

drawMesh(V,F,'FaceVertexCData',H, 'facecolor','interp', 'edgecolor','none');
        view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);