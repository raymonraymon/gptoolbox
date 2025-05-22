clc    
clear
    close all
    dbstop if error
    warning off all  
% x=2;
% y=2;
% z=2;
% [V,F,Q] = cube(x,y,z);

%%
[V,F] = readOBJ('../models/S8_orig.obj');
drawMesh(V,F,'facealpha',0.05);

for i =1:20
k = accumarray(vec(F),vec(internalangles(V,F)),[size(V,1) 1],[],0);
[a,k2v] = sort(k);

plot3(V(k2v(1:5),1),V(k2v(1:5),2),V(k2v(1:5),3),'kd','MarkerSize',24,...
            'MarkerEdgeColor','m',...
            'MarkerFaceColor',[0.6,0.17,0.91]);     
        
 writeOBJ('../models/S8_orig_acute_points.obj',V(k2v(1:20),:),[]);        

    id = k2v(1);
[VV, FF] = dooSabin_Edge(V, F, id);
V = VV;
F = FF;
end
drawMesh(VV,FF,'facecolor','y');
writeOBJ('../models/cube_open_doo_sabin.obj',VV,FF);
view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);