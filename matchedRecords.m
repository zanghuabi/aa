function [ indexs ] = matchedRecords(U,T)  
N = size(T,1);  
indexs = find(U(:,T(1,1))==T(1,2));  
% version 1  
% if N > 1  
%     for i=2:N  
%        ind =  find(U(:,T(i,1))==T(i,2));  
%        indexs = intersect(ind,indexs);  
%     end  
% end  
  
% version 2  
if N>1  
    for i=2:N  
        if numel(indexs)==1  
            return;  
        else  
            % ind =  find(U(indexs,T(i,1))==T(i,2));  
            % indexs =  indexs(ind);  
            % use logical index is faster than find  
            ind = U(indexs,T(i,1))==T(i,2);  
            indexs = indexs(ind);  
        end  
    end  
end  
  
end  
