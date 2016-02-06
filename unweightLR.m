function theta = unweightLR( file_1, file_2 )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    x = importdata(file_1);
    y = importdata(file_2);
    [m,n] = size(x);
    x = [ones(m,n) x];
    n = n+1;
    theta = inv(x'*x)*x'*y;
    %plot(x(:,2),x*theta,x(:,2),y,'.');
    plot(importdata(file_1),x*theta,importdata(file_1),importdata(file_2),'.');
    hold on;
end

