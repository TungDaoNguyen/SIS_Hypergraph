%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial
% 
% Generate a vector of initial states.
%
% Input:    n (number of nodes or hyperedges), p (probability that each 
% state is assigned value 1)
% Output:   x0 (a vector of states of nodes or environments)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function X0 = initial(n,p)
    n0=n*p;
    X0=zeros(1,n);
    X0(randsample(1:n,n0))=1;
end