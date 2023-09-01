clear
close all
clc
dbstop if error

%%
[V,F] = readOBJ('../models/bunny.obj');
% nV = size(V,1);
%     L = cotmatrix(V, F);
%     M = massmatrix(V, F);
%     lhs = inv(M) * L;
%     rhs = zeros(nV, 1);
%     SeedInd0 = [1];
% 	SeedInd1 = [41];
%     S = solve_equation(lhs, rhs, ...
%         double([SeedInd0, SeedInd1]), [zeros(size(SeedInd0)), ones(size(SeedInd1))]);
%     S(isnan(S)) = 0;
% 	

%[k,H,K,M,T] = discrete_curvatures(V,F);
S = discrete_gaussian_curvature(V,F);
%S=V(:,2);
	
  %%  
  iso = 0;%linspace(min(S),max(S),10);
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
  
  %%
%   [U,G,J,BC,SU,L] = slice_isolines(V,F,S,0.1);
%   %drawMesh(V,F);
%   plot3(U(:,1),U(:,2),U(:,3),'*');
  
  