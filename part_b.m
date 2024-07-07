close all;
clc;
clear;

% Load the filter
data = load('filter_0.25_101.mat'); % This loads a struct with field names matching the variables in the .mat file

% Correctly access the filter coefficients using the actual field name 'h'
h = data.h; % Use struct field access to get the correct filter variable
Fs=50;                    
t=(0:1946)/Fs;% in order to creat a 1947 lenght vector

% c/d transform-will mention that we allready included the /Fs in the                    
% t vector
r_n=cos(2*pi*5*t)+cos(2*pi*10*t);

bpf_length=length(h);   

s_n=linear_conv(r_n,h);% linear convelution-will result a 2048 output lenght signal

S_k=abs(fft(s_n));%s[k] is the dft of s[n]-finding its abs:

f=(0:2047)*(Fs/2048);% Frequency,after resolutiong like Fs/N
plot(f,S_k);
xlabel('k(=frequency) (Hz)');
ylabel('|s[k]|');
title('|s[k]| as a function of frequency');
grid on;
