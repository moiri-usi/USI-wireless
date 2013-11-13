function [res] = rrc (tabs, T, a, L)
    % compute root rised cosine
    % t: vector with sampüle points of the function
    % T: sampling time
    % a: rolloff factor
    ts = T / L;
    t = [-tabs*ts:ts:tabs*ts];
    res = ((4*a/pi)*cos(pi*(1+a)*t/T) + ...
        (1-a)*sinc((1-a)*t/T)) ./ (1-(4*a*t/T).^2);
end
