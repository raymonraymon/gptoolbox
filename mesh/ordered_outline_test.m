
   
       clc
    clear
    close all
    dbstop if error
    warning off all  
V = [0 0; 1 0; 1 1 ; 0 1; 4 0; 4 4; 0 4];
    F = [1 2 3; 1 3 4; 5 6 7];
    [B,L] = ordered_outline(F);
    hold on
    for l = 1:(numel(L)-1)
      plot(V([B(L(l):(L(l+1)-1)) B(L(l))],1),V([B(L(l):(L(l+1)-1)) B(L(l))],2));
    end
    hold off