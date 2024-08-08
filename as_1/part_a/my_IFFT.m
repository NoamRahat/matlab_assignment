function [x_reconstructed, n] = my_IFFT(X, omega, Nw)
    % Determine the time indices
    if mod(Nw, 2) == 0
        kw = linspace(-Nw/2 + 1, Nw/2, Nw);
    else
        kw = linspace(-(Nw - 1)/2, (Nw - 1)/2, Nw);
    end
    n = 2 * pi * (kw) / Nw;

    % Calculate the IFFT using the my_FFT function
    [x_reconstructed, ~] = my_FFT(X, n, Nw);

    % Normalize the result
    x_reconstructed = x_reconstructed / Nw;
end
