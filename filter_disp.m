% Load the filters
filter_1 = load('filter_1.mat');
filter_2 = load('filter_2.mat');

% Assuming the filters are stored in variables with different names
filter_1_varname = fieldnames(filter_1);
filter_2_varname = fieldnames(filter_2);

h1 = filter_1.(filter_1_varname{1}); % Access the first variable in filter_1.mat
h2 = filter_2.(filter_2_varname{1}); % Access the first variable in filter_2.mat

% Plot the impulse response of each filter
figure;
subplot(2,1,1);
stem(h1);
title('Impulse Response of Filter 1');
xlabel('Sample');
ylabel('Amplitude');

subplot(2,1,2);
stem(h2);
title('Impulse Response of Filter 2');
xlabel('Sample');
ylabel('Amplitude');

% Compute and plot the frequency response of each filter
figure;
subplot(2,1,1);
freqz(h1, 1, 1024, 18000);
title('Frequency Response of Filter 1');

subplot(2,1,2);
freqz(h2, 1, 1024, 18000);
title('Frequency Response of Filter 2');
