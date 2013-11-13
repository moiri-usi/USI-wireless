L = 4;
tabs = 16;
T = 0.001;
roll_off=0.22;
lambda = 30;
snr = inf;
sig = load('r_image_3_2dB.mat');

sig_conv_rcv = rrcf(sig.r, tabs, T, roll_off, L);
sig_rcv = downsample(sig_conv_rcv, L);

start_point = frame_sync(sig_rcv, lambda);
img_size = sig.image_size;
img = sig_rcv(start_point:start_point+img_size(1)*img_size(2)*4-1);

bit2 = demap(img);

img_bit8 = reshape(bit2, 8, [])';
img_uint = uint8(bi2de(img_bit8));
img_m = reshape(img_uint, [], img_size(1))';
imshow(img_m);
