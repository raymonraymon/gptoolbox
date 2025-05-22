clear;
w=[0,1,0];
a = pi/3;
Q =axisangle2quat(w,a);

v= [0.5,1,0];
q = [0,v];

qafter1 = quatmultiply(Q,q);
qafter = quatmultiply(qafter1,Q);