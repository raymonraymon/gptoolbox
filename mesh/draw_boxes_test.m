    clc
    clear
    close all
    dbstop if error
    warning off all  
    BN=[0 0 0];
    BX=[1 1 1];
p = draw_boxes(BN,BX,'facealpha',0.5);
axis on