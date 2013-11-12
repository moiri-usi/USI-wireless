pf = [1 0 0 0 1 1 1 0 1];
pinit = [1 1 1 1 1 1 1 1];
Np = 200;
lambda = 30;
sig = load('r_image_2_10.mat');
p = lfsr(pf, pinit, Np, 1);
p(p(1,:) == 1) = -1;
p(p(1,:) == 0) = 1;
for n=1:(length(sig.r)-Np+1),
    sig_w = sig.r(n:Np+n-1);
    cn_2 = abs(sum(sig_w.*p'))^2;
    tresh = cn_2/sum(abs(sig_w).^2);
    x(n) = tresh;
    if tresh > lambda,
        start_point = Np + n;
        break;
    end
end
