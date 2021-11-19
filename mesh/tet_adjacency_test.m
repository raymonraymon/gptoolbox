close all
clc
clear

[V,T,F] = regular_tetrahedral_mesh(5,5,5);
b=15;
A = tet_adjacency(T,'type','vertex');
Tplot = T([b,A{b}],:);

h = animated_tetramesh(Tplot,V(:,1),V(:,2),V(:,3));
    view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);