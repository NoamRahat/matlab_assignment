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

h = filter_2.(filter_2_varname{1}); % Access the first variable in filter_2.mat

% Check if the variables 'x' and 'h' exist in the workspace
if exist('x', 'var') && exist('h', 'var')
    % Define the segment length (L)
    L = 1024;  % Adjust the segment length as needed

    tic;
    % Perform the convolution using the overlap_and_add function
    [y, num_mult, num_add] = overlap_and_add(x, h, L);
    time = toc;

    fprintf('Linear convolution with Filter 2 (BPF) took %.6f seconds.\n', time);
    fprintf('Number of multiplications with Filter 2: %d\n', num_mult);
    fprintf('Number of additions with Filter 2: %d\n', num_add);

    % Plot the result in the time domain (zoomed in to improve visibility)
    figure;
    n = 0:length(y)-1;  % Time vector
    
    % Define the zoom range (adjust as needed)
    zoom_start = 1;
    zoom_end = 500; % Plot first 5000 samples for better visibility
    
    plot(n(zoom_start:zoom_end), y(zoom_start:zoom_end));
    title('Zoomed Result of Convolution using Overlap and Add - filter2');
    xlabel('n (samples)');
    ylabel('y[n]');
    grid on;


    % Define the number of points for the FFT (e.g., 1024)
    N = 1024;

    % Compute and plot the DTFT
    dtft_plot(y, N);

else
    disp('The variable x or h is not found in the loaded .mat file.');
end

