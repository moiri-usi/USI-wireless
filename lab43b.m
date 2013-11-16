taps = 20;
T = 1;
roll_off = 0.22;
L = 4;
Nc_max = 100;
Nc_step = 1;
Nc_cnt = Nc_max/Nc_step;
lambda = 30;
sig = load('r_sequence_4_8dB.mat');

sig_up_rcv = rrcf(sig.r, taps, T, roll_off, L);
sig_rcv = downsample(sig_up_rcv, L);

%%%%%%%%%%% no interpolation %%%%%%%%%%%%%%%%%
start_point = frame_sync(sig_rcv, lambda);
img_size = sig.image_size;
img = sig_rcv(start_point:start_point+img_size(1)*img_size(2)*4-1);

bit = demap(img);

ber1 = sum(xor(bit, sig.ber_pn_seq))/length(bit);
ber1 = repmat(ber1, Nc_cnt, 1);
ber2 = zeros(Nc_cnt,1);
ber3 = zeros(Nc_cnt,1);
for n=1:Nc_cnt,
    Nc = n*Nc_step;
    epsilon = t_estimator(sig_up_rcv, Nc);    % use if epsilon changes in time
    %epsilon = t_estimator(sig_up_rcv);        % use if epsilon is constant

    %%%%%%%%%%% interpolate linear %%%%%%%%%%%%%%%%%
    sig_sync = interpolate(sig_rcv, epsilon, 0);
    start_point = frame_sync(sig_sync, lambda);
    img_size = sig.image_size;
    img = sig_sync(start_point:start_point+img_size(1)*img_size(2)*4-1);

    bit = demap(img);

    ber2(n) = sum(xor(bit, sig.ber_pn_seq))/length(bit);

    %%%%%%%%%%% interpolate cubic %%%%%%%%%%%%%%%%%
    sig_sync = interpolate(sig_rcv, epsilon, 1);
    start_point = frame_sync(sig_sync, lambda);
    img_size = sig.image_size;
    img = sig_sync(start_point:start_point+img_size(1)*img_size(2)*4-1);

    bit = demap(img);

    ber3(n) = sum(xor(bit, sig.ber_pn_seq))/length(bit);
end

% asmtotes by using infinite window
epsilon = t_estimator(sig_up_rcv);        % use if epsilon is constant

%%%%%%%%%%% interpolate linear %%%%%%%%%%%%%%%%%
sig_sync = interpolate(sig_rcv, epsilon, 0);
start_point = frame_sync(sig_sync, lambda);
img_size = sig.image_size;
img = sig_sync(start_point:start_point+img_size(1)*img_size(2)*4-1);

bit = demap(img);

ber4 = sum(xor(bit, sig.ber_pn_seq))/length(bit);
ber4 = repmat(ber4, Nc_cnt, 1);

%%%%%%%%%%% interpolate cubic %%%%%%%%%%%%%%%%%
sig_sync = interpolate(sig_rcv, epsilon, 1);
start_point = frame_sync(sig_sync, lambda);
img_size = sig.image_size;
img = sig_sync(start_point:start_point+img_size(1)*img_size(2)*4-1);

bit = demap(img);

ber5 = sum(xor(bit, sig.ber_pn_seq))/length(bit);
ber5 = repmat(ber5, Nc_cnt, 1);
clf;
x = [Nc_step:Nc_step:Nc_max];
plot(x, ber1, '1', x, ber2, '2', x, ber3, '3', x, ber4, '2.', x, ber5, '3.');
legend('no interpolation', 'linear', 'cubic',...
    'linear (Nc=inf)', 'cubic (Nc=inf)');
xlabel('Nc');
ylabel('BER');