  %[V,F] = readOBJ('woody.obj');
  [V,F]=subdivided_sphere(2);
  W = massmatrix(V,F,'voronoi');
  L = cotmatrix(V,F);
  a = sum(doublearea(V,F))/2.0;
  d = prebiharmonic(W,L,a,0.5,1);