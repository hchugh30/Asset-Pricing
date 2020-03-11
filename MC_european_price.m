% Assignement 4 - Hardik Chugh - 1005587866
function [call, put] = MC_european_price(S0, K, T, r, mu, sigma, numSteps, numPaths);
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
            
            %discounted_price = path(numSteps+1,:)*(1/(1+r/numSteps)^numSteps)
        end
    end
    
    % Calculate the payoff for each path for a Call
    Callpayoff = max(paths(numSteps+1,:)-K, 0); 
    
    % Calculate the payoff for each path for a Put
    Putpayoff = max(K - paths(numSteps+1,:), 0);
    
    call = mean(Callpayoff*(1/(1+r/numSteps)^numSteps));
    
    put = mean(Putpayoff*(1/(1+r/numSteps)^numSteps));
    
    % Plot paths
    figure;
    set(gcf, 'color', 'white');
    plot(0:numSteps, paths', 'Linewidth', 2);
    title('MC Geometric Random Walk Paths', 'FontWeight', 'bold');
end

