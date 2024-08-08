% Function to plot the DTFT
function dtft_plot(x, N)
    % Define the number of points for the FFT
    N = length(x);

    % Compute the FFT of the signal
    X = fft(x, N);

    % Define the frequency axis
    f = (-N/2:N/2-1) * (1/N);

    % Compute the magnitude and phase of the FFT
    magnitude = abs(fftshift(X));
    phase = angle(fftshift(X));

    % Plot the magnitude spectrum
    figure;
    subplot(2,1,1);
    plot(f, magnitude);
    title('Magnitude Spectrum');
    xlabel('Frequency (normalized)');
    ylabel('Magnitude');
    grid on;

    % Plot the phase spectrum
    subplot(2,1,2);
    plot(f, phase);
    title('Phase Spectrum');
    xlabel('Frequency (normalized)');
    ylabel('Phase (radians)');
    grid on;
end
