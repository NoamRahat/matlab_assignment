% Function to compute DTFT and plot the frequency response
function dtft_plot(x, N)
    % x: input signal
    % N: number of points in the FFT (typically a power of 2)
    
    % Compute the FFT
    X = fft(x, N);
    
    % Frequency vector (normalized frequency in radians/sample)
    w = (0:N-1)*(2*pi/N);
    
    % Plot the magnitude spectrum
    figure;
    subplot(2,1,1);
    plot(w, abs(X));
    title('Magnitude Spectrum');
    xlabel('Frequency (radians/sample)');
    ylabel('|X(w)|');
    
    % Plot the phase spectrum
    subplot(2,1,2);
    plot(w, angle(X));
    title('Phase Spectrum');
    xlabel('Frequency (radians/sample)');
    ylabel('Angle(X(w))');
end
