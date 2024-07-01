
% Load the signal from the .mat file
load('sig_x.mat');  % This loads the variable 'x' from 'sig_x.mat'


% Check if the variable 'x' exists in the workspace
if exist('x', 'var')
    % Define the time vector
    n = 0:length(x)-1;  % Assuming the signal starts at n=0


    % Plot a specific portion of the signal (zoomed in)
    start_index = 1;  % Starting index for zooming in
    end_index = min(length(x), 1000);  % Ending index for zooming in (adjust as needed)
    x_zoomed = x(start_index:end_index);
    n_zoomed = start_index:end_index;

    % Plot the zoomed portion of the signal in the time domain
    figure;
    plot(n_zoomed, x_zoomed);
    title('Zoomed Portion of Signal in Time Domain');
    xlabel('n (samples)');
    ylabel('x[n]');
    grid on;

    
%     % Plot the signal in the time domain (original plot)
%     figure;
%     stem(n, x, 'filled');
%     title('Signal in Time Domain original');
%     xlabel('n (samples)');
%     ylabel('x[n]');
%     grid on;

        
%     % Downsample the signal if it's too long
%     factor = 100;  % Adjust the downsampling factor as needed
%     x_downsampled = x(1:factor:end);
%     n_downsampled = 0:factor:length(x_downsampled)*factor-1;
% 
%     % Plot the downsampled signal in the time domain
%     figure;
%     plot(n_downsampled, x_downsampled);
%     title('Downsampled Signal in Time Domain');
%     xlabel('n (samples)');
%     ylabel('x[n]');
%     grid on;
else
    disp('The variable x is not found in the loaded .mat file.');
end

% % Check if the variable 'x' exists in the workspace
% if exist('x', 'var')
%     % Define the sampling rate (e.g., 44100 Hz for CD-quality audio)
%     fs = 44100;
% 
%     % Play the signal using sound (ensure that 'x' is a row vector)
%     sound(x, fs);
% end


% Define the number of points for the FFT (e.g., 1024)
N = 1024;

% Compute and plot the DTFT
dtft_plot(x, N);

