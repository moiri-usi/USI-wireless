img = load('r_image_2_10.mat');
tic;
sig_conv = rrcf(img.r);
%sig_conv = rrcf([1 0 0 0 1 0 0 0]);
toc;
plot(sig_conv);

