% Load the signal from the .mat file
load('sig_x.mat');  % This loads the variable 'x' from 'sig_x.mat'


% Check if the variable 'x' exists in the workspace
if exist('x', 'var')
    % Define the time vector
    n = 0:length(x)-1;  % Assuming the signal starts at n=0

    % Plot a specific portion of the signal (zoomed in)
    start_index = 1;  % Starting index for zooming in
    end_index = min(length(x), 1000);  % Ending index for zooming in (adjust as needed)
    x_zoomed = x(start_index:end_index);
    n_zoomed = start_index:end_index;

    % Plot the zoomed portion of the signal in the time domain
    figure;
    plot(n_zoomed, x_zoomed);
    title('Zoomed Portion of Signal in Time Domain');
    xlabel('n (samples)');
    ylabel('x[n]');
    grid on;

    % Define the sampling rate (in Hz)
    fs = 18000;  % Assuming the sampling rate is 18000 Hz as mentioned

    % Compute the FFT of the signal
    X = fft(x);

    % Define the frequency axis
    N = length(X);
    f = (-N/2:N/2-1) * (fs / N);  % Frequency axis centered around 0

    % Compute the magnitude of the FFT and shift it
    magnitude = abs(fftshift(X));
    phase = angle(fftshift(X));

    % Plot the magnitude spectrum centered around 0
    figure;
    plot(f, magnitude);
    title('Magnitude Spectrum of the Signal (Centered)');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    grid on;

    % Detect and print the active frequencies
    threshold = max(magnitude) * 0.1;  % Set a threshold at 10% of the maximum magnitude
    active_indices = find(magnitude > threshold);
    active_frequencies = f(active_indices);


    fprintf('Active frequencies in the signal (above threshold):\n');
    disp(active_frequencies);

    % Find the amplitudes and phases for the active frequencies
    amplitudes = magnitude(active_indices);
    phases = phase(active_indices);

    % Display the mathematical representation
    fprintf('Mathematical representation of the signal:\n');
    for i = 1:length(active_frequencies)
        fprintf('A%d * cos(2 * pi * %.0f * n / %.0f + %.2f)\n', i, abs(active_frequencies(i)), fs, phases(i));
    end
    



else
    disp('The variable x is not found in the loaded .mat file.');
end



% Define the number of points for the FFT (e.g., 1024)
% N = 1024;

% Compute and plot the DTFT
% dtft_plot(x, N);

