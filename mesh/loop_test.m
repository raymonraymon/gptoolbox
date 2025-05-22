clc    
clear
    close all
    dbstop if error
    warning off all  
% x=2;
% y=2;
% z=2;
% [V,F,Q] = cube(x,y,z);

%%
[V,F] = readOBJ('../models/cube_open.obj');
drawMesh(V,F,'facealpha',0.5);
iter =1;
[VV, FF, S] = loop(V, F, iter);
drawMesh(VV,FF);
view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);