function [bit2] = demap(symb)

    b1 = ones(1, length(symb));
    b0 = zeros(1, length(symb));
    b1(imag(symb)(:) > 0) = 0;
    b0(real(symb)(:) > 0) = 1;
    bit2 = [b0; b1](:);

end
