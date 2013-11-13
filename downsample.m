function [res] = downsample(sig, L)
    % downsample the signal
    % sig: signal to be downsampled
    % L: downsampling rate
    % return: down sampled signal
    res = sig(1:L:end);
end
