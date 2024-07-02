close;
clear;
clc;
% Load the signals from the .mat files
load('sig_x.mat');     % This loads the variable 'x' from 'sig_x.mat'
load('filter_1.mat');  % This loads the variable 'h' from 'filter_1.mat'

% Check if the variables 'x' and 'h' exist in the workspace
if exist('x', 'var') && exist('h', 'var')
    % Define the segment length (L)
    L = 1024;  % Adjust the segment length as needed

    % Perform the convolution using the overlap_and_add function
    y = overlap_and_add(x, h, L);

    % Print the result
%     disp('The result of the convolution is:');
%     disp(y);

    % Plot the result in the time domain (zoomed in to improve visibility)
    figure;
    n = 0:length(y)-1;  % Time vector
    
    % Define the zoom range (adjust as needed)
    zoom_start = 1;
    zoom_end = 1000; % Plot first 5000 samples for better visibility
    
    plot(n(zoom_start:zoom_end), y(zoom_start:zoom_end));
    title('Zoomed Result of Convolution using Overlap and Add - filter1');
    xlabel('n (samples)');
    ylabel('y[n]');
    grid on;
else
    disp('The variable x or h is not found in the loaded .mat file.');
end


% Define the number of points for the FFT (e.g., 1024)
N = 1024;

% Compute and plot the DTFT
dtft_plot(y, N);
