close all
clc
clear

[I,J,K] = meshgrid(0:9,0:9,0:9);
    C = hcp_lattice(I(:),J(:),K(:));
    [V,F] = lloyd_sphere(100);
    [VV,FF] = repmesh(V,F,C);
    
    % Color based on original mesh vertex index
    tsurf(FF,VV,'CData',mod(1:size(VV,1),size(V,1))',fphong)
    % Color based on original mesh face index
    tsurf(FF,VV,'CData',mod(1:size(FF,1),size(F,1))')
    % Color based on which vector was used (per-vertex)
    tsurf(FF,VV,'CData',floor(((1:size(VV,1))-1)/size(V,1))',fphong)
    % Color based on which vector was used (per-face)
    tsurf(FF,VV,'CData',floor(((1:size(FF,1))-1)/size(F,1))')