L = 4;
T = 1;
roll_off=0.22;
lambda = 30;
tabs = 20;
demap_table = [1 0; 1 1; 0 1; 0 0];
sig = load('r_image_3_10dB.mat');

sig_conv_rcv = rrcf(sig.r, tabs, T, roll_off, L);
sig_rcv = downsample(sig_conv_rcv, L);

start_point = frame_sync(sig_rcv, lambda);
img_size = sig.image_size;
img = sig_rcv(start_point:start_point+img_size(1)*img_size(2)*4-1);

bit = demap(img, demap_table);

img_bit8 = reshape(bit, 8, [])';
img_uint = uint8(bi2de(img_bit8));
img_m = reshape(img_uint, [], img_size(1))';
clf;
imageview(img_m);
