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
