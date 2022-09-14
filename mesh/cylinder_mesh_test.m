clear;
clc;
dbstop if error;
close all;
N= 7;
[CV,CF] = cylinder_mesh(3,N,'Stacks',3*N,'Caps',true,'Quads',false);
CV(:,3) = 8 * CV(:,3);
colorF = 1:size(CV,1);
drawMesh(CV,CF,'FaceVertexCData',colorF', 'facecolor','interp', 'edgecolor','r');

        view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
title('cylinder mesh test', 'fontsize', 20);