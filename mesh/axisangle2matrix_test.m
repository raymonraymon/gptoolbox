clear;
w=[1,0,0];
a = pi/2;
R = axisangle2matrix(w,a);

u=(R*w')';
v=w;
[w1,a1] = axisanglebetween(u,v);