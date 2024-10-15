th = 2*pi*rand(200,1);
P = 0.5*[cos(th),sin(th)];
P = [P;[-1,-1];[1,1]];
[C,W,CH,PAR,D,A] = initialize_quadtree(P,'MaxDepth',8,'Graded',true);
[V,Q] = bad_quad_mesh_from_quadtree(C,W,CH);

clf
hold off
hold on
tsurf(Q,V,'FaceColor','b','EdgeColor','k',falpha(0.2,1))
axis equal