%[U,Uall] = laplacian_smooth(V,F,L_method,b,lambda,method,S,max_iter)
    clc
    clear
    close all
    dbstop if error
    warning off all   

    [V,F] = readOBJ('model_out.obj');%subdivided_sphere(1);
    %V  = V +0.3*rand(size(V));
    drawMesh(V,F,'facealpha',0.5);
    b = [];%[1 5];
	[U,Uall] = laplacian_smooth(V,F);%,'cotan',b,0.1,'implicit',V,2);
	drawMesh(U,F);
        view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
        %%
        
        writeOBJ('model_out_smooth.obj',U,F);
        lambda = 1.5;
    U_enhance = V+lambda*(V-U);
    drawMesh(U_enhance,F,'facecolor','k','edgecolor','g','facealpha',0.5);
        view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);