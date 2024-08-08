function X = inverseFFT(X)
    % Inverse FFT implementation using the iterative FFT function
    % Input:
    %   X - input signal (vector of complex numbers)
    % Output:
    %   x - inverse FFT of the input signal

    N = length(X);
    X = conj(X);  % Conjugate the input signal
    X = iterativeFFT(X);  % Apply the FFT
    X = conj(X);  % Conjugate the result
    X = X / N;  % Normalize by dividing by the length

    return;  % Explicit return statement
end
