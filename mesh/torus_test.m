close all
clear
clc
% Roughly even shaped triangles
    n = 20;
    r = 1;%ÂÖÌ¥ÄÚÍâ°ë¾¶Ö®²î
    R = 3;
    [V,F] = torus(n,round(0.8*n),r,'R',5);
    
  drawMesh(V,F)
  axis equal
  rr = R-r;
  Vexect1 = 0.25*pi^2*(R-rr)^2*(R+rr);
  
  v1 = volume_triangleMesh(V,F);
%   [Vt,Tt,Ft] = tetgen(V,F);
%   [v_tet1] = volume(Vt,Tt);
  
  
  %%
  close all
%    clear
  [SV,SF] = subdivided_sphere(4);
  r =1;
  SV = r*SV;
  Vexect = 4*pi*r*r*r/3;
    drawMesh(SV,SF)
  axis equal
  v = volume_triangleMesh(SV,SF);
  

%drawMesh(SV,SF,'FaceAlpha',.5);
% [V,T,F] = tetgen(SV,SF);
% 
% [v_tet] = volume(V,T);

%%

[newnode,newface]=surfboolean(SV,SF,'diff',V,F);
figure;
    drawMesh(newnode,newface)
  axis equal
    v_diff = volume_triangleMesh(newnode,newface);
v_diff_exect = Vexect*7/8;