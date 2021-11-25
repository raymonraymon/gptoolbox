clc
close all
clear
axTemp =rand(1,3);
q = [1,0,0,0];
q1 = axisangle2quat(axTemp,0.1);

qresult = quatmultiply(q1,q);