  close all
  clc
  clear
  dbstop if error
[V,F,C] = beach_ball(2);
figure
patch('Faces',F,'Vertices',V,'FaceVertexCData',C,'FaceColor','flat');
colorbar

