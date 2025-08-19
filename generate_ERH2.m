%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate the incidence matrix for an Erdos Renyi Hypergraph 
% 
% Input:    N (number of nodes), M (number of edges), s (hyperedge-size
% sequence), Me (sequence specifying the number of hyperedges of each size)
% Output:    Id (incidence matrix of edges), Ie (incidence matrix of 
% hyperedges)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Id,Ie] = generate_ERH2(N,M,s,Me)
    Md=nchoosek(1:N,2);
    md=nchoosek(N,2);
    index1=randperm(md);
    index1=index1(1:M);
    Id=zeros(N,M);
    for j=1:M
        for i=1:2
            Id(Md(index1(j),i),j)=1;
        end
    end
    h=length(s);
    Ie=zeros(N,Me(1));
    for j=1:Me(1)
        index2=randsample(N,s(1));
        Ie(index2,j)=ones(size(index2));
    end
    Ie=transpose(unique(transpose(Ie),'rows'));
    for i=2:h
        I_temp=zeros(N,Me(i));
        for j=1:Me(i)
            index2=randsample(N,s(i));
            I_temp(index2,j)=ones(size(index2));
        end
        I_temp=transpose(unique(transpose(I_temp),'rows'));
        Ie=[Ie I_temp];
    end
end
