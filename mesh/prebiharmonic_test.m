    clc
    clear
    close all
    dbstop if error
    warning off all   
  [V,F] = readOBJ('../models/bunny.obj');
  %[V,F]=subdivided_sphere(2);
  W = massmatrix(V,F,'voronoi');
  L = cotmatrix(V,F);
  a = sum(doublearea(V,F))/2.0;
  S = prebiharmonic(W,L,a,0.5,[10,90]);
  
  drawMesh(V,F, 'FaceVertexCData',S, 'facecolor','interp', 'edgecolor','none');
  
  iso = linspace(min(S),max(S),10);
  [LS,LD,I] = isolines(V,F,S,iso);
  
  colormap(jet(numel(iso)-1));
  %tsurf(F,V,'CData',S,fphong);
  drawMesh(V, F, ...
           'FaceVertexCData',S, 'facecolor','interp', 'edgecolor','none','facealpha','0.1');
  hold on;


  plot3([LS(:,1) LD(:,1)]',[LS(:,2) LD(:,2)]',[LS(:,3) LD(:,3)]', ...
    'Color','k','LineWidth',1);
  hold off;
  
   view(3);
   axis equal
   axis off
   camlight
   lighting gouraud
   cameratoolbar
   set(gca, 'Position',[0 0 1 1]);