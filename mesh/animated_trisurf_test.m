clc
clear
close all
dbstop if error    
[V,F]= subdivided_sphere(2);
%%
h = animated_trisurf(F,V(:,1),V(:,2),V(:,3))