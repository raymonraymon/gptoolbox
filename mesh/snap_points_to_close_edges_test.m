clc 
clear
close all
dbstop if error
%%
%% Break edges
% point position list
C = [1,0;-1,0;0,1;eps,eps;0,-1;1,1;-1,-1];
% edge list
E = [1 2; 3 4; 4 5;6 7];
% plot original
subplot(1,2,1);
plot([C(E(:,1),1) C(E(:,2),1)]',[C(E(:,1),2) C(E(:,2),2)]', ... 
  '-','LineWidth',1);
% break edges at close points
[NC,NE] = snap_points_to_close_edges(C,E,0.2);
% plot result
subplot(1,2,2);
plot([NC(NE(:,1),1) NC(NE(:,2),1)]',[NC(NE(:,1),2) NC(NE(:,2),2)]', ...
  '-','LineWidth',1);