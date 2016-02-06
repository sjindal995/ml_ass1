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
    theta_vec = theta;
    while( true )
        error_val = zeros(n,1);
        for index = 1:m
            error_val = error_val + (y(index) - x(index,:)*theta).*(x(index,:))';
        end
        update = theta + (l_rate * error_val)/m;
        theta_vec = [theta_vec theta];
        
        if (abs(update-theta) <= epsilon)
            theta = update;
            break;
        end
        theta = update;
    end
    error_mat = [];
    iterations = size(theta_vec,2);
    for index1 = 1:51
        for index2 = 1:51
            theta1 = (index1-1)/5;
            theta2 = (index2-1)/5;
            error = 0;
            for index4 = 1:m
                error = error + ((y(index4) - x(index4,1)*theta1 - x(index4,2)*theta2)^2);
            end
            error = error/(2*m);
            %disp(error);
            error_mat(index1,index2) = error;
        end
    end
    x1 = [1 : 1 : 51];
    x2 = [1 : 1 : 51];
    plot(importdata(file1),x*theta,importdata(file1),importdata(file2),'.');
    %surf((x1-1)/5,(x2-1)/5,error_mat(x1,x2),'EdgeColor','none');
    %contour((x1-1)/5,(x2-1)/5,error_mat(x1,x2));
    hold on;
end

