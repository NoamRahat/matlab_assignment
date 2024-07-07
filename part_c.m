close all;
clear;
clc;

%% Q1:
%% What does the signal "sig_x.mat" look like? What are the active frequencies?

% Load the signal from the .mat file and define initial parameters
load('sig_x.mat');  % Loads the variable 'x'
fs = 18000;  % Sampling rate in Hz
N = length(x);  % Length of the signal

% Define the time vector for the entire signal and for the zoomed portion
n = 0:N-1;  % Time vector for the entire signal
zoomRange = 1:min(N, 300);  % Zoomed range

% Plot the zoomed portion of the signal in the time domain
figure;
plot(n(zoomRange), x(zoomRange));
title('Zoomed Portion of Signal in Time Domain');
xlabel('n (samples)');
ylabel('x[n]');
grid on;

% Compute the FFT of the signal and define the frequency axis
X = fft(x);
f = (-N/2:N/2-1) * (fs / N);  % Frequency axis centered around 0

% Compute and plot the magnitude spectrum centered around 0
magnitude = abs(fftshift(X));
figure;
plot(f, magnitude);
title('Magnitude Spectrum of the Signal (Centered)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

% Detect active frequencies using a threshold
threshold = max(magnitude) * 0.1;
active_indices = find(magnitude > threshold);
active_frequencies = f(active_indices);

disp(active_frequencies);

fprintf('Mathematical representation of the signal:\n');
phases = angle(fftshift(X));  % Assign to a variable first
for i = 1:length(active_frequencies)
    fprintf('A%d * cos(2 * pi * %.0f * n / %.0f + %.2f)\n', i, abs(active_frequencies(i)), fs, phases(active_indices(i)));
end

%% Q2:
%% What are the types of filters filter_1.mat and filter_2.mat?

filter_1 = load('filter_1.mat');
filter_2 = load('filter_2.mat');
filter_1_varname = fieldnames(filter_1);
filter_2_varname = fieldnames(filter_2);
h1 = filter_1.(filter_1_varname{1}); % Access the first variable in filter_1.mat
h2 = filter_2.(filter_2_varname{1}); % Access the first variable in filter_2.mat

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

%% Q3:
%% Implement a Directly Linear Convolution between the signal x[n] and each of the filters.
%% Compare the results and explain them. What is the running time?
% Compute linear convolution with each filter and count operations
tic;
[y1_linear, mult1, add1] = linear_conv(x, h1);
time_y1_linear = toc;

tic;
[y2_linear, mult2, add2] = linear_conv(x, h2);
time_y2_linear = toc;

% Display results
fprintf('Linear convolution with Filter 1 (LPF) took %.6f seconds.\n', time_y1_linear);
fprintf('Number of multiplications with Filter 1: %d\n', mult1);
fprintf('Number of additions with Filter 1: %d\n', add1);

fprintf('Linear convolution with Filter 2 (HPF) took %.6f seconds.\n', time_y2_linear);
fprintf('Number of multiplications with Filter 2: %d\n', mult2);
fprintf('Number of additions with Filter 2: %d\n', add2);

% Plot the results of linear convolution
figure;
subplot(2,1,1);
plot(y1_linear(1200:1500));
title('Linear Convolution with Filter 1 (Zoomed In)');
xlabel('Sample');
ylabel('Amplitude');

subplot(2,1,2);
plot(y2_linear(1200:1500));
title('Linear Convolution with Filter 2 (Zoomed In)');
xlabel('Sample');
ylabel('Amplitude');

%% Q4:
%% Implament linear convolution by OVA.
%% Explain how you determined the parameters of the algorithm.
%% What is the optimal running time? Show this in a graph as a function of frame size.
%% Explain in detail how the method works.

% Define the segment length (L)
L = 1024;  % Adjust the segment length as needed
tic;
% Perform the convolution using the overlap_and_add function
[y1, num_mult, num_add] = overlap_and_add(x, h1, L);
time = toc;

fprintf('Linear convolution with Filter 1 (BPF) took %.6f seconds.\n', time);
fprintf('Number of multiplications with Filter 1: %d\n', num_mult);
fprintf('Number of additions with Filter 1: %d\n', num_add);

tic;
% Perform the convolution using the overlap_and_add function
[y2, num_mult, num_add] = overlap_and_add(x, h2, L);
time = toc;

fprintf('Linear convolution with Filter 2 (BPF) took %.6f seconds.\n', time);
fprintf('Number of multiplications with Filter 2: %d\n', num_mult);
fprintf('Number of additions with Filter 2: %d\n', num_add);
% Plot the result in the time domain (zoomed in to improve visibility)
figure;
n = 0:length(y1)-1;  % Time vector

% Define the zoom range (adjust as needed)
zoom_start = 200;
zoom_end = 500; % Plot first 5000 samples for better visibility

subplot(2,1,1);
plot(n(zoom_start:zoom_end), y1(zoom_start:zoom_end));
title('Zoomed Result of Convolution using Overlap and Add - filter1');
xlabel('n (samples)');
ylabel('y1[n]');

subplot(2,1,2);
plot(n(zoom_start:zoom_end), y2(zoom_start:zoom_end));
title('Zoomed Result of Convolution using Overlap and Add - filter2');
xlabel('n (samples)');
ylabel('y2[n]');

%% Q5:
%% Compare the running times of the two methods on the same graph as a function of frame size. Which method has better in terms of performance?
%% Draw on the same graph the output of the 2 types of convolution for each of the filters and show that you performed OVA correctly.
% Linear Convolution using the provided linear_conv function
[y1_linear, unus1, unus2] = linear_conv(x, h1);
[y2_linear, unus1, unus2] = linear_conv(x, h2);

% Overlap-Add Convolution using the provided overlap_and_add function
L = 2048; % Block size
[y1_ova, unus1, unus2] = overlap_and_add(x, h1, L);
[y2_ova, unus1, unus2] = overlap_and_add(x, h2, L);

% Plotting the results

% Zoomed plot for better visibility
zoom_start = 1;
zoom_end = 500; % Adjust as needed

figure;
subplot(2,1,1);
hold on;
plot(zoom_start:zoom_end, y1_linear(zoom_start:zoom_end), 'r', 'DisplayName', 'Linear Convolution', 'LineWidth', 1.5);
plot(zoom_start:zoom_end, y1_ova(zoom_start:zoom_end), 'b--', 'DisplayName', 'OVA Convolution', 'LineWidth', 1.5);
title('Filter 1 (Zoomed)');
legend('show');
xlabel('n (samples)');
ylabel('y[n]');
grid on;
hold off;

subplot(2,1,2);
hold on;
plot(zoom_start:zoom_end, y2_linear(zoom_start:zoom_end), 'r', 'DisplayName', 'Linear Convolution', 'LineWidth', 1.5);
plot(zoom_start:zoom_end, y2_ova(zoom_start:zoom_end), 'b--', 'DisplayName', 'OVA Convolution', 'LineWidth', 1.5);
title('Filter 2 (Zoomed)');
legend('show');
xlabel('n (samples)');
ylabel('y[n]');
grid on;
hold off;
