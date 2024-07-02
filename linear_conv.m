% Define the linear convolution function
function y = linear_conv(x, h)
    Nx = length(x);
    Nh = length(h);
    Ny = Nx + Nh - 1;
    y = zeros(1, Ny);
    
    % Perform convolution
    for i = 1:Nx
        for j = 1:Nh
            y(i + j - 1) = y(i + j - 1) + x(i) * h(j);
        end
    end
end