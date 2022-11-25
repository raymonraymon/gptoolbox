clear;
close all;
dbstop if error;
%%
V=rand(99,2);
V=sort(V,2);
alpha = 0.5;
[AF,DF] = alpha_complex(V,alpha);
subplot(1,2,1)
patch('Faces',AF,'Vertices',V,'FaceColor','green','FaceAlpha',.3)
subplot(1,2,2)
patch('Faces',DF,'Vertices',V,'FaceColor','red','FaceAlpha',.5)