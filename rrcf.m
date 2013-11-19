function [res] = rrcf (sig, taps, T, roll_off, L)
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
