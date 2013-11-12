tic
pf = [1 0 0 0 1 1 1 0 1];
pinit = [1 1 1 1 1 1 1 1];
Np = 200;
lambda = 30;
sig = load('r_image_2_10.mat');
p = lfsr(pf, pinit, Np, 1);
p(p == 1) = -1;
p(p == 0) = 1;
for n=1:(length(sig.r)-Np+1),
    sig_w = sig.r(n:Np+n-1);
    cn_2 = abs(p*sig_w)^2;
    tresh = cn_2/sum(abs(sig_w).^2);
    if tresh > lambda,
        start_point = Np + n;
        break;
    end
end
img_size = sig.image_size;
img = sig.r(start_point:start_point+img_size(1)*img_size(2)*4-1);

bit2 = demap(img);

img_bit8 = reshape(bit2, 8, [])';
img_uint = uint8(bi2de(img_bit8));
img_m = reshape(img_uint, [], img_size(1))';
imshow(img_m);
toc
