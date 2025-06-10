%cube_test

clc
clear
close all
dbstop if error
%%
[V,F,Q] = cube(5,5,5);
drawMesh(V,F);