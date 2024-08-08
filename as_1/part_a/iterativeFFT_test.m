% Main function to run the test
function iterativeFFT_test
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
