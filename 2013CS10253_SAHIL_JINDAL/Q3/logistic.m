function theta = logistic( file1, file2, epsilon )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    x = importdata(file1);
    y = importdata(file2);
    [m,n] = size(x);
    x = [ones(m,1) x];
    n = n+1;
    theta = zeros(n,1);
    sig = zeros(m,1);
    ll_prev=realmax;
    ll_cur=0;
    while(true)
        for index = 1:m
            sig(index) = 1/(1+exp(-1*x(index,:)*theta));
        end
        hessian = zeros(n,n);
        for row_index = 1:n
            for col_index = 1:n
                val = 0;
                for index1 = 1:m
                    g = sig(index1);
                    val = val + (g * (1-g) * x(index1,row_index) * x(index1,col_index));
                end
                val = -val;
                hessian(row_index,col_index) = val;
            end
        end
        val1 = zeros(n,1);
        ll_cur=0;
        for index2 = 1:m
            val1 = val1 + (y(index2) - sig(index2))*x(index2,:)';
            ll_cur = ll_cur + (y(index2)*log(sig(index2)) + (1 - y(index2))*log(1-sig(index2)));
        end
        theta = theta - (hessian\val1);
        if(abs(ll_cur-ll_prev) <= epsilon)
            break;
        end
        ll_prev = ll_cur;
    end
    %ezplot(sprintf('%f*x1 + %f*x2 + %f = 0',theta(3),theta(2),theta(1)));
    %hold on;
    x1_0 = [];
    x1_1 = [];
    for index3 = 1:m
        if(y(index3) == 0)
            x1_0 = [x1_0; x(index3,:)];
        elseif(y(index3) == 1)
            x1_1 = [x1_1; x(index3,:)];
        end
    end
    disp(x1_0);
    disp(x1_1);
    plot(x1_0(:,2),x1_0(:,3),'ro');
    hold on;
    plot(x1_1(:,2),x1_1(:,3),'b*');
    hold on;
    
    %theta(1)*x(1) + theta(2)*x(2) + theta(3)*x(3) = 0;
    xx = x(:,2);
    yy = -(theta(1) + theta(2)*xx)/theta(3);
    plot(xx,yy);
    legend('y = 0','y = 1','decision boundary','Location','southeast')  % correct
    hold on;
end

