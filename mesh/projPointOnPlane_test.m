clc
clear
close all

center = [0 0 0];
demoldDir = [0 1 -1];
plane   = createPlane(center, demoldDir); 
p = projPointOnPlane([5 4 2;0 5 0],plane);

dot(p(1,:)-p(2,:),demoldDir)