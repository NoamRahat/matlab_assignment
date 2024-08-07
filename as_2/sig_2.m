%% Section 1: Load the Data and Plot the Signals z and y
clc;
close all;
clear all;
% Step 1: Load the data from the file 'sig_2.mat'
load('sig_2.mat', 'Fs', 'z', 'y'); % Variable names based on the file contents

% Step 2: Plot the signals z and y
figure; % Create a new figure window
plot(z, 'r'); % Plot z in red, corrected variable name
hold on; % Hold on to the current plot
plot(y, 'b'); % Plot y in blue, corrected variable name
legend('z', 'y'); % Corrected legend names
title('Signals z and y'); % Corrected title
xlabel('Sample'); % Label the x-axis
ylabel('Amplitude'); % Label the y-axis

%% Section 2: Plot the Squared Absolute Value of the DFT
% Step 3: Plot the squared absolute value of the analog Fourier transform
% Compute the DFT using FFT
N = length(z); % Assuming z and y have the same length
Z_fft = fft(z);
Y_fft = fft(y);

% Compute the frequency axis
f = Fs*(0:(floor(N/2)))/N;

% Compute the squared absolute value of the DFT
Z_fft_abs2 = abs(Z_fft(1:floor(N/2)+1)).^2;
Y_fft_abs2 = abs(Y_fft(1:floor(N/2)+1)).^2;

% Plot the squared absolute values
% Plot Z_fft_abs2
figure; % Creates a new figure window
plot(f, Z_fft_abs2);
title('Plot of Z squared absolute values');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Plot Y_fft_abs2
figure; % Creates another new figure window
plot(f, Y_fft_abs2);
title('Plot of Y squared absolute values');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%% Section 3: Design the Digital Filter and Plot the Frequency Response
% Step 2: Define filter specifications
A_p = 5; % Passband attenuation in dB
A_s = 20; % Stopband attenuation in dB
Omega_p = 3600 * 2 * pi; % Passband frequency in rad/sec
Omega_s = 3800 * 2 * pi; % Stopband frequency in rad/sec

% Convert Omega_p to Hz for plotting
F_p = Omega_p / (2 * pi); % Passband frequency in Hz
F_s = Omega_s / (2 * pi); % Stopband frequency in Hz

% Pre-warped frequencies for accurate design in the digital domain
omega_p = 2 * Fs * tan(Omega_p / (2 * Fs));
omega_s = 2 * Fs * tan(Omega_s / (2 * Fs));

% Step 3: Calculate the order of the Butterworth filter
[n, Wn] = buttord(omega_p, omega_s, A_p, A_s, 's');

% Step 4: Design the analog Butterworth filter
[b, a] = butter(n, Wn, 's');

% Plot the magnitude response of the Analog filter
[Ha, wa] = freqs(b, a, 1024);
f_a = wa / (2 * pi);  % Convert rad/sec to Hz
Ha_dB = 20 * log10(abs(Ha));  % Convert magnitude to dB

figure;
plot(f_a, Ha_dB);
title('Magnitude Response of Analog Filter H_c(jΩ) in dB');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
%xlim([3400, 4000]);

omega = logspace(log10(1), log10(1e4), 1000); % Frequency range (rad/s)
[Ha, wa] = freqs(b, a, omega);

figure;
semilogx(wa, abs(Ha));
title('Magnitude Response of Analog Butterworth Filter');
xlabel('Frequency (rad/s)');
ylabel('Magnitude');
grid on;
xlim([min(omega) max(omega)]);

% Step 5: Convert to digital filter using bilinear transformation
[bz, az] = bilinear(b, a, Fs);

% Step 6: Plot the magnitude response of the digital filter
figure;
freqz(bz, az, 1024, Fs);
title('Magnitude Response of Digital Filter H(e^{j\omega})');

% Step 7: Plot the Frequency Response of the Equivalent Analog Filter
% Compute the frequency response
[H, w] = freqz(bz, az, 1024, 'whole');

% Adjust the frequency vector to include negative frequencies
w = w - 2*pi*(w > pi);

% Convert digital angular frequency to normalized angular frequency (omega/Fs)
omega_normalized = w / Fs;

