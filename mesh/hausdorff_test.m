close all
clc
clear
[VA,FA]=subdivided_sphere(2);
[VB,FB]=subdivided_sphere(2);
[d,pair] = hausdorff(VA,FA,VB,FB);