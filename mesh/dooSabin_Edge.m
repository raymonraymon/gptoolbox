function [VV,FF] = dooSabin_Edge(V,F,VertexID)
% dooSabin perform dooSabin subdivision locally. 
% [VV,FF] = loop(V,F)
%
% Inputs:
%   V  #V by 3 list of vertex positions
%   F  #F by 3 list of face indices
% Outpus:
%   VV #VV by 3 new vertex positions
%   FF #FF by 3 list of face indices
%
% Copyright 2011, Alec Jacobson (jacobson@inf.ethz.ch)
%

VV = V;
FF = F;

    n = size(VV,1);
    N = per_vertex_normals(VV,FF);
    % get adjacency matrix
    A = adjacency_matrix(FF);
    % valence values
    val = sum(A,2);
    valSelectID = val(VertexID);
    vring = compute_vertex_ring(FF);
    VringV = vring{VertexID};
    
    %%
    %compute New vertex
    adj = vertexFaceAdjacencyList(FF);
    faceAdj =adj{VertexID};
    
    firstP = VringV(1);
    VringAdj = [firstP];
    NormalV = N(VertexID,:);
    while 1
        A = bsxfun(@minus,V(VertexID,:),  V(VringV(1:end),:));
        B = repmat(V(VertexID,:)- V(firstP,:),size(A,1),1);
        C = cross(A,B,2);
        D = dot(C,repmat(NormalV,size(C,1),1),2)<0;
        F1 = normalizerow(A);
        F2 = normalizerow(V(VertexID,:)- V(firstP,:));
        AngleCos = dot(F1,repmat(F2,size(A,1),1),2);
        SortCad = [D,AngleCos];
        maxAng = -100;
        maxid = 0;
        for i =1:valSelectID
            if SortCad(i,1)==1
                if SortCad(i,2)>maxAng;
                    maxAng = SortCad(i,2);
                    maxid = i;
                end
            end
        end
        if maxid == 1
            VringAdj = [VringAdj,VringV(maxid)];
            break;
        end
        VringAdj = [VringAdj,VringV(maxid)];
        firstP = VringV(maxid);
        
    end
    
    %clock wise face adj
    
    
    NewV = zeros(valSelectID*4,3);
    EdgeOpp=zeros(valSelectID,2);
    for k = 1:valSelectID
         facek = [VertexID,VringAdj(k),VringAdj(k+1)];
        c = mean(V(facek,:));%?????????
        %?????????????VertexID??
   
        EdgeOpp(k,:) = [facek(2),facek(3)];
        EdgeC = [0.5*(VV(facek(1),:)+VV(facek(2),:));...
                 0.5*(VV(facek(2),:)+VV(facek(3),:));...
                 0.5*(VV(facek(3),:)+VV(facek(1),:))];
         
        V1 =   [0.25*(c+VV(facek(1),:)+EdgeC(1,:)+EdgeC(3,:));...
                0.25*(c+VV(facek(2),:)+EdgeC(1,:)+EdgeC(2,:));...
                0.25*(c+VV(facek(3),:)+EdgeC(2,:)+EdgeC(3,:));...
                EdgeC(2,:)];
        NewV((k:valSelectID:valSelectID*3+1+k),:) =V1;
        plot3(V1(:,1),V1(:,2),V1(:,3),'y.');
    end
    
    FF(faceAdj,:)=[];
    %VV(VertexID,:)=[];
    
    i1 = n      + (1:valSelectID)';
    i2 = n + valSelectID  + (1:valSelectID)';
    i3 = n +2*valSelectID + (1:valSelectID)';
    i4 = n +3*valSelectID + (1:valSelectID)';
    i5 = EdgeOpp(:,1);
    i6 = EdgeOpp(:,2);
    
    FNewconer =zeros(valSelectID-2,3);
    for k=2:valSelectID-1
        FNewconer(k-1,:) =  [i1(1) i1(k) i1(k+1)];
    end
    FNewc = [i1 i2 i3];
    FNewBottom = [i2 i4 i3];
    FNewedge = [i1,i3,circshift(i1,-1);circshift(i1,-1),i3,circshift(i2,-1)];

    
    FNewBottomLeft =[i2,i5,i4];
    FNewBottomRight =[i3,i4,i6];
    
    FNewEdgeBottom = [i2,circshift(i3,1),i5];
    
    VV = [VV;NewV];
    FF = [FF;FNewconer;FNewc;FNewBottom;FNewedge;FNewBottomLeft;FNewBottomRight;FNewEdgeBottom];
    
    %%
    %??????????????????????????????????????????
    %to do 
    
    
    drawMesh(VV,FF(:,:),'facecolor','y');
    view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
end


