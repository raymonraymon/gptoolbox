    clc
    clear
    close all
    dbstop if error
    warning off all 
[V,F]= subdivided_sphere(1); 

L = cotmatrix(V, F);
%rank(L)
det(L)
M = massmatrix(V,F,'voronoi');

MV = mean_value_laplacian(V,F);

W = wachspress_laplacian(V,F);

[Mc,mEc] = crouzeix_raviart_massmatrix(V,F);

[Lc,Ec,EMAPc] = crouzeix_raviart_cotmatrix(V,F);

det(M)
det(L)
det(MV)
det(W)