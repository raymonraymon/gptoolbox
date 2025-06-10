%test_arap_casting

clear
close all
clc
dbstop if error

k = 0;
switch 2
    case  0
        [V,T] = readTET('..\models\bunny.TET');
        V=V(:,1:3);
        T=T(:,1:4);
        b= 1;
        bc =V(b,:);
        Vorigin = V;
    case  1
        kk = 7;
        [V,T,~] = regular_tetrahedral_mesh(kk);
        temp = T(:,1);
        T(:,1) = T(:,2);
        T(:,2) = temp;
        writeOBJ('..\models\regularTet.obj',V,T);
        %     b=find(V(:,2)==0);
        %     b=b(12:end);
        [~,b]=min(abs(V(:,1))+abs(V(:,2))+abs(V(:,3)));
        bc =V(b,:);
        V(1,:) = V(1,:)-[0.25,0,0.25];
        V(kk,:) = V(kk,:)-[0.125,0,0.125];
        %V(2,:) = V(2,:)+[-0.125,0.0,-0.125];
        Vorigin = V;
    case 2
        [SV,SF]=subdivided_sphere(2);
        %drawMesh(SV,SF,'FaceAlpha',.5);
        [V,T,F] = tetgen(SV,SF);% cdt function wrapper
        %[~,b]=min(abs(V(:,1))+abs(V(:,2))+abs(V(:,3)));
        b=find(abs(V(:,2))<0.015);
        bc =V(b,:);
        V(1,:) = V(1,:)+[0.0,0.75,0.75];
        V(2,:) = V(2,:)+[0.0,-0.75,0.75];
        Vorigin = V;
end

v1 = sum(volume(V,T))
[F,J,K] = boundary_faces(T);
writeOBJ('../models/arapinput.obj',V,F);
% figure;
% drawMesh(V,F,'FaceAlpha',0.5);
% xlabel('x');
% ylabel('y');
% zlabel('z');
% view(3)
tic
Adjinfo = tet_adjacency(T,'type','face');
toc
demoldDir = [0,1,0];
demoldDir = demoldDir./norm(demoldDir);
plane   = createPlane([0 0 0], [0 1 0]);
sigma = 0.02;
lastchange = 1000.0;
for ii = 1:10
    ii
    [U,data,SS,R,change,flag] = arap_casting(V,T,Adjinfo,demoldDir,plane,sigma,b,bc,lastchange);
    writeOBJ(['../models/arapresult_',num2str(k),'_',num2str(ii),'.obj'],U,F);
    [RV,IM,J,IMF] = remove_unreferenced(U,F);
    %画出仍然不符合脱模条件的面片
    NF = size(IMF,1);
    kk=0;
    for i = 1:NF
        point1   = RV(IMF(i,1),:);
        dist1    = distancePointPlane(point1, plane);
        point2   = RV(IMF(i,2),:);
        dist2    = distancePointPlane(point2, plane);
        point3   = RV(IMF(i,3),:);
        dist3    = distancePointPlane(point3, plane);

        normalbf = cross(RV(IMF(i,2),:)-RV(IMF(i,1),:),RV(IMF(i,3),:)-RV(IMF(i,1),:));
        normalbf = normalbf./norm(normalbf);
        if dot(demoldDir,normalbf) < sigma && dist1 > 0 && dist2 > 0 && dist3 > 0
            if dot(demoldDir,normalbf) <sigma/2
                kk = kk+1;
            end
            drawMesh([point1;point2;point3],[1 2 3],'facecolor','k','edgecolor','g');
        elseif dot(-demoldDir,normalbf) < sigma && dist1 < 0 && dist2 < 0 && dist3 < 0
            if dot(-demoldDir,normalbf) <sigma/2
                kk = kk+1;
            end
            drawMesh([point1;point2;point3],[1 2 3],'facecolor','k','edgecolor','b');
        else
        end
    end
    if kk == 0
        break;
    end
    V=U;
end
v2 = sum(volume(U,T))
(v1-v2)/v1
figure;
subplot(1,2,1)
drawMesh(Vorigin,F,'FaceColor',[0.18 0.8 0.18]);
view(3)
xlabel('x');
ylabel('y');
zlabel('z');
view(3)
%zoom out
%zoom(1.5)
title('arap casting input');
axis equal;
axis vis3d;
subplot(1,2,2)
drawMesh(U,F,'FaceColor',[0.8 0.18 0.8]);
view(3)


writeOBJ('../models/arapresult.obj',RV,IMF);
%%

xlabel('x');
ylabel('y');
zlabel('z');
view(3)
%zoom out
%zoom(1.5)
title('arap solution');
axis equal;
axis vis3d;


