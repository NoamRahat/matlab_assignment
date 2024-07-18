clc;
close all;
clear all;

% Step 1: Load the data from the file 'sig_2.mat'
load('sig_2.mat', 'Fs', 'z', 'y'); % Load sampling frequency, z, and y

% Step 2: Define filter specifications
A_p = 5; % Passband attenuation in dB
A_s = 20; % Stopband attenuation in dB
Omega_p = 3600 * 2 * pi; % Passband frequency in rad/sec
Omega_s = 3800 * 2 * pi; % Stopband frequency in rad/sec

% Pre-warped frequencies
F_p = Omega_p / (2 * pi);
F_s = Omega_s / (2 * pi);

% Pre-warp the frequencies
omega_p = 2 * Fs * tan(Omega_p / (2 * Fs));
omega_s = 2 * Fs * tan(Omega_s / (2 * Fs));

% Step 3: Calculate the order of the Butterworth filter
[n, Wn] = buttord(omega_p, omega_s, A_p, A_s, 's'); % Wn is the normalized cutoff frequency

% Step 4: Design the analog Butterworth filter
[b, a] = butter(n, Wn, 's'); % Wn is the normalized cutoff frequency

% Step 5: Convert to digital filter using bilinear transformation
[bz, az] = bilinear(b, a, Fs);

% Step 6: Plot the magnitude response of the digital filter
figure;
freqz(bz, az, 1024, Fs);
title('Magnitude Response of Digital Filter H(e^{j\omega})');

% Step 7: Apply the digital filter to the signal z
z_filtered = filter(bz, az, z);

% Step 8: Play the filtered signal
playerObjZ_filtered = audioplayer(z_filtered, Fs);
startZ = 1;
stopZ = playerObjZ_filtered.SampleRate * 3;
play(playerObjZ_filtered, [startZ, stopZ]);

% Plot the original and filtered signals
figure;
subplot(2, 1, 1);
plot(z);
title('Original Signal z(t)');
xlabel('Sample');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(z_filtered);
title('Filtered Signal z_{filtered}(t)');
xlabel('Sample');
ylabel('Amplitude');
