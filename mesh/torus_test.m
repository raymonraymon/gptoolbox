close all
% Roughly even shaped triangles
    n = 40;
    r = 0.4;
    [V,F] = torus(n,round(r*n),r);
  drawMesh(V,F)