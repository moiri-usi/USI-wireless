stream = randint(1000);
stream_in = stream(:);
demap_table_1 = [1 0; 1 1; 0 1; 0 0];
demap_table_2 = [0 0; 0 1; 1 0; 1 1];
symb_1 = map(stream_in, 1);
symb_2 = map(stream_in, 0);

snr = [-6:0.5:12];
ber_1 = zeros(1, length(snr));
ber_2 = zeros(1, length(snr));
for n=1:length(snr),
    symb_noise_1 = awgn(symb_1,snr(n));
    symb_noise_2 = awgn(symb_2,snr(n));

    stream_out_1 = demap(symb_noise_1, demap_table_1);
    stream_out_2 = demap(symb_noise_2, demap_table_2);

    ber_1(n) = sum(xor(stream_in,stream_out_1))/length(stream_in);
    ber_2(n) = sum(xor(stream_in,stream_out_2))/length(stream_in);
end

% grey-code results in a better BER because if a symbol is in the wrong quadrant
% only one bit is wrong. In case of the alternative encoding, a symbol in a
% wrong quadrant may result in two wrong bits.
clf;
semilogy(snr, ber_1, snr, ber_2);
legend('grey-code', 'alternative');
xlabel('SNR [dB]');
ylabel('BER');
axis([min(snr) max(snr)]);
grid on;
