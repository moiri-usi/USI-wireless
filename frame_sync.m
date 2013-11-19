function [res res2] = frame_sync(sig, lambda)
    % detect the starting point in a stream by matching a pattern
    % sig: input signal where the starting point needs to be found
    % p: pattern
    % lambda: detection treshold
    % return: staring index
    pf = [1 0 0 0 1 1 1 0 1];
    pinit = [1 1 1 1 1 1 1 1];
    Np = 200;

    p = lfsr(pf, pinit, Np);

    p(p == 1) = -1;
    p(p == 0) = 1;
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
