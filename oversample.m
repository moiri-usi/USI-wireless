function [res] = oversample (symb, L)
    % oversample symbol stream by the factor L
    % symb: vector of symbols
    % L: oversample rate
    s0 = zeros(length(symb)*L, 1);
    s0(1:L:end) = symb;
    res = s0;
end
