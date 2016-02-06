function theta = weightLR( file1, file2, bw)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    x = importdata(file1);
    y = importdata(file2);
    [m,n] = size(x);
    x = [ones(m,n) x];
    n = n+1;
    %theta = zeros(n,1);
    w = zeros(m,m);
    for index = 1:m
        for index1 = 1:m
            w(index1,index1) = exp(-((x(index,2)-x(index1,2))^2)/(2*(bw^2)));
        end
        theta = (inv(x'*w*x))*x'*w*y;
        x1 = linspace(x(index,2),x(index,2)+0.4);
        x2 = [ones(100,1) x1'];
        y_est = x2*theta;
        plot(x1,y_est,importdata(file1),importdata(file2),'.');
        hold on;
    end
end

