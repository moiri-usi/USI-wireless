function [res] = lfsr (polynom, reg, Np, inversed=0)
    mask = polynom(2:end);
    out = [];

    for n=1:Np,
        out_bit = mod(sum(reg .* mask), 2);
        if inversed == 1,
            out = [out reg(end)];
        else
            out = [reg(end) out];
        end
        reg = [out_bit reg(1:end-1)];
    end
    res = out;
end
