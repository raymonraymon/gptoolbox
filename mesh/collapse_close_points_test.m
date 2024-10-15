  %% Collapse edges
  close all
  clc
  clear;
    % point position list
    C = [1,0;0,0;-1,0;0,1;eps,eps;0,-0.1;0,-1];
    % edge list
    E = [1 2; 2 3; 4 5; 5 6;6 7];
    % plot original
    subplot(1,2,1);
    plot([C(E(:,1),1) C(E(:,2),1)]',[C(E(:,1),2) C(E(:,2),2)]', ... 
      '-','LineWidth',1);
    % collapse close edges
    [NC,NE] = collapse_close_points(C,E,0.2);
    % plot result
    subplot(1,2,2);
    plot([NC(NE(:,1),1) NC(NE(:,2),1)]',[NC(NE(:,1),2) NC(NE(:,2),2)]', ...
      '-','LineWidth',1);
  
    %% Collapse faces
    % point position list
    C = [1,0;0,0;-1,0;0,1;eps,eps;0,-0.1;0,-1];
    % face list
    F = [1 4 5; 1 5 2; 1 2 6; 1 6 7;3 7 6; 3 6 2; 3 2 5; 3 5 4];
    % plot original
    subplot(1,2,1);
    tsurf(F,C);
    [NC,NF] = collapse_close_points(C,F,0.2);
    % plot result
    subplot(1,2,2);
    tsurf(NF,NC);