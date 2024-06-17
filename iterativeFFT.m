function X = iterativeFFT(x)
    % Iterative FFT implementation using the Cooley-Tukey algorithm
    % Input:
    %   x - input signal (vector of complex numbers)
    % Output:
    %   X - FFT of the input signal
    
    N = length(x);
    X = bitrevorder(x);  % Reorder the input using bit-reversed order
    
    % Precompute twiddle factors (roots of unity)
    W = exp(-2i * pi * (0:N/2-1) / N);
    
    % Perform the FFT using the iterative approach
    for len = 2:2:N
        for start = 1:len:N
            for k = 0:len/2-1
                % Combine the results of smaller transforms
                t = W(k * N / len + 1) * X(start + k + len/2);
                X(start + k + len/2) = X(start + k) - t;
                X(start + k) = X(start + k) + t;
            end
        end
    end

    return;  % Explicit return statement
end
