

   
       clc
    clear
    close all
    dbstop if error
    warning off all  

    

n=40;
[V,F] = oloid(n,'Spacing',sqrt(2));
   drawMesh(V,F);
        view(3);
        axis equal
        axis off
        %camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
        add_lights()