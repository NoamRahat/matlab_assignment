function X = iterativeFFT(x)
    % Iterative FFT implementation using the Cooley-Tukey algorithm
    % Input:
    %   x - input signal (vector of complex numbers)
    % Output:
    %   X - FFT of the input signal
    
    N = length(x);
    
    % Check if N is a power of 2
    if bitand(N, N - 1) ~= 0
        error('Length of input signal must be a power of 2.');
    end
    
    % Bit-reversed order permutation
    X = bitrevorder(x);
    
    % Perform the FFT using the iterative approach
    for len = 2:2:N
        halfLen = len / 2;
        W = exp(-2i * pi * (0:halfLen-1) / len);  % Twiddle factors for current stage
        for start = 1:len:N
            for k = 0:halfLen-1
                index1 = start + k - 1;  % Adjusted for MATLAB's 1-based indexing
                index2 = start + k + halfLen - 1;  % Adjusted for MATLAB's 1-based indexing
                
                % Combine the results of smaller transforms
                t = W(k + 1) * X(index2 + 1);  % Adjusted for MATLAB's 1-based indexing
                X(index2 + 1) = X(index1 + 1) - t;  % Adjusted for MATLAB's 1-based indexing
                X(index1 + 1) = X(index1 + 1) + t;  % Adjusted for MATLAB's 1-based indexing
            end
        end
    end
end
