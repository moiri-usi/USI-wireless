function [res] = rrc (tabs, T, a)
    % compute root rised cosine
    % t: vector with sampüle points of the function
    % T: sampling time
    % a: rolloff factor
    t = [-5*T:T/tabs:5*T];
    res = ((4*a/pi)*cos(pi*(1+a)*t/T) + ...
        (1-a)*sinc((1-a)*t/T)) ./ (1-(4*a*t/T).^2);
end
