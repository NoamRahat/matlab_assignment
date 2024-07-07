# FFT and IFFT Implementation Project

## Contributors
- Sami Nechamd, Samy.nehmad1@gmail.com
- Noam Rahat, noamrht@gmail.com
- Zahi Tachan, zaktahan@gmail.com

## Instructions

### Part A: Implementation of FFT
In this part, we implemented two routines:
1. `iterativeFFT`: Iterative implementation of the FFT using the Cooley-Tukey algorithm.
2. `inverseFFT`: Implementation of the IFFT using the `iterativeFFT` routine.

The implementation details depend on the sum of the ID digits (d). If d is even, the implementation is non-recursive; if d is odd, the implementation is recursive.

#### MATLAB Code
- `bitrev.m`: Computes the bit-reversed value of an integer.
- `bitrevorder.m`: Reorders the input array according to bit-reversed order.
- `iterativeFFT.m`: Iterative FFT implementation.
- `inverseFFT.m`: IFFT implementation using the `iterativeFFT` function.
- `iterativeFFT_test.m`: Test script to validate the FFT and IFFT implementations.

### Part B: Digital Filtering
Given a signal `r(t) = cos(2π5t) + cos(2π10t)` and a digital filter from `filter_0.25_101.mat`, we:
1. Determined the appropriate sampling rate `Fs`.
2. Performed convolution to filter the signal.
3. Plotted the DFT of the filtered signal in the analog frequency domain [0, Fs].

#### MATLAB Code
- `linear_conv.m`: Function to perform linear convolution.
- `filter_and_plot.m`: Script to filter the signal and plot the DFT.

### Part C: OVA Method
Implemented the Overlap-Add (OVA) method for efficient linear convolution with the signal `x[n]` and filters `h1[n]`, `h2[n]`. Plotted the signal and its active frequencies, identified the types of filters, and compared the results of direct linear convolution with the OVA method.

#### MATLAB Code
- `sig_x_analysis.m`: Analysis of the signal `sig_x.mat`.
- `filter_types.m`: Identification of filter types from `filter_1.mat` and `filter_2.mat`.
- `ova_convolution.m`: Implementation of linear convolution using the OVA method.

## Requirements
- MATLAB

## Running the Project
1. Clone the repository.
2. Open MATLAB and navigate to the project directory.
3. Run the test scripts provided for each part to validate the implementations and view the results.

## Acknowledgements
Thanks to the course instructors for their guidance and support throughout this project.
