
clear
close all
clc
dbstop if error
[SV,SF]=subdivided_sphere(2);
%drawMesh(SV,SF,'FaceAlpha',.5);
[V,T,F] = tetgen(SV,SF);

    h = animated_tetramesh(T,V(:,1),V(:,2),V(:,3));
    view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
