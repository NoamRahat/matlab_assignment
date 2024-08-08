close;
clear;
clc;
% Define the input signal, impulse response, and segment length
x = [1, 2, 3, 4, 5, 6, 7, 8];
h = [1, -1];
L = 4;

% Call the overlap_and_add function
y_ova = overlap_and_add(x, h, L);

% Use MATLAB's built-in linear convolution for comparison
y_conv = conv(x, h);

% Display the results
disp('The output signal using overlap_and_add is:');
disp(y_ova);

disp('The output signal using built-in conv function is:');
disp(y_conv);

% Plot the results for visual comparison
figure;
subplot(2,1,1);
stem(y_ova, 'filled');
title('Output using overlap_and_add');
xlabel('n');
ylabel('y[n]');

subplot(2,1,2);
stem(y_conv, 'filled');
title('Output using built-in conv function');
xlabel('n');
ylabel('y[n]');
