% Write a function to calculate the RMS amplitude of an array of values

list = [1, 2, 3, 4, 5];

disp("Calculated via loop: " + calculateLoop(list));
disp("Calculated via vectors: " + calculateVectorised(list));

% ===============================================
% MATLAB functions must be at the end of the file
% ===============================================

% Calculated via loop (slow & innefficient in MATLAB)
function rmsVal = calculateLoop(x)
    len = length(x);                % calculate length of list
    sumSq = 0;                      % define variable outside of loop
    for n = 1:len                   % iterate for list length
        sumSq = sumSq + x(n)^2;
    end
    rmsVal = sqrt(sumSq / len);     % return value
end

% Calculated via vectors (optimised for MATLAB)
function rmsVal = calculateVectorised(x)
    rmsVal = sqrt(sum(x.^2) / length(x));
end