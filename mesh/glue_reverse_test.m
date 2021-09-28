close all
clc
clear

%[V,F]=subdivided_sphere(2);
[V,F] = readOBJ('halfsphereNotclose.obj');
drawMesh(V,F, 'facecolor','g','edgecolor','y');

[VV,FF,RIM] = glue_reverse(V,F);
drawMesh(VV,FF, 'facecolor','b','edgecolor','k');
view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);