    clc
    clear
    close all
    dbstop if error
    warning off all  
    
    [V,T] = readTET('bunny.TET');
    V=V(:,1:3);
    T=T(:,1:4);
    h = animated_tetramesh(T,V(:,1),V(:,2),V(:,3));