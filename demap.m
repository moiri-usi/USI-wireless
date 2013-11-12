function [bit2] = demap(symb)

    bit2 = [(real(symb) > 0)';(imag(symb) < 0)'](:);

end
