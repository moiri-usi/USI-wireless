taps = 20;
T = 1;
roll_off = 0.22;
L = 4;
Nc = inf;
lambda = 30;
sig = load('r_sequence_4_8dB.mat');

sig_up_rcv = rrcf(sig.r, taps, T, roll_off, L);
epsilon = t_estimator(sig_up_rcv, Nc);    % use if epsilon changes in time
%epsilon = t_estimator(sig_up_rcv);        % use if epsilon is constant

%%%%%%%%%%% no interpolation %%%%%%%%%%%%%%%%%
sig_rcv = downsample(sig_up_rcv, L);
start_point = frame_sync(sig_rcv, lambda);
img_size = sig.image_size;
img = sig_rcv(start_point:start_point+img_size(1)*img_size(2)*4-1);

bit = demap(img);

ber1 = sum(xor(bit, sig.ber_pn_seq))/length(bit)

img_bit8 = reshape(bit, 8, [])';
img_uint = uint8(bi2de(img_bit8));
img_m = reshape(img_uint, [], img_size(1))';

clf
subplot(3,1,1)
imshow(img_m);

%%%%%%%%%%% interpolate linear %%%%%%%%%%%%%%%%%
sig_up_sync = interpolate(sig_up_rcv, epsilon, 0);
sig_sync = downsample(sig_up_sync, L);
start_point = frame_sync(sig_sync, lambda);
img_size = sig.image_size;
img = sig_sync(start_point:start_point+img_size(1)*img_size(2)*4-1);

bit = demap(img);

ber2 = sum(xor(bit, sig.ber_pn_seq))/length(bit)
gain12 = (ber1-ber2)/ber2*100

img_bit8 = reshape(bit, 8, [])';
img_uint = uint8(bi2de(img_bit8));
img_m = reshape(img_uint, [], img_size(1))';

subplot(3,1,2)
imshow(img_m);

%%%%%%%%%%% interpolate cubic %%%%%%%%%%%%%%%%%
sig_up_sync = interpolate(sig_up_rcv, epsilon, 1);
%sig_up_sync = cubic_inter(sig_up_rcv, epsilon, L);
sig_sync = downsample(sig_up_sync, L);
start_point = frame_sync(sig_sync, lambda);
img_size = sig.image_size;
img = sig_sync(start_point:start_point+img_size(1)*img_size(2)*4-1);

bit = demap(img);

ber3 = sum(xor(bit, sig.ber_pn_seq))/length(bit)
gain23 = (ber2-ber3)/ber3*100
gain13 = (ber1-ber3)/ber3*100

img_bit8 = reshape(bit, 8, [])';
img_uint = uint8(bi2de(img_bit8));
img_m = reshape(img_uint, [], img_size(1))';

subplot(3,1,3)
imshow(img_m);
