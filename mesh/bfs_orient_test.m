
[V,F] = subdivided_sphere(2);
    RF = F;
   I = rand(size(F,1),1)<0.5;
   RF(I,:) = fliplr(RF(I,:));
   [FF,C] = bfs_orient(RF);
   FF = orient_outward(V,F,C);
   I = randperm(max(C))';
%    drawMesh(V,RF,'ScalarFieldF',I(C));
%    drawMesh(V,FF,'ScalarFieldF',I(C));

drawMesh(V,RF);
drawMesh(V,FF);