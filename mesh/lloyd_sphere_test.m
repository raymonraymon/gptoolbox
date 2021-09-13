    clc
    clear
    close all
    dbstop if error
    warning off all   
n=100;  

[N,F] = lloyd_sphere(n);
drawMesh(N,F)
        view(3);
        axis equal
        axis off
        %camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
        add_lights()