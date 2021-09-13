
   
       clc
    clear
    close all
    dbstop if error
    warning off all  
    n=10;
    a=5;
    

u=19;
v=13;
[V,F,UV] = moebius_strip(u,v);
   drawMesh(V,F);
        view(3);
        axis equal
        axis off
        %camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
        add_lights()