function [y, num_mult, num_add] = overlap_and_add(x, h, L)
    % x: Input signal
    % h: Impulse response of the FIR filter
    % L: Segment length

    M = length(h);           % Length of the filter
    N = L + M - 1;           % Length of the convolved segments
    num_segments = ceil(length(x) / L);
    
    % Initialize the output signal
    y = zeros(1, L * num_segments + M - 1);
    num_mult = 0;
    num_add = 0;

    for k = 0:num_segments-1
        % Extract the k-th segment of x
        x_segment = x(k*L + 1 : min((k+1)*L, length(x)));
        
        % Convolve the segment with the impulse response h
        [y_segment, mult, add] = linear_conv(x_segment, h);

        num_mult = num_mult + mult;
        num_add = num_add + add;

        %fprintf('Number of multiplications : %d\n', num_mult);
        %fprintf('Number of additions: %d\n', num_add);

        % Add the convolved segment to the correct position in the output signal
        y_start = k*L + 1;
        y_end = y_start + length(y_segment) - 1;
        
        y(y_start:y_end) = y(y_start:y_end) + y_segment;
    end
end
