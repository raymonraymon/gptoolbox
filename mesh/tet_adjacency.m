function [adjF] = tet_adjacency(varargin)

T = varargin{1};
sizeT = size(T,1);

ii = 2;
  while(ii <= nargin)
    switch varargin{ii}
    case 'type'
      ii = ii + 1;
      assert(ii<=nargin);
      type = varargin{ii};
    otherwise
      error(['Unsupported parameter: ' varargin{ii}]);
    end
    ii = ii + 1;
  end
  
%  A=cell(sizeT,1);
%  for b = 1: sizeT
%      b;
%      Tb = T(b,:);
%   switch type
%   case 'face'    
%     F1 = Tb([2,3,4]);
%     F2 = Tb([1,3,4]);
%     F3 = Tb([1,2,4]);
%     F4 = Tb([1,2,3]);
%   case 'edge'
%     F1 = Tb([1,2]);
%     F2 = Tb([1,3]);
%     F3 = Tb([1,4]);
%     F4 = Tb([2,3]);
%     F5 = Tb([2,3]);
%     F6 = Tb([2,3]);
%   case 'vertex'
%     F1 = Tb(1);
%     F2 = Tb(2);
%     F3 = Tb(3);
%     F4 = Tb(4);
%   end
%   
% 
% for i = 1:sizeT
%     i;
%     if i ~=b
%         switch type
%         case 'edge'
%             if all(ismember(F1,T(i,:)))||all(ismember(F2,T(i,:)))...
%                 ||all(ismember(F3,T(i,:)))||all(ismember(F4,T(i,:)))...
%                 ||all(ismember(F5,T(i,:)))||all(ismember(F6,T(i,:)))                
%             A{b}=[A{b},i];
%             end
%         otherwise
%             if all(ismember(F1,T(i,:)))||all(ismember(F2,T(i,:)))...
%                 ||all(ismember(F3,T(i,:)))||all(ismember(F4,T(i,:)))            
%             A{b}=[A{b},i];
%             end
%         end
%     end
% end
%  end

  i = (1:sizeT)';
  j = T;
  VT = sparse([i i i i],j,1);
  indices = 1:size(T,1);
  adjF = cell(sizeT,1);
  switch type    
    case 'face'  
    k = nchoosek([1,2,3,4],3);
    for ii = 1:sizeT
        for j = 1:size(k,1)
        adjF{ii} = unique([adjF{ii},intersect(intersect(indices(logical(VT(:,T(ii,k(j,1))))),...
            indices(logical(VT(:,T(ii,k(j,2)))))),indices(logical(VT(:,T(ii,k(j,3))))))]);            
        end
    end
    case 'edge' 
    k = nchoosek([1,2,3,4],2);
    for ii = 1:sizeT
        for j = 1:size(k,1)
        adjF{ii} = unique([adjF{ii},intersect(indices(logical(VT(:,T(ii,k(j,1))))),...
            indices(logical(VT(:,T(ii,k(j,2))))))]);            
        end
    end
    case 'vertex'        
    for ii = 1:sizeT
        for j = 1:4
        adjF{ii} = unique([adjF{ii},indices(logical(VT(:,T(ii,j))))]);
        end
    end
  end
end