%[V,F] = tube_gp(s,r,varargin)
clc
clear
close all
dbstop if error

%%
s=36;
r= 5;
[V,F] = tube_gp(s,r,'Flags','-q30 -a0.5 -s','R',12,'Levels',14);

drawMesh(V,F);

%%
view(3);
axis equal
axis off
%camlight
lighting gouraud
set(gca, 'Position',[0 0 1 1]);
add_lights()