[V,F] = equilateral_tiling(8);
[VV,FF,J] = extrude(V,F);
drawMesh(VV,FF);