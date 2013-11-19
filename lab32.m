L = 4;
T = 1;
roll_off=0.22;
lambda = 30;
maxTap = 32;
maxStep = maxTap/L;
demap_table = [1 0; 1 1; 0 1; 0 0];
ber = zeros(maxStep, 1);
for n=1:maxStep,
    tabs = n*L;
    sig = load('r_sequence_3_8dB.mat');

    sig_conv_rcv = rrcf(sig.r, tabs, T, roll_off, L);
    sig_rcv = downsample(sig_conv_rcv, L);

    start_point = frame_sync(sig_rcv, lambda);
    img_size = sig.image_size;
    img = sig_rcv(start_point:start_point+img_size(1)*img_size(2)*4-1);

    bit = demap(img, demap_table);
    ber(n) = sum(xor(bit, sig.ber_pn_seq))/length(bit);
end

clf;
stem([L:L:maxTap], ber);
hold on;
plot([0:maxTap], ones(maxTap+1, 1)*0.007, 'r');
grid on;
xlabel('taps');
ylabel('BER');

% a total number of taps of 12*2+1=25 tabs is enough to get a BER<0.007
