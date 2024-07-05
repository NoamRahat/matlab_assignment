% Generate random input data
N = 16; % Length of the sequence
x = randn(N, 1) + 1i * randn(N, 1); % Random complex sequence

% Compute FFT using iterativeFFT function
X_iterative = iterativeFFT(x);

% Compute FFT using MATLAB's fft function
X = fft(x);

% Displaying results for comparison
disp('Original x:');
disp(x.');

disp('FFT using iterativeFFT function:');
disp(X_iterative.');

disp('FFT using fft function:');
disp(X.');
