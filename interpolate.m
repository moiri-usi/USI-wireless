function [res] = interpolate(sig, epsilon, t='linear')
    if t == 'linear',
        epsilon = epsilon(1:length(sig) - 1);
        res = (1.-epsilon).*sig(1:end-1) + epsilon.*sig(2:end);
    else
        res = sig;
    end
end
