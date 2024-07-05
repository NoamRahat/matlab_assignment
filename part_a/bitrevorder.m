function x = bitrevorder(x)
    % Reorder the input array according to bit-reversed order
    % Input:
    %   x - input signal (vector of complex numbers)
    % Output:
    %   x - bit-reversed ordered signal
    
    N = length(x);
    bits = log2(N);
    for i = 0:N-1
        rev_i = bitrev(i, bits);
        if rev_i > i
            % Swap elements to achieve bit-reversed order
            temp = x(i+1);
            x(i+1) = x(rev_i+1);
            x(rev_i+1) = temp;
        end
    end

    return;  % Explicit return statement
end
