% Assignement 4 - Hardik Chugh - 1005587866
function [ call, put  ] = MC_barrier_knockin_price(S0, Sb, K, T, r, mu, sigma, numSteps, numPaths);
    
% Computes numPaths random paths for a geometric random walk
% mu is the annual drift, sigma the annual volatility
% T is the total length of time for the path (in years)
% dT is the time increment (in years)
       
    paths = zeros(numSteps+1, numPaths);
    dT = T/numSteps;
    
    % Vector of paths will store realizations of the asset price
    % First asset price is the initial price
    paths(1,:) = S0;
 
    % Generate paths
    for iPath = 1:numPaths
        for iStep = 1:numSteps
            paths(iStep+1, iPath) = paths(iStep, iPath) * exp( (mu - 0.5*sigma^2)*dT + sigma*sqrt(dT)*normrnd(0,1) );
            
        end
    end
    
    knock_call = zeros(numPaths,1);
    knock_put = zeros(numPaths,1);
    
    for p = 1:numPaths
            if (paths(:,p)<=Sb)
                Callpayoff = 0;
                Putpayoff = 0;
                
            else
                Callpayoff = max(paths(numSteps+1,p)-K, 0);
                Putpayoff = max(K - paths(numSteps+1,p), 0);
            end
        knock_call(p,1) = knock_call(p,1) + Callpayoff;
        knock_put(p,1) = knock_put(p,1) + Putpayoff;
    end
    
    call = mean(knock_call*(1/(1+r/numSteps)^numSteps));
    put = mean(knock_put*(1/(1+r/numSteps)^numSteps));

end

