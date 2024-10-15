close all
clc
clear
dbstop if error

%%
V= rand(250,2);

subplot(2,2,1);plot(V(:,1),V(:,2),'*-');
axis equal

[U,UT] = isometric_curve_flow(V);

subplot(2,2,2);plot(U(:,1),U(:,2),'>-');
axis equal
subplot(2,2,3);plot(UT(:,1),UT(:,2),'>-');
axis equal