    clc
    clear
    close all
    dbstop if error
    warning off all 
      axis([-40 40 -40 40]);axis equal;
      P = get_pencil_curve();
      E = [1:size(P,1);2:size(P,1) 1]';
      [V,F] = cookie_cutter(P,E);
      tsurf(F,V);axis equal;