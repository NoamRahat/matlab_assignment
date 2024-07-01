function y = overlap_and_add(x, h, L)
    % x: Input signal
    % h: Impulse response of the FIR filter
    % L: Segment length

    M = length(h);           % Length of the filter
    N = L + M - 1;           % Length of the convolved segments
    num_segments = ceil(length(x) / L);
    
    % Initialize the output signal
    y = zeros(1, L * num_segments + M - 1);

    for k = 0:num_segments-1
        % Extract the k-th segment of x
        x_segment = x(k*L + 1 : min((k+1)*L, length(x)));
        
        % Convolve the segment with the impulse response h
        y_segment = conv(x_segment, h);
        
        % Add the convolved segment to the correct position in the output signal
        y(k*L + 1 : k*L + N) = y(k*L + 1 : k*L + N) + y_segment;
    end
end