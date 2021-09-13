
filename='biaopi.png';
laplacian_smoothness_iterations =10;
max_points_on_boundary =10;
[V,F] = png2mesh( ...
  filename, laplacian_smoothness_iterations, max_points_on_boundary);

drawMesh(V,F);