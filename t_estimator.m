function [res] = t_estimator(sig, Nc)
    L = 4;
    seq = [(-i)^Nc;(-i)^(Nc+1);(-i)^(Nc+2);(-i)^(Nc+3)];
    seq = repmat(seq, Nc, 1);
    sig_p = [zeros(4*Nc, 1); sig; zeros(4*Nc, 1); zeros(4-mod(length(sig), 4), 1)];
    sig_b4 = reshape(sig_p, L, []).';
    sig_m = [];
    for n=1:Nc,
        sig_m = [sig_m [zeros(Nc-n, L);sig_b4;zeros(n-1,L)]];
    end
    epsilon = -1/(2*pi)*arg(sig_m*seq);
    res = epsilon(:);
end
