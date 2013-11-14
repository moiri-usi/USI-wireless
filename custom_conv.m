function [res] = custom_conv(comp1, comp2)
    % custom convolution function
    % comp1: input component 1
    % comp2: input component 2
    % res: result of convolution of comp1 and comp2

    % create diagonal band matrix with comp1
    comp1_m = spdiags(repmat(comp1, length(comp1), 1)');
    [row_cnt col_cnt] = size(comp1_m);

    % pad comp2 with zeroes at the beginning and at the end
    d_pad = mod((length(comp2) + 2*row_cnt), col_cnt-(row_cnt-1));
    comp2_pad = [zeros(row_cnt,1);comp2;zeros(row_cnt,1);...
        zeros(col_cnt-(row_cnt-1) - d_pad, 1)];

    % construct special matrix with comp2 by repeating several elements
    % st. the comp1-window does not jump components
    comp2_m_shape = reshape(comp2_pad, col_cnt-(row_cnt-1), []);
    comp2_m = [zeros(row_cnt-1, 1) comp2_m_shape(end-(row_cnt-2):end, :);...
        comp2_m_shape zeros(col_cnt-(row_cnt-1), 1)];

    res = comp1_m*comp2_m;
    res = res(:);
    % remove leading and tailing zeroes
    res = res(find(res,1,'first'):find(res,1,'last'));
end
