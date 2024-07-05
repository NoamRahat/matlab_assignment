function [X,omega] = my_FFT(x,n, Nw)
    if mod(Nw,2)==0
        kw = linspace(-Nw/2+1,Nw/2,Nw);
    else
        kw = linspace(-(Nw-1)/2,(Nw-1)/2,Nw);
    end
    omega = 2*pi*(kw)/Nw;
    
    
    if size(n,1) == 1
        n = transpose(n);
    end
    if size(x,2) == 1
        x = transpose(x);
    end
    
    %Fourier transform
    matrix = exp(-1j*(n*omega));
    X = x*matrix;
end
