stream = randint(1000);
stream_in = stream(:);
symb_1 = map(stream_in, 1);
symb_2 = map(stream_in, 0);

snr = [-6:0.5:12];
for n=1:length(snr),
    symb_noise_1 = awgn(symb_1,snr(n));
    symb_noise_2 = awgn(symb_2,snr(n));

    stream_out_1 = demap(symb_noise_1, 1);
    stream_out_2 = demap(symb_noise_2, 0);

    ber_1(n) = sum(xor(stream_in,stream_out_1))/length(stream_in);
    ber_2(n) = sum(xor(stream_in,stream_out_2))/length(stream_in);
end

% grey-code results in a better BER because if a symbol is in the wrong quadrant
% only one bit is wrong. In case of the alternative encoding, a symbol in a
% wrong quadrant may result in two wrong bits.
semilogy(snr, ber_1, snr, ber_2)
legend('grey-code', 'alternative');
xlabel('SNR [dB]');
ylabel('BER');
axis([min(snr) max(snr)]);
grid on;
