

    clc
    clear
    close all
    dbstop if error
    warning off all   
s=100;r=5;  

[V,F] = annulus(s,r);
drawMesh(V,F)
        view(3);
        axis equal
        axis off
        %camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
        add_lights()