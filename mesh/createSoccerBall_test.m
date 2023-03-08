

    clc
    clear
    close all
    dbstop if error
    warning off all   
    %[Vorig, E, F] = createSoccerBall();
    N= 18;r=5;
    [V,F] = cylinder_mesh(r,N,'Stacks',0.5*N,'Caps',true,'Quads',false);
    %V = bsxfun(@plus,Vorig,[ 0 5 3]);
    drawMesh(V,F,'facealpha','0.1','edgecolor','m');
    writeOBJ('../models/cylinder.obj',V,F);     
	
	N =normalizerow([0 1 0]);
    drawVector3d([0 0 0], N)
    [R,W] = rodrigues(N,pi/2);
	V_rot= V*R;
    writeOBJ('../models/cylinder_after_rot.obj',V_rot,F);  
	drawMesh(V_rot,F,'facealpha','0.3','edgecolor','k');
    view(3);
    axis equal
    axis off
    camlight
    lighting gouraud
    cameratoolbar
    set(gca, 'Position',[0 0 1 1]);
   
%     F5=[];F6=[];
%     for i =1: size(F,1)
%         if length(F{i})==5;
%             F5=[F5;F{i}];
%         else
%             F6=[F6;F{i}];
%         end
%     end
%     writeOBJ('../models/soccer5.obj',V,F5);
%     writeOBJ('../models/soccer6.obj',V,F6);