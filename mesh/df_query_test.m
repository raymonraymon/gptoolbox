%df_query_test.
clear
close all
clc
dbstop if error
[V,F] = subdivided_sphere(2);

[DF] = df_build_fast(V);
p = [10,10,10];
[id,d] = df_query( DF, p);
drawMesh(V,F);
plot3(V(id,1),V(id,2),V(id,3),'k*');