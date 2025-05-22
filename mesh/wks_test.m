close all
clc
clear
dbstop if error
%[V,F] = subdivided_sphere(3);%2 1 is error.why?



% [V,F] = readOBJ('../models/Armadillo.obj');
% K = wks(V,F);
%     % Compare all vertices' signatures to first using metric of [Aubry et al.
%     % 2011]
% tsurf(F,V,'CData',sum(abs((K-K(1,:))./(K+K(1,:))),2),fphong);
%         view(3);
%         axis equal
%         axis off
%         camlight
%         lighting gouraud
%         set(gca, 'Position',[0 0 1 1]);
        
        %%
        
        
close all
clc
clear

inputpath = '../models/faketooth/';

%[V,F] = subdivided_sphere(3);
file = dir([inputpath, '*.obj']);
    nfile = length(file);
     kk = 1;
	for i = [5:7]%[5:7,12:14,19:21,26:28]
       
      
        
        
       
        fprintf('%s\n',file(i).name);
        
        [V,F] = readOBJ([inputpath,file(i).name]);
        %[V,F] = readOBJ('../models/armadillo.obj');
   subplot(1,3,kk);
   kk = kk+1;
    %drawMesh(V,F,'edgecolor','none');
    [K,data] = wks(V,F);
    % Compare all vertices' signatures to first using metric of [Sun et al.
    % 2009]
    
    %tsurf(F,V,'CData',sqrt(sum(bsxfun(@rdivide,k,MK).^2,2)),fphong);
    
    drawMesh(V,F, ...
           'FaceVertexCData',sum(abs((K-K(1,:))./(K+K(1,:))),2), 'facecolor','interp', 'edgecolor','none');
    title(file(i).name(11:12))
    view(3);
    axis equal
%     axis off
%     camlight
%     lighting gouraud
%     set(gca, 'Position',[0 0 1 1]);
%     cameratoolbar
    end