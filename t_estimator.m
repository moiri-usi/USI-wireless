function [epsilon] = t_estimator(sig, Nc=inf)
    % calculates an estimation of the time delay in the signal
    % sig: input signal
    % Nc: defines the length of the window, if Nc=inf, the window size is equal
    %     to the sig size (divided by L)
    % return: vector of epsilon (estimated delay)

    L = 4;  % this implementation works only if mod(L,4) == 0. If this is true,
            % then seq is constant
    sig = abs(sig).^2;
    sig_p = [sig; zeros(L-mod(length(sig),L), 1)];
    seq = [(-i)^0;(-i)^1;(-i)^2;(-i)^3];
    seq_p = repmat(seq, length(sig_p)/L, 1);
    sig_prod = seq_p.*sig_p;
    sig_sum4 = sum(reshape(sig_prod, L, []));
    if ((Nc == inf) || (Nc > length(sig_sum4))),
        roll_sum = cumsum(sig_sum4);
    else,
        roll_sum = cumsum(sig_sum4) - ...
            [zeros(1,Nc), cumsum(sig_sum4(1:length(sig_sum4)-Nc))];
    end
    epsilon = (-1/(2*pi)*angle(roll_sum))';
    % calculate epsilon with respect to the base sample
    epsilon = sign(epsilon).*L.*mod(abs(epsilon), 1/L);
    % one epsilon for four samples
    epsilon = reshape(repmat(epsilon, 1, L)', [], 1);
end
