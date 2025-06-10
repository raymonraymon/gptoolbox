clc
clear
close all
dbstop if error
%%
m = 10; n = 20;
[V,F] = create_regular_grid(m,n,1,0);
V = [sin(2*pi*V(:,1)) cos(2*pi*V(:,1)) (n-1)*2*pi/(m-1)*V(:,2)];
tsurf(F,V); axis equal;