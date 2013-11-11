stream = randint(100);
stream_in = stream(:);
symb = map(stream_in);

symb_noise = awgn(symb,12);

stream_out = demap(symb_noise);

ber = sum(xor(stream_in,stream_out))/length(stream_in);
