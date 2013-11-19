function res = demap(symb, demap_table)
    % each symbol is mapped to its quadrant and a corresponding bit value is
    % assigned
    % symb: vector of symbols
    % demap_table: table of bits mapped to the quadrands ([q1;q4;q3;q2])
    % res: vector of bits

    res(real(symb) >= 0 & imag(symb) >= 0,1) = demap_table(1,1);
    res(real(symb) >= 0 & imag(symb) >= 0,2) = demap_table(1,2);
    res(real(symb) >= 0 & imag(symb) <= 0,1) = demap_table(2,1);
    res(real(symb) >= 0 & imag(symb) <= 0,2) = demap_table(2,2);
    res(real(symb) <= 0 & imag(symb) <= 0,1) = demap_table(3,1);
    res(real(symb) <= 0 & imag(symb) <= 0,2) = demap_table(3,2);
    res(real(symb) <= 0 & imag(symb) >= 0,1) = demap_table(4,1);
    res(real(symb) <= 0 & imag(symb) >= 0,2) = demap_table(4,2);

    res = reshape(res', [], 1);

end
