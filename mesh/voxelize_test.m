close all
clc
clear
[V,F] = subdivided_sphere(2);
[W,BC,DV,Q] = voxelize(V,F,50);
    % Get triangles from quads
    DF = [Q(:,[1 2 3]);Q(:,[1 3 4])];
    % Remove unreferenced corners
    [SV,IM] = remove_unreferenced(DV,DF);
    % re-index
    SF = IM(DF);
    SQ = IM(Q);
  
    [W,BC] = voxelize(V,F,50,'Pad',1);
    % Use matlab's isosurface to extract surface as triangle mesh
    BC = reshape(BC,[size(W) 3]);
    surf = isosurface(BC(:,:,:,1),BC(:,:,:,2),BC(:,:,:,3),W,0.5);
    DV = bsxfun(@plus,bsxfun(@times,bsxfun(@rdivide,surf.vertices-1, ...
      [size(W,2) size(W,1) size(W,3)]-1),max(BC)-min(BC)),min(BC));
    DF = surf.faces;