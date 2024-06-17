% Main function to run the test
function main
    % Test the function
    x = [1, 2, 3, 4];  % Sample input signal
    X_iterative = iterativeFFT(x);  % Call the iterative FFT function

    % Compare with MATLAB's built-in FFT function
    X_builtin = fft(x);

    % Display the results
    disp('Iterative FFT:');
    disp(X_iterative);

    disp('Built-in FFT:');
    disp(X_builtin);

    % Test the inverse FFT function
    x_inverse = inverseFFT(X_iterative);

    % Compare with MATLAB's built-in IFFT function
    x_builtin_inverse = ifft(X_builtin);

    % Display the results
    disp('Inverse FFT (custom):');
    disp(x_inverse);

    disp('Inverse FFT (builtin):');
    disp(x_builtin_inverse);
end

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

function x = bitrevorder(x)
    % Reorder the input array according to bit-reversed order
    % Input:
    %   x - input signal (vector of complex numbers)
    % Output:
    %   x - bit-reversed ordered signal
    
    N = length(x);
    bits = log2(N);
    for i = 0:N-1
        rev_i = bitrev(i, bits);
        if rev_i > i
            % Swap elements to achieve bit-reversed order
            temp = x(i+1);
            x(i+1) = x(rev_i+1);
            x(rev_i+1) = temp;
        end
    end

    return;  % Explicit return statement
end

function r = bitrev(k, bits)
    % Compute the bit-reversed value of an integer
    % Input:
    %   k - integer to be bit-reversed
    %   bits - number of bits in the binary representation
    % Output:
    %   r - bit-reversed value of k
    
    r = 0;
    for i = 0:bits-1
        r = bitor(bitshift(r, 1), bitand(bitshift(k, -i), 1));
    end

    return;  % Explicit return statement
end
