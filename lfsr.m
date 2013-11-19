function [res] = lfsr (polynom, reg, Np)
    mask = polynom(2:end);
    out = [];

    for n=1:Np,
        out_bit = mod(sum(reg .* mask), 2);
        out = [reg(end) out];
        reg = [out_bit reg(1:end-1)];
    end
    res = fliplr(out);
end
