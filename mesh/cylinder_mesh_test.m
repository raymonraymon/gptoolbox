clear;
clc;
dbstop if error;
close all;
N= 12;
[CV,CF] = cylinder_mesh(0.3725,N,'Stacks',0.5*N,'Caps',true,'Quads',false);
CV(:,3) = 1/(0.5*N) * CV(:,3);
colorF = 1:size(CV,1);
drawMesh(CV,CF,'FaceVertexCData',colorF', 'facecolor','interp', 'edgecolor','r');
writeOBJ('cylinder.obj',CV,CF);

        view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
title('cylinder mesh test', 'fontsize', 20);