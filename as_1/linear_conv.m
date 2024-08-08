% Function to perform linear convolution
function [y, num_mult, num_add] = linear_conv(x, h)
    % Linear convolution implementation
    Nx = length(x);
    Nh = length(h);
    Ny = Nx + Nh - 1;
    y = zeros(1, Ny);

    num_mult = 0;
    num_add = 0;

    % Perform convolution
    for i = 1:Nx
        for j = 1:Nh
            y(i + j - 1) = y(i + j - 1) + x(i) * h(j);
            num_mult = num_mult + 1;  % Count multiplications
            if j > 1
                num_add = num_add + 1;  % Count additions (excluding first in each row)
            end
        end
        %fprintf('Number of multiplications : %d\n', num_mult);

    end
end