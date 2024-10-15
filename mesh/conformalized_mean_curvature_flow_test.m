


%conformalized_mean_curvature_flow

  %     'MaxIter' followed by maximum number of iterations {100}
  %     'MinDiff' followed by minimum difference between iterations {1e-13}
  %     'Conformalize' followed by whether to rebuild _just_ the mass
  %       matrix each step {true}
  %     'delta' followed by delta value, should roughly be in range
  %       [1e-13,1e13] {1}
  %     'LaplacianType' followed by 'cotangent' of 'uniform'.
  %     'V0' followed by #V by 3 mesh positions to treat as initial mesh (to
  %       build laplacian from)
  %     'RescaleOutput' followed by whether to scale output to match input
  %       (otherwise scaled to unit surface area and moved to origin for
  %       numerical robustness) {false}
  close all
  clc
  clear
  dbstop if error
  [V,F] = readOBJ('../models/armadillo.obj');

[U,Usteps] = conformalized_mean_curvature_flow(V,F,'MaxIter',10,'MinDiff',1e-10);
        
for i=1:5
    subplot(2,5,i);
        drawMesh(Usteps(:,:,i),F);
%         view(3);
%         axis equal
%         axis off
%         camlight
%         lighting gouraud
%         set(gca, 'Position',[0 0 1 1]);
%         cameratoolbar;
end