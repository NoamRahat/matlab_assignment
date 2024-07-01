
% Load the signal from the .mat file
load('sig_x.mat');  % This loads the variable 'x' from 'sig_x.mat'

% Define the number of points for the FFT (e.g., 1024)
N = 1024;

% Compute and plot the DTFT
dtft_plot(x, N);

