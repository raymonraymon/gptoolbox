dbstop if error
[V,F] = subdivided_sphere(3);
    V = V*0.1;
    C = rand(9,3);
    [VV,FF] = repmesh(V,F,C);
    % Color based on original mesh vertex index
    tsurf(FF,VV,'CData',mod(1:size(VV,1),size(V,1))',fphong)
    % Color based on original mesh face index
    tsurf(FF,VV,'CData',mod(1:size(FF,1),size(F,1))')
    % Color based on which vector was used (per-vertex)
    tsurf(FF,VV,'CData',floor(((1:size(VV,1))-1)/size(V,1))',fphong)
    % Color based on which vector was used (per-face)
    tsurf(FF,VV,'CData',floor(((1:size(FF,1))-1)/size(F,1))')