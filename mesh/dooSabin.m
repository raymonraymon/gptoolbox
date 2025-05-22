function [VV,FF] = dooSabin(V,F,VertexID)
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

    % get adjacency matrix
    A = adjacency_matrix(FF);
    % valence values
    val = sum(A,2);
    valSelectID = val(VertexID);
    vring = compute_vertex_ring(FF);
    
    adj = vertexFaceAdjacencyList(FF);
    
    E = edges(FF);
    ET = edge_triangle_adjacency(FF,E);
    %%
    %compute New vertex
    faceAdj = [6,5,1,2,10];%adj{VertexID};
%     faceAdj=[];
%     firstEdge= sort([VertexID,vring{VertexID}(1)]);
%     firstEdgeid = intersect(find(E(:,1)==firstEdge(1)),find(E(:,2)==firstEdge(2)));
%     faceAdj = [faceAdj,ET(firstEdgeid,:)];
    
    %clock wise face adj
    
    
    NewV = zeros(valSelectID*4,3);
    EdgeOpp=zeros(valSelectID,2);
    for k = 1:valSelectID
         facek = F(faceAdj(k),:);
        c = mean(V(facek,:));%?????????
        %?????????????VertexID??
   
        while (facek(1) ~= VertexID)
            facek = circshift(facek,1,2);
        end
        EdgeOpp(k,:) = [facek(2),facek(3)];
        EdgeC = [0.5*(VV(facek(1),:)+VV(facek(2),:));...
                 0.5*(VV(facek(2),:)+VV(facek(3),:));...
                 0.5*(VV(facek(3),:)+VV(facek(1),:))];
         
        V1 =   [0.25*(c+VV(facek(1),:)+EdgeC(1,:)+EdgeC(3,:));...
                0.25*(c+VV(facek(2),:)+EdgeC(1,:)+EdgeC(2,:));...
                0.25*(c+VV(facek(3),:)+EdgeC(2,:)+EdgeC(3,:));...
                EdgeC(2,:)];
        NewV((k:5:16+k),:) =V1;
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
    
    FNewconer =zeros(length(faceAdj)-2,3);
    for k=2:length(faceAdj)-1
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
    
    
    drawMesh(VV,FF(:,:),'facecolor','y');
    view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
end


