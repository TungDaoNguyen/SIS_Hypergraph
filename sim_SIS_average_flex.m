%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% A function that runs n simulations of the stochastic SIS model until the runtime is reached, then average.
%
% Inputs:   
%           1/ Hypergraph: I_d and I_e (incidence matrices for edges and hyperedges)
%           2/ Node update: beta_d (infection rate from other nodes), beta_e (infection rate from environments), gamma (recovery rate of nodes)
%           3/ Hyperedge update: sigma (contamination rate from nodes) 
%                                delta (VECTOR of recovery rates of environments)
%           4/ Initial condition: p (proportion of initial infected nodes)
%           5/ Run time and number: dt (time step size), T (number of time steps), n (number of runs to average over)
% Outputs:  
%           1/ xbarsmooth (proportion of infected nodes, average over n runs)
%           2/ ybarsmooth (proportion of risky environments, average over n runs)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [xbarsmooth,ybarsmooth] = sim_SIS_average_flex(Id,Ie,beta_d,beta_e,gamma,sigma,delta,p,dt,T,n)

%Retrieve the number of nodes, edges and hyperedges from the incidence matrices
N=size(Id,1);
Md=size(Id,2);
Me=size(Ie,2);



%Generate the initial conditions
x0=initial(N,p);
y0=zeros(1,size(Ie,2)); %Initially there is no contaminated hyperedge



%Create matrices of nodes and hyperedges states for all time steps
x=zeros(T+1,N);
x(1,:)=x0;
y=zeros(T+1,Me);
y(1,:)=y0;
xbar=zeros(T+1,n);
ybar=zeros(T+1,n);
for m=1:n

%Update states of the stochastic model
for t=1:T
    %update states of nodes
    q=rand(1,N); %create N random iid
    rn=prob_infection(x(t,:),y(t,:),Id,Ie,beta_d,beta_e); %compute infection probability
    for i=1:N
        %node gets infected
        if x(t,i)==0
            if q(i)<1-exp(-(rn(i)*dt))
                x(t+1,i)=1;
            else
                x(t+1,i)=0;
            end
        end
        %node recovers
        if x(t,i)==1
            if q(i)<1-exp(-(gamma*dt))
                x(t+1,i)=0;
            else
                x(t+1,i)=1;
            end
        end
    end
    %update states of environments
    r=rand(1,Me); %create me random iid
    re=prob_risk(x(t,:),Ie,sigma); %compute increase risk probability
    for j=1:Me
        %environment turns from low to high risk
        if y(t,j)==0
            if r(j)<1-exp(-re(j)*dt)
                y(t+1,j)=1;
            else
                y(t+1,j)=0;
            end
        end
        %environment recovers
        if y(t,j)==1
            if r(j)<1-exp(-delta(j)*dt)
                y(t+1,j)=0;
            else
                y(t+1,j)=1;
            end
        end
    end
end


%Proportion of infected nodes and contaminated hyperedges in the stochastic model
xbar(:,m)=mean(x,2);
ybar(:,m)=mean(y,2);
end

%Average the proportion above across n runs
xbarsmooth=mean(xbar,2);
ybarsmooth=mean(ybar,2);


%Plot the proportion of infected nodes and contaminated hyperedges in the stochastic and mean-field model together
plot(xbarsmooth);hold on;
%plot(ybarsmooth,'b');
%legend({'$\bar{X}(t)$','$\bar{Y}(t)$'},'Interpreter','latex');
%hold off;shg;
end