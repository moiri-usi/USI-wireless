function [bit2] = demap(symb, code=1)

    if code == 1,
        bit2 = [(real(symb) > 0)';(imag(symb) < 0)'](:);
    else,
        bit2 = [(real(symb) < 0)';xor((imag(symb) > 0)',(real(symb) > 0)')](:);
    end

end
