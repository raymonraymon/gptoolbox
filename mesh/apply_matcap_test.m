[x,y] = meshgrid(1:15,1:15);
z = peaks(15);
T = delaunay(x,y);
tsh = trisurf(T,x,y,z);
%%
mc = imread('ngc6543a.jpg');
[Imc,A] = apply_matcap(tsh,mc);