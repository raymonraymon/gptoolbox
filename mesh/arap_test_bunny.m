%test_arap

clear
close all
clc
dbstop if error

% [SV1,SF1] = readOBJ('..\models\bunny.obj');
% %writeOFF('..\models\bunny.off',RV,IMF);
% %[SV,SF] = decimation(SV1,SF1,1.0);
% [V,T,F] = tetgen(SV1,SF1);
% writeOBJ('..\models\bunnyTet.obj',V,T);

[V,T] = readOBJ('..\models\bunnyTet.obj','Quads','true','SimplexSize',4);
%%
  demoldDir = [1 1 -1];
  demoldDir = demoldDir./norm(demoldDir);  
  center = mean(V);
  center = center - 0.25*demoldDir;
  plane   = createPlane(center, demoldDir); 
%qmat result
mat = [-0.510064624575772 2.027561528546383 -0.402608812387262
-0.329664349302502 1.855952440349088 -0.587279098975713
-1.907379030518001 0.630775672664619 0.885993687663970 
-1.682336561969509 1.761447879629059 -1.263517965169893
-0.903311181824901 1.619642380245586 -0.208291573799004
0.171757810095519 -0.128939687309887 0.276511804241896 
0.308643667515407 -0.923278198068084 0.524526306043303 
-0.263303490956873 -0.858043462037953 -0.13650605136214
-1.735282204434283 1.018503443810966 0.251014587001721 
-0.933687126081529 -0.543284151225656 0.264197898208929
];
matdis = distancePointPlane(mat,plane);
idmat = find(abs(matdis)<0.5);
[b,D] = knnsearch(V,mat(idmat,:));
b=unique(b);
bc = V(b,:);
plot3(bc(:,1),bc(:,2),bc(:,3),'m*','MarkerSize',10);hold on;
v1 = sum(volume(V,T))
[F,J,K] = boundary_faces(T);
drawMesh(V,F,'facealpha',0.5);

%%

  sigma = 0.03;
  [x,y]=meshgrid(-3:0.1:3);
  z = center(3) - 1/demoldDir(3)*(demoldDir(1)*(x-center(1))+demoldDir(2)*(y-center(2)));
  mesh(x,y,z);
  Vplane = zeros(size(x,1)*size(x,2),3);
  for i = 1:size(x,1)
      for j = 1:size(x,2)
          Vplane((i-1)*size(x,1)+j,:) = [x(i,j) y(i,j) z(i,j)];
      end
  end     
  writeOBJ('..\models\bunnyCastingPlane.obj',Vplane,[]);
  %%
  lastchange = 1000;
  tic
    Adjinfo = tet_adjacency(T,'type','face');
  toc
for ii = 1:30
    ii
    [U,data,SS,R,change,flag] = arap_casting(V,T,Adjinfo,demoldDir,plane,sigma,b,bc,lastchange);     
    if change > lastchange * 5
        writeOBJ('../models/arapresult.obj',V,T);
        break;
    else
        lastchange = change;
    end
    if ~flag 
        writeOBJ('../models/arapresult.obj',V,T);
        break;
    end
    [RV,IM,J,IMF] = remove_unreferenced(U,F);
    writeOBJ(['../models/bunny_result_',num2str(ii),'.obj'],RV,IMF);
    %画出仍然不符合脱模条件的面片
    NF = size(IMF,1);
    kk=0;
    mesh(x,y,z);
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
            end
    end
    if kk == 0
        writeOBJ('../models/bunny_arapresult.obj',V,T);
        break;
    end
    V=U;
    end
v2 = sum(volume(U,T))
(v1-v2)/v1
figure;
drawMesh(U,F,'FaceColor',[0.8 0.18 0.8]);

%%

xlabel('x');
ylabel('y');
zlabel('z');
title('arap solution');
axis equal; 
 view(3);
 
         camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);