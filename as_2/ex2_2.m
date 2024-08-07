clc;
clear;
close all;

% Note that this script has the capacity to run for rect, hann and kaiser
% window. Just look for the comment CHANGE HERE and change accordingly.

% Define the different values of N
N_values = [16, 32, 64, 128, 256];

name_window = 'Rect Window'; % CHANGE HERE!!!
for N = N_values  
    % Parameters
    % N = 16; % Number of points in the window

    fs = 6720; % Sampling frequency in Hz
    beta = 5.65; % % beta parameter for the Kaiser window
    
    % CHANGE HERE!!!
    A0 = 1; % Amplitude of the first sinusoid
    A1 = 1; % Amplitude of the second sinusoid (equal to A0)
    
    delta_f_hann = 4 / N; % Frequency difference in Hz
    delta_f_rect = 2 / N;
    delta_f_kaiser = (60 - 7.95) / (14.36 * N);
    
    delta_f = delta_f_rect; % CHANGE HERE!!!

    disp(['Minimum frequency difference for N = ', num2str(N), ' (A0, A1 = ', num2str(A0), ', ', num2str(A1), ') with ', name_window, ' is ', num2str(delta_f), ' Hz']);
    
    % Frequencies
    f1 = 1600; % Frequency of the first sinusoid in Hz
    f0 = f1 + delta_f; % Frequency of the second sinusoid in Hz, ensuring |f0 - f1| = 2/N
    
    % Time vector
    t = (0:N-1)/fs;
    
    % Signal components
    x0 = A0 * sin(2 * pi * f0 * t);
    x1 = A1 * sin(2 * pi * f1 * t);
    
    % Combined signal
    x = x0 + x1;
    
    % Define the rectangular window
    rect_window = ones(N, 1);
    % Apply the rectangular window to the signal
    x_windowed_rect = x .* rect_window';
    
    
    % Apply Hann window
    hann_window = 0.5 * (1 - cos(2 * pi * (0:N-1)' / (N-1)));
    x_windowed_hann = x .* hann_window';
    
    % Generate the Kaiser window
    kaiser_window = kaiser(N, beta);
    % Apply the Kaiser window to the signal
    x_windowed_kaiser = x .* kaiser_window';
    

    x_windowed = x_windowed_rect; % CHANGE HERE!!!
    
    N2 = 256; % Zero-padding length
    x_windowed_padded = [x_windowed, zeros(1, N2-N)];
    
    % Compute the FFT
    X = fft(x_windowed_padded, N2);
    X = fftshift(X);
    f = (0:N2-1)*(fs/N2);

    % Plot the magnitude spectrum
    figure;
    plot(f, 20*log10(abs(X)));
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    title(['Magnitude Spectrum with ', name_window, ' and N = ', num2str(N)]);
    grid on;
    
    % Zoom in on the frequencies of interest
    xlim([0, fs/2]);
end;