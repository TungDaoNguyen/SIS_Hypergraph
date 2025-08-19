%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Probability of infection of nodes
%
% Input:    X (vector of states of nodes), Y (vector of states of
% environments), I_d (incidence matrix for E_d), I_e (incidence matrix for
% E_e), beta_d (infection rate from other nodes), beta_e (infection rate
% from environments)
% Output:   r (probability of infection)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function r = prob_infection(X,Y,I_d,I_e,beta_d,beta_e)
    N=size(X,2);    %number of nodes
    md=size(I_d,2); %number of hyperedges in E_d
    me=size(I_e,2); %number of hyperedges in E_e
    r=zeros(1,N);
    for i=1:N
        % first add the infection rates from all direct contacts
        for h=1:md
            r(i)=r(i)+beta_d*I_d(i,h)*dot(X,I_d(:,h)); 
        end
        % then add the infection rates from all environments
        for h=1:me
            r(i)=r(i)+beta_e*I_e(i,h)*Y(h);
        end
    end
end