

    clc
    clear
    close all
    dbstop if error
    warning off all   
    [V, E, F] = createSoccerBall();
    drawMesh(V,F);
    F5=[];F6=[];
    for i =1: size(F,1)
        if length(F{i})==5;
            F5=[F5;F{i}];
        else
            F6=[F6;F{i}];
        end
    end
    writeOBJ('../models/soccer5.obj',V,F5);
    writeOBJ('../models/soccer6.obj',V,F6);