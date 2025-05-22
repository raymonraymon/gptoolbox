close all
clc
clear

inputpath = '../models/faketooth/';

%[V,F] = subdivided_sphere(3);
file = dir([inputpath, '*.obj']);
    nfile = length(file);
     kk = 1;
	for i = [5:7,5:7]%[5:7,12:14,19:21,26:28]
       
      
        
        
       
        fprintf('%s\n',file(i).name);
        
        [V,F] = readOBJ([inputpath,file(i).name]);
        
        if kk >3
            V = bsxfun(@plus,mean(V),10*bsxfun(@minus,V,mean(V)));
        end
        %[V,F] = readOBJ('../models/armadillo.obj');
        [V,F] = readOBJ('../models/dragon_r.obj');
   %subplot(2,3,kk);
   kk = kk+1;
    %drawMesh(V,F,'edgecolor','none');
    [K,MK,data] = hks(V,F);
    
    figure;    
    plot(K(6361,:))
    hold on;
    plot(K(6413,:))
    plot(K(9537,:))
    plot(K(9575,:))
    hold off;
    % Compare all vertices' signatures to first using metric of [Sun et al.
    % 2009]
    k = bsxfun(@minus,K,K(1,:));
    %tsurf(F,V,'CData',sqrt(sum(bsxfun(@rdivide,k,MK).^2,2)),fphong);
    
    drawMesh(V,F, ...
           'FaceVertexCData',sqrt(sum(bsxfun(@rdivide,k,MK).^2,2)), 'facecolor','interp', 'edgecolor','none');
    title(file(i).name(11:12))
    view(3);
    axis equal
    colorbar
%     axis off
%     camlight
%     lighting gouraud
%     set(gca, 'Position',[0 0 1 1]);
%     cameratoolbar
    end