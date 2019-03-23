clc;clear;
x=[0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65...
    0.7 0.75 0.8 0.85 0.9 0.95 1.0];
y=[0 2 4 4.5 5 9.5 14 14.5 15 14 14.5 14 14 13 12.5 12 10 7.5 5 4.5 4];
plot(x,y,'ob','markersize',10);
len_x=length(x);max_x=max(x);min_x=min(x);
num=100;
delta=(max_x-min_x)/num;
x_f1 =[]; x_f2=[];x_f3=[];
f1 =[]; f2=[]; f3=[];
max_delta = (max_x-min_x)*7/10; %默认影响区域的范围是0.3
for i=0:num 
    x_val = min_x + i*delta; 
    x_f1 = [x_f1,x_val]; x_f2 = [x_f2,x_val]; x_f3=[x_f3,x_val];
    A1 = zeros(2,2); A2=zeros(3,3); A3=zeros(4,4);
    B1 = []; B2=[]; B3=[];
    for j=1:len_x 
        s = abs(x(j)-x_val)/max_delta; 
        if s<=0.5 
            w = 2/3-4*s^2+4*s^3; 
        elseif s<=1 
            w = 4/3-4*s+4*s^2-4*s^3/3; 
        else 
            w = 0; 
        end 
        A1 = A1 + w*[1;x(j)]*[1,x(j)]; 
        A2 = A2 + w*[1;x(j);(x(j))^2]*[1,x(j),(x(j))^2];
        A3 = A3 + w*[1;x(j);(x(j))^2;exp(x(j))]*[1,x(j),(x(j))^2,exp(x(j))];
        B1 = [B1,w*[1;x(j)]]; 
        B2 = [B2,w*[1;x(j);(x(j))^2]];
        B3 = [B3,w*[1;x(j);(x(j))^2;exp(x(j))]];
    end 
    f1 = [f1,[1,x_val]*pinv(A1)*B1*y']; 
    f2 = [f2,[1,x_val,x_val^2]*pinv(A2)*B2*y'];
    f3 = [f3,[1,x_val,x_val^2,exp(x_val)]*pinv(A3)*B3*y'];
end 
hold on 
plot(x_f1,f1,x_f2,f2,x_f3,f3,'linewidth',2);
l=legend('data points','1+x','1+x+x^2','1+x+x^2+e^x');
set(l,'fontsize',10);
title('Moving Least Squares DEMO','fontsize',20);
set(gca,'fontsize',12);
grid on

