%[U,Uall] = laplacian_smooth(V,F,L_method,b,lambda,method,S,max_iter)
    clc
    clear
    close all
    dbstop if error
    warning off all   

    [V,F] = subdivided_sphere(1);
    drawMesh(V,F,'facealpha',0.5);
    b = [1 5];
	[U,Uall] = laplacian_smooth(V,F,'cotan',b,0.1,'implicit',V,10);
	drawMesh(U,F);
        view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);