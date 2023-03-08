%biharmonic_distance
clear
close all
clc
dbstop if error

%%
[V,F] = subdivided_sphere(2);
nV = size(V,1);
dim = size(V,2);
[S] = biharmonic_distance(V,F,2,dim);

iso = linspace(min(S),max(S),10);
  [LS,LD] = isolines(V,F,S,iso);
  
  colormap(jet(numel(iso)-1));
  tsurf(F,V,'CData',S,fphong);
  hold on;
  plot3([LS(:,1) LD(:,1)]',[LS(:,2) LD(:,2)]',[LS(:,3) LD(:,3)]', ...
    'Color','k','LineWidth',10);
  hold off;