    clc
    clear
    close all
    dbstop if error
    warning off all 
[V,F] = equilateral_tiling(8);
drawMesh(V,F);
        view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);