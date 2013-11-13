function [res] = rrcf (sig, tabs=5, T=0.1, roll_off=0.22)
    L = 4;
    sig_over = oversample(sig, L);
    grrc = rrc(tabs, T, roll_off);
    grrc_m = spdiags(repmat(grrc, length(grrc), 1)');
    d_sig_len = size(grrc_m)(2);
    d_res_len = size(grrc_m)(1);
    d_pad = mod((length(sig_over) + 2*d_res_len), d_sig_len-(d_res_len-1));
    sig_over_pad = [zeros(d_res_len,1);sig_over;zeros(d_res_len,1);...
        zeros(d_sig_len-(d_res_len-1) - d_pad, 1)];
    sig_m_shape = reshape(sig_over_pad, d_sig_len-(d_res_len-1), []);
    sig_m = [zeros(d_res_len-1, 1) sig_m_shape(end-(d_res_len-2):end, :);...
        sig_m_shape zeros(d_sig_len-(d_res_len-1), 1)];
    res = grrc_m*sig_m;
    res = res(:);
end
