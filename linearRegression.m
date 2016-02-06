function theta = linearRegression( file1, file2, l_rate, epsilon )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    x = importdata(file1);
    y = importdata(file2);
    [m,n] = size(x);
    x = (x - mean(x))./sqrt(var(x));
    x = [ones(m,n) x];
    n = n+1;
    theta = zeros(n,1);
    while( true )
        error_val = zeros(n,1);
        for index = 1:m
            error_val = error_val + (y(index) - x(index,:)*theta).*(x(index,:))';
        end
        update = theta + (l_rate * error_val)/m;
        if (abs(update-theta) <= epsilon)
            theta = update;
            break;
        end
        theta = update;
    end
    plot(importdata(file1),x*theta,importdata(file1),importdata(file2),'.');
end

