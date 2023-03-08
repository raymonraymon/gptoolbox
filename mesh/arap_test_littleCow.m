%test_arap

clear
close all
clc
dbstop if error

%准备数据最好pca三轴对齐坐标轴

% [SV1,SF1] = readOBJ('..\models\littleCow.obj');
% SV1 = SV1-repmat(mean(SV1),size(SV1,1),1);
% writeOFF('..\models\littleCow.off',SV1,SF1);
% [SV,SF] = decimation(SV1,SF1,0.05);
% [V,T,F] = tetgen(SV,SF);
% writeOBJ('..\models\littleCowTet.obj',V,T);

[V,T] = readOBJ('..\models\littleCowTet.obj','Quads','true','SimplexSize',4);
%%
  demoldDir = [0.65 0 1];
  demoldDir = demoldDir./norm(demoldDir);  
  center = mean(V)+0.05*demoldDir;  
  plane   = createPlane(center, demoldDir); 
%qmat result
mat = [ 0.372454736040117 0.075490792810761 -0.13668401723660
 0.104592613090432 -0.217797964186186 -0.6004996906498
 0.011038923147101 0.242789901339662 -0.59836015108619
 -0.330973559554525 0.110511075964748 0.94241762459228
 0.815937666643276 -0.038978018395338 -0.6032045827803
 1.001649567168070 0.187197929368853 -0.04600485854855
 -0.261786439257501 -0.228137350767092 0.9327777122026
 0.735357581212699 0.354155312829885 -0.59895573649093
 -0.179359010505353 -0.398961817800578 0.7430418014660
 -0.458222913957231 -0.234829764700337 0.3689590344755
 -0.325678878878560 0.297806286503797 0.74805495038605
 0.153444627082908 0.027226739798691 0.084859079210809
];
matdis = distancePointPlane(mat,plane);
idmat = find(abs(matdis)<0.5);
[b,D] = knnsearch(V,mat(idmat,:));
b=unique(b);
if 1
    bc = V(b,:);
else    
    bc = projPointOnPlane(V(b,:), plane);
end
plot3(bc(:,1),bc(:,2),bc(:,3),'m*','MarkerSize',10);hold on;
v1 = sum(volume(V,T))
[F,J,K] = boundary_faces(T);
drawMesh(V,F,'facealpha',0.15);

%%
  
  sigma = 0.03;
  [x,y]=meshgrid(-1:0.1:1);
  z = center(3) - 1/demoldDir(3)*(demoldDir(1)*(x-center(1))+demoldDir(2)*(y-center(2)));
  mesh(x,y,z);
  Vplane = zeros(size(x,1)*size(x,2),3);
  for i = 1:size(x,1) 
      for j = 1:size(x,2)
          Vplane((i-1)*size(x,1)+j,:) = [x(i,j) y(i,j) z(i,j)];
      end
  end     
  writeOBJ('..\models\littleCowCastingPlane.obj',Vplane,[]);
  %%
  tic
Adjinfo = tet_adjacency(T,'type','face');
toc
  lastchange = 1000;
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
    writeOBJ(['../models/littleCow_result_',num2str(ii),'.obj'],RV,IMF);
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
        writeOBJ('../models/arapresult.obj',V,T);
        break;
    end
    V=U;
    end
v2 = sum(volume(U,T))
(v1-v2)/v1
%figure;
drawMesh(U,F,'FaceColor',[0.8 0.18 0.8]);

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