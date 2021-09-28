close all
clc
clear

[V,F]=subdivided_sphere(2);
b=1;
A = adjacency_list(F,cell2mat(adjacency_list(F,b)));
A=cell2mat(A);
drawMesh(V,F);
plot3(V(A,1),V(A,2),V(A,3),'gh');
        view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
