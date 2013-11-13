function [res] = rrcf (sig, tabs=5, T=0.001, roll_off=0.22, L=4)
    % filter the signal by the root raised cosine
    % sig: signal to be filtered
    % tabs: number of samples in one T of the RRC
    % T: samling time
    % roll_off: roll off value
    % return: filtered signal

    grrc = rrc(tabs, T, roll_off, L);
    grrc_m = spdiags(repmat(grrc, length(grrc), 1)');

    d_sig_len = size(grrc_m)(2);
    d_res_len = size(grrc_m)(1);
    d_pad = mod((length(sig) + 2*d_res_len), d_sig_len-(d_res_len-1));
    sig_pad = [zeros(d_res_len,1);sig;zeros(d_res_len,1);...
        zeros(d_sig_len-(d_res_len-1) - d_pad, 1)];

    sig_m_shape = reshape(sig_pad, d_sig_len-(d_res_len-1), []);
    sig_m = [zeros(d_res_len-1, 1) sig_m_shape(end-(d_res_len-2):end, :);...
        sig_m_shape zeros(d_sig_len-(d_res_len-1), 1)];

    res = grrc_m*sig_m;
    res = res(:);
    res = res(find(res,1,'first'):find(res,1,'last'));
end
