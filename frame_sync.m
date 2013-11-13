function [res] = frame_sync(sig, p, lambda)
    % detect the starting point in a stream by matching a pattern
    % sig: input signal where the starting point needs to be found
    % p: pattern
    % lambda: detection treshold
    % return: staring index
    Np = length(p);
    for n=1:(length(sig)-Np+1),
        sig_w = sig(n:Np+n-1);
        cn_2 = abs(p*sig_w)^2;
        tresh = cn_2/sum(abs(sig_w).^2);
        if tresh > lambda,
            start_point = Np + n;
            break;
        end
    end
    res = start_point;
end
