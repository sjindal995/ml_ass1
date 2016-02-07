function [mean_0,mean_1,covar,phi] = gda( file1, file2 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    x = importdata(file1);
    y = importdata(file2);
    [m,n] = size(x);
    x_0 = [];
    x_1 = [];
    y_0 = [];
    y_1 = [];
    %Alaska = 0 , Canada = 1
    for index0 = 1:m
        if(strcmp(y(index0), 'Alaska'))
            x_0 = [x_0; x(index0,:)];
            y_0 = [y_0; y(index0)];
        elseif(strcmp(y(index0),'Canada'))
            x_1 = [x_1; x(index0,:)];
            y_1 = [y_1; y(index0)];
        end
    end
    mean_0 = mean(x_0);
    mean_1 = mean(x_1);
    phi = size(y_1,1)/m;
    covar = zeros(n,n);
    for index1 = 1:m
        if(strcmp(y(index1),'Alaska'))
            covar = covar + (x(index1,:)-mean_0)'*(x(index1,:)-mean_0);
        elseif(strcmp(y(index1),'Canada'))
            covar = covar + (x(index1,:)-mean_1)'*(x(index1,:)-mean_1);
        end
    end
    covar = covar/m;
    plot(x_0(:,1),x_0(:,2),'ro',x_1(:,1),x_1(:,2),'k*');
    hold on;
    %log(k)=0 => b'x + c = 0
    b = (mean_1-mean_0)*2*(inv(covar));
    c = mean_0*inv(covar)*(mean_0') - mean_1*inv(covar)*mean_1' - 2*log((1-phi)/phi);
    xx = x(:,1);
    yy = -(b(1)*xx + c)/b(2);
    plot(xx,yy);
    xlabel('X1');
    ylabel('X2');
    legend('Alaska','Canada','decision boundary','Location','southeast');
    hold on;
end