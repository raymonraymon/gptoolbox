%biharmonic_distance_origin
clear
close all
clc
dbstop if error
%https://gfx.cs.princeton.edu/pubs/Lipman_2010_BD/index.php
%%
[V,F] = subdivided_sphere(2);
writeOFF('sphere.off', V,F);

dists = biharmonic_distance_origin('sphere.off', 'dist_file.txt');

S=dists(:,51);

iso = linspace(min(S),max(S),10);
  [LS,LD] = isolines(V,F,S,iso);
  
  colormap(jet(numel(iso)-1));
  tsurf(F,V,'CData',S,fphong);
  hold on;
  plot3([LS(:,1) LD(:,1)]',[LS(:,2) LD(:,2)]',[LS(:,3) LD(:,3)]', ...
    'Color','k','LineWidth',10);
  hold off;
  view(3)