% Convert to Hz
F_analog = omega_normalized * Fs / (2 * pi);

% Compute the squared magnitude response
H_squared = abs(H).^2;

% Plot the squared magnitude response
figure;
plot(F_analog, H_squared);
title('Squared Magnitude Response of Equivalent Analog Filter H_c(j\Omega)');
xlabel('Frequency (Hz)');
ylabel('|H(j\omega)|^2');
grid on;

%%
% Set up frequency range for detailed comparison
f = linspace(0, Fs/2, 1000);  % Up to Nyquist frequency
w = 2*pi*f;                   % Angular frequency

% Digital filter response
[Hd, wd] = freqz(bz, az, w, Fs);
mag_d = 20*log10(abs(Hd));

% Analog filter response
[Ha, wa] = freqs(b, a, w);
mag_a = 20*log10(abs(Ha));

% Plotting comparison of Digital and Analog Filter Responses
figure;
plot(f, mag_d, 'b', 'LineWidth', 2);
hold on;
plot(f, mag_a, 'r--', 'LineWidth', 2);
grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Comparison of Digital and Analog Filter Responses');
legend('Digital Filter', 'Analog Filter');
xlim([3400 4000]);  % Focus on the region of interest
ylim([-60 5]);      % Adjust as needed
xline(F_p, 'g--', 'Passband');
xline(F_s, 'r--', 'Stopband');

%% Section 4: Play the Original Signals
% Create an audioplayer object for y
playerObjY = audioplayer(y, Fs);

% Define start and stop samples for a 3-second playback
startY = 1;
stopY = playerObjY.SampleRate * 3;

% Play the y signal for the first 3 seconds
play(playerObjY, [startY, stopY]);

%% Create an audioplayer object for z
playerObjZ = audioplayer(z, Fs);

% Define start and stop samples for a 3-second playback
startZ = 1;
stopZ = playerObjZ.SampleRate * 3;

% Play the z signal for the first 3 seconds
play(playerObjZ, [startZ, stopZ]);

%% Section 5: Filter the Signal z and Play the Filtered Signal
% Filter the signal z using the designed digital filter
filtered_z = filter(bz, az, z);

% Create an audioplayer object for the filtered z
playerObjFilteredZ = audioplayer(filtered_z, Fs);

% Define start and stop samples for a 3-second playback
startZ = 1;
stopZ = playerObjFilteredZ.SampleRate * 3;

% Play the filtered z signal for the first 3 seconds
play(playerObjFilteredZ, [startZ, stopZ]);

%% perfect filtering (FIR)
% Define the parameters for FIR band-stop filter
N = 1000; % Filter length
n = -N:N; % Time index
B = pi/65; % Bandwidth of the notch

% Frequency to be removed (3800 Hz) converted to rad/s
w_0 = 2*pi*3800 / Fs;

% Design the FIR filter
h_1 = (2*cos(w_0*n).*sin(B*n))./(pi*n);
h_1(N+1) = B/pi; % Correct the center value

% Filter the signal z using the FIR filter
z_fir = z - conv(z, h_1, 'same');

%% Create an audioplayer object for the filtered signal
playerObjFIRFilteredZ = audioplayer(z_fir, Fs);

% Define start and stop samples for a 3-second playback
startZ = 1;
stopZ = playerObjFIRFilteredZ.SampleRate * 3;

% Play the filtered z signal for the first 3 seconds
play(playerObjFIRFilteredZ, [startZ, stopZ]);

%% Section 6: Compute and Print SNR of the Filtered Signals

% Compute SNR for the digital filter
% Original signal: z
% Filtered signal: filtered_z
SNR_digital = 10 * log10(mean(z.^2) / mean((filtered_z - z).^2));
fprintf('SNR of the digital filter (in dB): %.2f\n', SNR_digital);

% Compute SNR for the FIR filter
% Original signal: z
% Filtered signal: z_fir
SNR_FIR = 10 * log10(mean(z.^2) / mean((z_fir - z).^2));
fprintf('SNR of the FIR filter (in dB): %.2f\n', SNR_FIR);
