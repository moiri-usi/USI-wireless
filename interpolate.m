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
        a = -sig(1:end-3) + 3*sig(2:end-2) - 3*sig(3:end-1) + sig(4:end);
        b = 3*sig(1:end-3) - 6*sig(2:end-2) + 3*sig(3:end-1);
        c = (-2)*sig(1:end-3) - 3*sig(2:end-2) + 6*sig(3:end-1) - sig(4:end);
        d = 6*sig(2:end-2);
        res = a.*epsilon.^3 + b.*epsilon.^2 + c.*epsilon + d;
    else
        % linear interpolation
        epsilon = epsilon(1:length(sig) - 1);
        res = (1.-epsilon).*sig(1:end-1) + epsilon.*sig(2:end);
    end
end
