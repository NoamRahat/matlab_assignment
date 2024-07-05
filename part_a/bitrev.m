function r = bitrev(k, bits)
    % Compute the bit-reversed value of an integer
    % Input:
    %   k - integer to be bit-reversed
    %   bits - number of bits in the binary representation
    % Output:
    %   r - bit-reversed value of k
    
    r = 0;
    for i = 0:bits-1
        r = bitor(bitshift(r, 1), bitand(bitshift(k, -i), 1));
    end

    return;  % Explicit return statement
end
