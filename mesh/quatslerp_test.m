clc
close all
clear

axTemp = [1,0,0];
q1 = axisangle2quat(axTemp,0.1);
q2 = axisangle2quat(axTemp,0.5);
q = quatslerp(q1,q2,0);

%%
%q = 1/3(q1+q2+q3);

axTemp = [1,0,0];
k1 = 0.5;
k2 = 0.8;
k3 = -0.4563;
q1 = axisangle2quat(axTemp,k1);
q2 = axisangle2quat(axTemp,k2);
q3 = axisangle2quat(axTemp,k3);

realq = axisangle2quat(axTemp,(k1+k2+k3)/3);

q = quatslerp(quatslerp(q1,q2,1/2),q3,1/3);

norm(q-realq)