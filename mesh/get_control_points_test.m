%get_control_points

close all
clc
clear

%[V,F]=subdivided_sphere(2);
[V,F] = readOBJ('halfsphereNotclose.obj');
drawMesh(V,F, 'facecolor','g','edgecolor','y');

[C,flag] = get_control_points(V,F);%ÓÒ¼üµã»÷