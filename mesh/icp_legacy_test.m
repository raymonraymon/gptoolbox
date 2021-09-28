[A,~] = subdivided_sphere(3);
[B,~] = subdivided_sphere(1);

[R,t,BRt,e,KDTA,KDTB] = icp_legacy(A,B);