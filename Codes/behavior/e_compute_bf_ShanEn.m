

clear;

load('bootBays.mat');

t=[0.4 0.6 0.8 0.8 1 1.2];

sizp=size(bootBays.para);

for i=1:6;
    for j=1:sizp(2);
        for k=1:sizp(3);
            if i>=1 && i <=3;
                x_min=0.4;
               x_max=0.8; 
            else
               x_min=0.8;
               x_max=1.2; 
            end;
               ts=t(i);
               wm=bootBays.para(1,j,k);
               
               fun0 = @(x) normpdf(x,ts,ts*wm);
               mx0= integral(fun0,x_min,x_max);
               
               
               fun1 = @(x) -(normpdf(x,ts,ts*wm)./mx0).*log(normpdf(x,ts,ts*wm)./mx0);
               ShEn(i,j,k) = integral(fun1,x_min,x_max);
        end;
    end;
end;

               
               
x_min=0.4;
x_max=0.8;                
fun1 = @(x) -unifpdf(x,x_min,x_max).*log(unifpdf(x,x_min,x_max));
ShEnP(1)= integral(fun1,x_min,x_max);

x_min=0.8;
x_max=1.2;                
fun1 = @(x) -unifpdf(x,x_min,x_max).*log(unifpdf(x,x_min,x_max));
ShEnP(2)= integral(fun1,x_min,x_max);



            
for i=1:6;
    for j=1:sizp(2);
        for k=1:sizp(3);
            if i>=1 && i <=3;
               BaysUp(i,j,k)=ShEnP(1)-ShEn(i,j,k);
               x_max=0.8; 
            else
               BaysUp(i,j,k)=ShEnP(2)-ShEn(i,j,k); 
            end;

        end;
    end;
end;
            

ShanEntr.ShEn=ShEn;
ShanEntr.ShEnP=ShEnP;
ShanEntr.BaysUp=BaysUp;

savepath='./';
save(strcat(savepath,'ShanEntr.mat'),'ShanEntr');

