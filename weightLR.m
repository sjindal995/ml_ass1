function theta = weightLR( file1, file2, bw)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    x = importdata(file1);
    y = importdata(file2);
    [m,n] = size(x);
    x = [ones(m,n) x];
    n = n+1;
    theta = zeros(n,1);
    w = zeros(m,m);
    y_est = zeros(m,1);
    for index = 1:m
        for index1 = 1:m
            w(index1,index1) = exp(-((x(index,2)-x(index1,2))^2)/(2*(bw^2)));
        end
        theta = (inv(x'*w*x))*x'*w*y;
        y_est(index) = x(index,:)*theta;
    end
    xy = [x(:,2) y_est];
    xy = sortrows(xy);
    plot(xy(:,1),xy(:,2),x(:,2),y,'.');
end

