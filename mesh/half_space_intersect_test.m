%half_space_intersect
close all
clc
clear
dbstop if error

[V,F]=subdivided_sphere(2);
p=[0.5 0 0];
n=[1 0 0];
[VV,FF,birth,UT,E] = half_space_intersect(V,F,p,n);

drawMesh(VV,FF);
view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);