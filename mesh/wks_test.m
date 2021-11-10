close all
clc
clear
dbstop if error
[V,F] = subdivided_sphere(3);    
K = wks(V,F);
    % Compare all vertices' signatures to first using metric of [Aubry et al.
    % 2011]
tsurf(F,V,'CData',sum(abs((K-K(1,:))./(K+K(1,:))),2),fphong);
view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);