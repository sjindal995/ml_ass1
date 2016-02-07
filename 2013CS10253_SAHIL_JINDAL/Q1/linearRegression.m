function [theta, iterations] = linearRegression( file1, file2, l_rate, epsilon )
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
    j_theta_vec = [];
    while( true )
        error_val = zeros(n,1);
        j_theta = 0;
        for index = 1:m
            error_val = error_val + (y(index) - x(index,:)*theta).*(x(index,:))';
            j_theta = j_theta + ((y(index) - x(index,:)*theta)^2);
        end
        j_theta = j_theta/(2*m);
        if(size(j_theta_vec,1) > 0)
            delta = abs(j_theta - j_theta_vec(end));
        else
            delta = realmax;
        end
        j_theta_vec = [j_theta_vec j_theta];
        theta = theta + (l_rate * error_val)/m;
        theta_vec = [theta_vec theta];
        fprintf('theta(1): %f , theta_2: %f\n',theta(1),theta(2));
        if (delta <= epsilon)
            break;
        end
    end
    j_theta=0;
    for index = 1:m
        j_theta = j_theta + ((y(index) - x(index,:)*theta)^2);
    end
    j_theta = j_theta/(2*m);
    j_theta_vec = [j_theta_vec j_theta];
    error_mat = [];
    iterations = size(theta_vec,2);
    x1 = linspace(theta(1)-5,theta(1)+5);
    x2 = linspace(theta(2)-5,theta(2)+5);
    minimum = realmax;
    for index1 = 1:size(x1,2)
        for index2 = 1:size(x2,2)
            theta1 = x1(index1);
            theta2 = x2(index2);
            error = 0;
            for index4 = 1:m
                error = error + ((y(index4) - x(index4,1)*theta1 - x(index4,2)*theta2)^2);
            end
            error = error/(2*m);
            if(error < minimum)
                disp('minimum:');
                disp(error);
                fprintf('index1,index2: %d,%d\n',index1,index2);
                minimum = error;
            end
            %disp(error);
            error_mat(index1,index2) = error;
        end
    end
    figure(1);
    plot(importdata(file1),x*theta,importdata(file1),importdata(file2),'r.');
    xlabel('X');
    ylabel('Y');
    hold on;
    figure(2);
    %surf(x1,x2,error_mat,'EdgeColor','none');
    %mesh(x1,x2,error_mat);
    contour(x1,x2,error_mat);
    hold on;
    for index = 1:size(theta_vec,2)
        figure(2);
        plot3(theta_vec(1,1:index),theta_vec(2,1:index),j_theta_vec(1:index));
        hold on;
        plot3(theta_vec(1,index),theta_vec(2,index),j_theta_vec(index),'r*');
        hold on;
        pause(0.2);
    end
    xlabel('theta1');
    ylabel('theta2');
    zlabel('error');
    hold on;
end

