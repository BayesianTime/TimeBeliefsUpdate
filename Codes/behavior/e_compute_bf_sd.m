
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
               mx01= integral(fun0,x_min,x_max);

             
                fun1 = @(x) x.*normpdf(x,ts,ts*wm)./mx01;
                mx1= integral(fun1,x_min,x_max);
               
                fun2 = @(x) ((x-mx1).^2).*normpdf(x,ts,ts*wm)./mx01;
                sdx(i,j,k)= sqrt(integral(fun2,x_min,x_max)); 
               
               
               
        end;
    end;
end;

               
               
x_min=0.4;
x_max=0.8;

fun1 = @(x) x.*unifpdf(x,x_min,x_max);
mx= integral(fun1,x_min,x_max);
               
fun2 = @(x) ((x-mx).^2).*unifpdf(x,x_min,x_max);
sdxp(1)= sqrt(integral(fun2,x_min,x_max));




x_min=0.8;
x_max=1.2;                

fun1 = @(x) x.*unifpdf(x,x_min,x_max);
mx= integral(fun1,x_min,x_max);
               
fun2 = @(x) ((x-mx).^2).*unifpdf(x,x_min,x_max);
sdxp(2)= sqrt(integral(fun2,x_min,x_max));



            
for i=1:6;
    for j=1:sizp(2);
        for k=1:sizp(3);
            if i>=1 && i <=3;
               sdUp(i,j,k)=sdxp(1)-sdx(i,j,k);
               x_max=0.8; 
            else
               sdUp(i,j,k)=sdxp(2)-sdx(i,j,k); 
            end;

        end;
    end;
end;
            

bfSD.sdte=sdx;
bfSD.sdPri=sdxp;
bfSD.sdUp=sdUp;

savepath='./';
save(strcat(savepath,'bfSD.mat'),'bfSD');
