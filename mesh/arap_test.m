%test_arap

clear
close all
clc
dbstop if error

%%
[V,F]=subdivided_sphere(2);
drawMesh(V,F,'FaceAlpha',.5);
b=[1,50];
bc =[0 0 0;
    2 0 0];
%%
[U,data,SS,R] = arap(V,F,b,bc);

drawMesh(U,F);
view(3)
%zoom out
%zoom(1.5)
title('arap solution');
axis equal; 
axis vis3d;


