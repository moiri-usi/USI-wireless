function [res] = rrcf (sig, taps=5, T=0.001, roll_off=0.22, L=4)
    % filter the signal by the root raised cosine
    % sig: signal to be filtered
    % taps: number of samples in one T of the RRC
    % T: samling time
    % roll_off: roll off value
    % return: filtered signal

    grrc = rrc(taps, T, roll_off, L);
    res = custom_conv(grrc, sig);
    %res = conv(grrc, sig);
end
