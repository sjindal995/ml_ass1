function [ mean_0,mean_1,covar_0,covar_1,phi ] = nlGda( file1, file2)
%UNTITLED4 Summary of this function goes here
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
    covar_0 = zeros(n,n);
    covar_1 = zeros(n,n);
    for index2 = 1:m
        if(strcmp(y(index2),'Alaska'))
            covar_0 = covar_0 + (x(index2,:)-mean_0)'*(x(index2,:)-mean_0);
        elseif(strcmp(y(index2),'Canada'))
            covar_1 = covar_1 + (x(index2,:)-mean_1)'*(x(index2,:)-mean_1);
        end
    end
    covar_0 = covar_0/size(x_0,1);
    covar_1 = covar_1/size(x_1,1);
    plot(x_0(:,1),x_0(:,2),'ro',x_1(:,1),x_1(:,2),'k*');
    hold on;
    %[x y][a b][x] - 2*[e f]*[x] + cons = 2*log((1-phi)/phi)
    %     [c d][y]           [y]
    
    % a*x^2 + cxy + bxy + dy^2 - 2*ex - 2*fy + cons = 0;
    
    di = inv(covar_0) - inv(covar_1);
    a = di(1,1);
    b = di(1,2);
    c = di(2,1);
    d = di(2,2);
    di2 = mean_0/covar_0 - mean_1/covar_1;
    e = di2(1,1);
    f = di2(1,2);
    cons = (mean_0/covar_0)*mean_0' - (mean_1/covar_1)*mean_1' - 2*log((1-phi)*sqrt(det(covar_1))/(phi*sqrt(det(covar_0))));
    xx = x(:,1);
    %fh = @(xx,yy) (a*(xx.^2) + (b+c)*xx.*yy + d*(yy.^2) -2*e*xx - 2*f*yy + cons);
    %ezplot(fh);
    ezplot(sprintf('%f*(xx.^2) + (%f+%f)*xx.*yy + %f*(yy.^2) - 2*%f*xx - 2*%f*yy + %f',a,b,c,d,e,f,cons),[min(x(:,1))-10,max(x(:,1))+10,min(x(:,2))-100,max(x(:,2))+100]);
    xlabel('x1');
    ylabel('x2');
    legend('Alaska','Canada','decision boundary','Location','southeast');
    hold on;
end

