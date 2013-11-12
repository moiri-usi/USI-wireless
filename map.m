function [symb] = map(stream)
    stream = [stream zeros(mod(length(stream), 2))];
    b = reshape(stream, 2, [])';
    b(b(:,1) == 0,1) = -1;
    b(b(:,2) == 1,2) = -1;
    b(b(:,2) == 0,2) = 1;
    symb = b(:,1)*sqrt(2) + i*b(:,2)*sqrt(2);
end
