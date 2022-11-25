clc

sam  = 100;
[P,E] = reuleaux_triangle(sam);

%drawMesh(P,E)
plot3(P(:,1),P(:,2),zeros(sam*3,1),'o')