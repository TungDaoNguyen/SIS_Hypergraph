%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate the incidence matrix for a set of hyperedges
%
% Input:    N (the number of nodes), s (the size sequence of the hyperedges), k
% (the hyperdegree sequence)
% Output:   Ie (the incidence matrix)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Ie] = generate_CFH(N,s,k)
stubs=k;
M=length(s);
Ie=zeros(N,M);
for j=1:M
    index=find(stubs);
    if size(index,2)>=s(j)
        temp_index=randsample(index,s(j));
    else
        temp_index=datasample(index,s(j));
    end
    for i=1:s(j)
        Ie(temp_index(i),j)=Ie(temp_index(i),j)+1;
        stubs(temp_index(i))=stubs(temp_index(i))-1;
    end   
end
end