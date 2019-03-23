bound1=3;bound2=5;res=0.1;
t1=-bound1:res:bound1;
t2=-bound2:res:bound2;
[x,y]=meshgrid(t1,t2);[r,c]=size(x);z=zeros(r,c);
for i=1:r 
    for j=1:c
        ii=x(1,j);jj=y(i,1);
        s=norm([ii jj])/norm([bound1 bound2]);
        if s<=1/2
            z(i,j)=2/3-4*s^2+4*s^3;
        else if s<=1
                z(i,j)=4/3-4*s+4*s^2-4/3*s^3;
            else
                z(i,j)=0;
            end
        end
    end
end
figure
mesh(x,y,z,'FaceLighting','gouraud','LineWidth',1);