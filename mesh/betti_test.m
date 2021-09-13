    clc
    clear
    close all
    dbstop if error
    warning off all  
s=10;r=5;  

[V,F] = annulus(s,r);
b1 = betti(F);