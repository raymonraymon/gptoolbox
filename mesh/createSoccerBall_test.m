

    clc
    clear
    close all
    dbstop if error
    warning off all   
[v, f] = createSoccerBall();
   drawMesh(v, f);