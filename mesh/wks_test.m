close all
clc
clear
[V,F] = subdivided_sphere(2);    
K = wks(V,F);
    % Compare all vertices' signatures to first using metric of [Aubry et al.
    % 2011]
    tsurf(F,V,'CData',sum(abs((K-K(1,:))./(K+K(1,:))),2),fphong);;