%% run the following in the MATLAB command window:
% results = runtests('TestMyDTFT');
% disp(results);

classdef TestMyDTFT < matlab.unittest.TestCase
    methods (Test)
        function testEvenNw(testCase)
            x = [1, 2, 3, 4];
            n = [0, 1, 2, 3];
            Nw = 4;
            [X, omega] = my_DTFT(x, n, Nw);
            
            % Manually calculate the expected results
            kw = linspace(-Nw/2+1, Nw/2, Nw);
            expected_omega = 2 * pi * kw / Nw;
            expected_X = x * exp(-1j * (n' * expected_omega));
            
            testCase.verifyEqual(X, expected_X, 'AbsTol', 1e-5);
            testCase.verifyEqual(omega, expected_omega, 'AbsTol', 1e-5);
        end
        
        function testOddNw(testCase)
            x = [1, 2, 3, 4];
            n = [0, 1, 2, 3];
            Nw = 5;
            [X, omega] = my_DTFT(x, n, Nw);
            
            % Manually calculate the expected results
            kw = linspace(-(Nw-1)/2, (Nw-1)/2, Nw);
            expected_omega = 2 * pi * kw / Nw;
            expected_X = x * exp(-1j * (n' * expected_omega));
            
            testCase.verifyEqual(X, expected_X, 'AbsTol', 1e-5);
            testCase.verifyEqual(omega, expected_omega, 'AbsTol', 1e-5);
        end
    end
end
