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

[V,T] = readOBJ('..\models\arapresult.obj','Quads','true','SimplexSize',4);
%%
%qmat result
mat = [ -0.510064702615931 2.027561358924207 -0.402608743937703
 -0.563888441712865 -1.439689473027668 1.158769858389743
 -0.870814948076982 -0.523793432125442 0.293504004583491
 -0.329664429959746 1.855952583177334 -0.587279118719175
 0.264826763303874 -0.292499250159335 0.287328905522238 
 -1.907379036470468 0.630775664720903 0.885993717900962 
 -1.819072108987618 0.987163893506592 0.569606306999737 
 0.180599792027726 -0.851213949148718 -0.118525452580381
 -0.027459482824821 -0.027229343448023 0.289545904453380
 -0.700151981480000 1.567778842342641 -0.271227729109579
 -1.079181136459418 1.467160631803792 -0.074683751575478
 -1.137239489533332 -1.371883023244557 0.045222387333988
 -1.061136339436740 -1.394576124482998 0.740296226276632
 -1.738501583619865 1.334740958932277 -0.365398814514698
 -1.513706644226116 -1.477896413718445 0.124034753690210
 -1.715844516434836 0.617268185751619 0.384365383592846 
 -0.844550509645816 1.763642869290372 -0.247301383987268
 -0.918672488301572 -1.470100158303066 -0.50223104470012
 -0.641942660848311 -0.207046804829769 0.234709276227665
 -0.065080782262442 -0.674135626490075 0.268342834286948
 0.142510219135399 -0.634745500333095 0.351652073330857 
 -0.171899501750771 -1.246334665552834 1.043527875894400
 -0.774571445460770 -1.029302956911661 0.340624453914072
 -1.682336572614250 1.761447859392930 -1.263517967492369
 0.960564762054120 -1.129861190176339 0.318009530227313 
 -1.373283872922125 -1.493876886683459 0.655531870662752
 -0.214846460730811 -0.720287238740153 -0.26430822771194
 -1.699267682603812 1.564132417065011 -0.845268898613964
 -1.623812179181342 1.127462524878345 0.198570459280738 
 -1.354151432285107 -0.187326782783434 0.290668834353087
];
idmat = [5 6 7 8 11 15 17 18 19 20 21 24 29]+1;
[b,D] = knnsearch(V,mat(idmat,:));
b=unique(b);
bc = V(b,:);
v1 = sum(volume(V,T))
[F,J,K] = boundary_faces(T);
drawMesh(V,F);
tic
Adjinfo = tet_adjacency(T,'type','face');
toc
%%
  demoldDir = [1 1 -1];
  demoldDir = demoldDir./norm(demoldDir);  
  center = mean(V);
  center = center + 0.1*demoldDir;
  plane   = createPlane(center, demoldDir); 
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
for ii = 1:30
    ii
    [U,data,SS,R,change] = arap_casting(V,T,Adjinfo,demoldDir,plane,sigma,b,bc,lastchange);     
    if change > lastchange
        writeOBJ('../models/arapresult.obj',V,T);
        break;
    else
        lastchange = change;
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
        writeOBJ('../models/arapresult.obj',V,T);
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
view(3)
%zoom out
%zoom(1.5)
title('arap solution');
axis equal; 
axis vis3d;