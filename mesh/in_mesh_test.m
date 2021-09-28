
% [V,F] = readOBJ('plane.obj');
% V(:,2) = [];

[V,F] = equilateral_tiling(8);

Q=[0,0,0];
[in] = in_mesh(V,F,Q);
drawMesh(V,F);
if in
plot3(Q(:,1),Q(:,2),Q(:,3),'gh');
end