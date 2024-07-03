close all;
clc;
clear;

% Load the filter
data = load('filter_0.25_101.mat'); % This loads a struct with field names matching the variables in the .mat file

% Correctly access the filter coefficients using the actual field name 'h'
filter_coefficients = data.h; % Use struct field access to get the correct filter variable

% Sampling frequency
Fs = 50;

% Number of samples to be taken from r(t)
N = 1947;

% Time vector for the continuous signal
t = (0:N-1) / Fs;

% Generate r(t)
r_t = cos(2 * pi * 5 * t) + cos(2 * pi * 10 * t);

% Sampled signal r[n]
r_n = r_t;

% Zero-padding r[n] to 2048 samples
r_n_padded = [r_n, zeros(1, 2048 - N)];

% Zero-padding the filter to 2048 samples
filter_padded = [filter_coefficients, zeros(1, 2048 - length(filter_coefficients))];

% Manually perform convolution
L = length(r_n_padded);
M = length(filter_padded);
conv_result = zeros(1, L + M - 1);
for n = 1:(L + M - 1)
    for k = 1:M
        if (n-k+1 > 0) && (n-k+1 <= L)
            conv_result(n) = conv_result(n) + r_n_padded(n-k+1) * filter_padded(k);
        end
    end
end

% Select the middle part of the convolution result to match the desired length
start_idx = ceil((L + M - 1) / 2) - 1023;
end_idx = start_idx + 2048 - 1;
conv_result = conv_result(start_idx:end_idx);

% Verify the length of conv_result
assert(length(conv_result) == 2048, 'The length of conv_result must be 2048');

% Manually perform DFT
N_fft = 2048;
S_k = zeros(1, N_fft);
for k = 1:N_fft
    for n = 1:N_fft
        S_k(k) = S_k(k) + conv_result(n) * exp(-1i * 2 * pi * (k-1) * (n-1) / N_fft);
    end
end

% Frequency vector for plotting
f = (0:2047) * (Fs / 2048);

% Plot the magnitude spectrum
figure;
plot(f, abs(S_k));
xlabel('Frequency (Hz)');
ylabel('|Ŝ[k]|');
title('Magnitude Spectrum of the Filtered Signal');
xlim([0 Fs]);
grid on;

% Detect and print the active frequencies
threshold = max(abs(S_k)) * 0.8;  % Set a threshold at 80% of the maximum magnitude
active_indices = find(abs(S_k) > threshold);
active_frequencies = f(active_indices);

fprintf('Active frequencies in the signal (above threshold):\n');
disp(active_frequencies);
