function [res] = interpolate(sig, epsilon, cubic=0)
    % calcualte the interpolated signal
    % sig: signal to interpolate
    % epsilon: interpolation variable
    % cubic: if 0, use linear interpolation, else cubic interpolation
    % res: interpolated signal (synchronized)
    if cubic == 1,
        % cubic interpolation
        epsilon = epsilon(1:length(sig));
        sig = [0; sig; 0; 0];
        m = inv([-1 1 -1 1; 0 0 0 1; 1 1 1 1; 8 4 2 1]);
        e = 1/6;
        a = m(1,1)*sig(1:end-3) + m(1,2)*sig(2:end-2) + m(1,3)*sig(3:end-1)...
            + m(1,4)*sig(4:end);
        b = m(2,1)*sig(1:end-3) + m(2,2)*sig(2:end-2) + m(2,3)*sig(3:end-1)...
            + m(2,4)*sig(4:end);
        c = m(3,1)*sig(1:end-3) + m(3,2)*sig(2:end-2) + m(3,3)*sig(3:end-1)...
            + m(3,4)*sig(4:end);
        d = m(4,1)*sig(1:end-3) + m(4,2)*sig(2:end-2) + m(4,3)*sig(3:end-1)...
            + m(4,4)*sig(4:end);
        res = a.*epsilon.^3 + b.*epsilon.^2 + c.*epsilon + d;
    else
        % linear interpolation
        epsilon = epsilon(1:length(sig) - 1);
        res = (1.-epsilon).*sig(1:end-1) + epsilon.*sig(2:end);
    end
end
