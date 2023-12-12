clc
clear
close all
dbstop if error    
[V,F]= subdivided_sphere(2);
%%

P = random_points_on_mesh(V,F,size(F,1));
    [FF,II] = remesh_at_points(V,F,P);
    tsurf(FF,[V;P],'CData',II)

    %%
   view(3);
   axis equal
   axis off
   camlight
   lighting gouraud
   cameratoolbar
   set(gca, 'Position',[0 0 1 1]);