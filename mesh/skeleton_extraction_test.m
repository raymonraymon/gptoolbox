%skeleton_extraction_test
clc
clear
close all
dbstop if error

%%
[V,F] = readOBJ('../models/littleCow_result_3.obj');
[W,E,U] = skeleton_extraction(V,F);
plot3(U(:,1),U(:,2),U(:,3),'*b','MarkerSize',10);