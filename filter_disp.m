close all;
clear;
clc;
% Load the signal and filters
sig_x = load('sig_x.mat');
filter_1 = load('filter_1.mat');
filter_2 = load('filter_2.mat');

x = sig_x.x; % Assuming the variable in sig_x.mat is named 'x'
filter_1_varname = fieldnames(filter_1);
filter_2_varname = fieldnames(filter_2);

h1 = filter_1.(filter_1_varname{1}); % Access the first variable in filter_1.mat
h2 = filter_2.(filter_2_varname{1}); % Access the first variable in filter_2.mat

% Plot the impulse response of each filter
figure;
subplot(2,1,1);
stem(h1);
title('Impulse Response of Filter 1 (BSF)');
xlabel('Sample');
ylabel('Amplitude');

subplot(2,1,2);
stem(h2);
title('Impulse Response of Filter 2 (BPF)');
xlabel('Sample');
ylabel('Amplitude');

% Compute and plot the frequency response of each filter
h1_fft = fft(h1);
h2_fft = fft(h2);
freq = (0:length(h1_fft)-1) * (18000 / length(h1_fft));

figure;
subplot(2,1,1);
plot(freq, abs(h1_fft));
title('Frequency Response of Filter 1');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(2,1,2);
plot(freq, abs(h2_fft));
title('Frequency Response of Filter 2');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Reduce the sampling rate by downsampling
downsample_rate = 1; % Adjust as needed
x_downsampled = downsample( x , downsample_rate );

% Compute linear convolution with each filter and count operations
tic;
[y1_linear, mult1, add1] = linear_conv(x, h1);
time_y1_linear = toc;

tic;
[y2_linear, mult2, add2] = linear_conv(x, h2);
time_y2_linear = toc;

% Display results
fprintf('Linear convolution with Filter 1 (BSF) took %.6f seconds.\n', time_y1_linear);
fprintf('Number of multiplications with Filter 1: %d\n', mult1);
fprintf('Number of additions with Filter 1: %d\n', add1);

fprintf('Linear convolution with Filter 2 (BPF) took %.6f seconds.\n', time_y2_linear);
fprintf('Number of multiplications with Filter 2: %d\n', mult2);
fprintf('Number of additions with Filter 2: %d\n', add2);

% Plot the results of linear convolution
figure;
subplot(2,1,1);
plot(y1_linear);
title('Linear Convolution with Filter 1 (BSF)');
xlabel('Sample');
ylabel('Amplitude');

subplot(2,1,2);
plot(y2_linear);
title('Linear Convolution with Filter 2 (BPF)');
xlabel('Sample');
ylabel('Amplitude');

% Optional: Plot a zoomed-in portion of the convolved signals
figure;
subplot(2,1,1);
plot(y1_linear(1000:2000));
title('Linear Convolution with Filter 1 (Zoomed In)');
xlabel('Sample');
ylabel('Amplitude');

subplot(2,1,2);
plot(y2_linear(1000:2000));
title('Linear Convolution with Filter 2 (Zoomed In)');
xlabel('Sample');
ylabel('Amplitude');

% Compute and plot the Fourier Transform of the convolved signals
y1_fft = fft(y1_linear);
y2_fft = fft(y2_linear);

f = (0:length(y1_fft)-1) * (18000 / length(y1_fft) / downsample_rate);

figure;
subplot(2,1,1);
plot(f, abs(y1_fft));
title('Frequency Spectrum of Convolved Signal with Filter 1');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
subplot(2,1,2);
plot(f, abs(y2_fft));
title('Frequency Spectrum of Convolved Signal with Filter 2');
xlabel('Frequency (Hz)');
ylabel('Magnitude');