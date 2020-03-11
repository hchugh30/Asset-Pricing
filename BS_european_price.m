% Assignement 4 - Hardik Chugh - 1005587866
function [call_BS_European_Price, put_BS_European_Price] = BS_european_price(S0, K, T, r, sigma)

d1 = (log(S0/K)+(r+(0.5*sigma^2))*T)/(sigma*sqrt(T));
d2 = d1-(sigma*sqrt(T));

% The value of a European call option for a non-dividend-paying underlying stock in terms of the Black–Scholes parameters is:   
call_BS_European_Price = (S0*normcdf(d1))-(exp(-r*(T))*K*normcdf(d2));

% The value of a European put option for a non-dividend-paying underlying stock in terms of the Black–Scholes parameters is:       
put_BS_European_Price = (exp(-r*(T))*K*normcdf(-d2)) - (S0*normcdf(-d1));

end

