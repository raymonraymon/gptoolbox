clc
clear
close all
dbstop if error
warning off all

[V,T] = readTET('../models/bunny.TET');
V=V(:,1:3);
T=T(:,1:4);
h = animated_tetramesh(T,V(:,1),V(:,2),V(:,3));
view(3);
axis equal
axis off
camlight
lighting gouraud
set(gca, 'Position',[0 0 1 1]);