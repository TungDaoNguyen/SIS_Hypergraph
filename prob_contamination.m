%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Probability of contamination of an environment
%
% Input:    X (vector of states of nodes), I_e (incidence matrix for 
% E_e), sigma (vector of physical condition of environments)
% Output:   r (probability of contamination)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function r = prob_contamination(X,I_e,sigma)
    N=size(X,2);    %number of nodes
    me=size(I_e,2); %number of hyperedges in E_e
    r=zeros(1,me);
    %choose the function f_e
    function fe = f_e(x) 
        fe=atan(x); 
    end
    for j=1:me
        r(j)=sigma*f_e(dot(X,I_e(:,j)));
    end
end