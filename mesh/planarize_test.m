    clc
    clear
    close all
    dbstop if error
    warning off all   
n=100;  

load('cube_quad_meshed.mat');
M = planarize(V,Q);
drawMesh(M,Q)
        view(3);
        axis equal
        axis off
        %camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
        add_lights()
