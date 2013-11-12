function [symb] = map(stream, code=1)
    stream = [stream zeros(mod(length(stream), 2))];
    b = reshape(stream, 2, [])';
    b_out(b(:,1) == not(code),1) = -1;
    b_out(b(:,1) == code,1) = 1;
    if code == 1,
        b_out(b(:,2) == 1,2) = -1;
        b_out(b(:,2) == 0,2) = 1;
    else
        b_out(xor(b(:,1), b(:,2)),2) = -1;
        b_out(not(xor(b(:,1), b(:,2))),2) = 1;
    end
    symb = b_out(:,1)/sqrt(2) + i*b_out(:,2)/sqrt(2);
end
