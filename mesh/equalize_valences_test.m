%equalize_valences_test

close all
clc
clear
dbstop if error

n = 3;
switch n
%%
    case 1
[V,F]=subdivided_sphere(1);

feature =[];
[V1,F1] = equalize_valences(V,F,feature);
drawMesh(V1,F1,'facealpha',0.5)


%%
    case 2
[V,F]=subdivided_sphere(1);
P = random_points_on_mesh(V,F,size(F,1));
    [FF,II] = remesh_at_points(V,F,P);
    tsurf(FF,[V;P],'CData',II,'facealpha',0.5)
    
    feature =[];
[V1,F1] = equalize_valences([V;P],FF,feature);
drawMesh(V1,F1)

    case 3
        [V,F] = readOBJ('..\models\bunny_result_1.obj');
        feature =[];
        [V1,F1] = equalize_valences(V,F,feature);
        drawMesh(V1,F1,'facealpha',0.5)
        writeOBJ('equalize_valences_result.obj',V1,F1);
end


