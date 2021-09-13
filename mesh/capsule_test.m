    clc
    clear
    close all
    dbstop if error
    warning off all  
    n=10;
    a=5;
    

[V,F,I] = capsule(n,a);

drawMesh(V,F(I==1,:));
        view(3);
        axis equal
        axis off
        %camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
        add_lights()