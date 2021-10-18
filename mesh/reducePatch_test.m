     [x y z v] = flow;
     fv = isosurface(x, y, z, v, -3);
     subplot(1,2,1)
     p = patch(fv);
     p.FaceColor = [.5 .5 .5];
     p.EdgeColor = 'black';
     daspect([1 1 1]); view(3); axis tight
     title([num2str(length(p.Faces)) ' Faces'])
     subplot(1,2,2)
     p = patch(fv);
     p.FaceColor = [.5 .5 .5];
     p.EdgeColor = 'black';
     daspect([1 1 1]); view(3); axis tight
     reducepatch(p, .15) % keep 15 percent of the faces 
     title([num2str(length(p.Faces)) ' Faces'])
     
     %%
     close all
     [V,F]=subdivided_sphere(3);
     [mF,mV] = reducepatch(F,V,100);
     drawMesh(mV,mF);
     view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);