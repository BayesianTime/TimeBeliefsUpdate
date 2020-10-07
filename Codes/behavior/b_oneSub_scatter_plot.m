function [cl1200]=b_oneSub_hist(  );
clear;

%read data from xlsx files
data=xlsread('centraldata.xlsx');
sizData=size(data);
data(:,5)=data(:,5)/1000;
data(:,6)=data(:,6)/1000;

subn=18;

for isub=subn:subn;

j(1:6)=0;

for i=1:sizData(1);
    if data(i,2)==isub && data(i,1)==1 && data(i,5)==0.400;
        j(1)=j(1)+1;
        s400(j(1),:,isub)=data(i,:);
    end;
    
    if data(i,2)==isub && data(i,1)==1 && data(i,5)==0.600;
        j(2)=j(2)+1;
        s600(j(2),:,isub)=data(i,:);
    end;    
 
    if data(i,2)==isub && data(i,1)==1 && data(i,5)==0.800;
        j(3)=j(3)+1;
        s800(j(3),:,isub)=data(i,:);
    end;      
 
    if data(i,2)==isub && data(i,1)==2 && data(i,5)==0.800;
        j(4)=j(4)+1;
        l800(j(4),:,isub)=data(i,:);
    end;
    
    if data(i,2)==isub && data(i,1)==2 && data(i,5)==1.000;
        j(5)=j(5)+1;
        l1000(j(5),:,isub)=data(i,:);
    end;    
 
    if data(i,2)==isub && data(i,1)==2 && data(i,5)==1.200;
        j(6)=j(6)+1;
        l1200(j(6),:,isub)=data(i,:);
    end;       
    
    
end;

    

end;


cs400=s400(:,6,subn);
cs600=s600(:,6,subn);
cs800=s800(:,6,subn);
cl800=l800(:,6,subn);
cl1000=l1000(:,6,subn);
cl1200=l1200(:,6,subn);

m(1)=mean(cs400,1);
m(2)=mean(cs600,1);
m(3)=mean(cs800,1);
m(4)=mean(cl800,1);
m(5)=mean(cl1000,1);
m(6)=mean(cl1200,1);


sizd=size(cs400);
xd=ones(sizd)*0.39+randn(sizd(1),1)*0.02;



plot(xd,cs400,'.');

hold on;

sizd=size(cs600);
xd=ones(sizd)*0.59+randn(sizd(1),1)*0.02;

plot(xd,cs600,'.');

hold on;

sizd=size(cs800);
xd=ones(sizd)*0.79+randn(sizd(1),1)*0.02;

plot(xd,cs800,'.');

hold on;

sizd=size(cl800);
xd=ones(sizd)*0.79+randn(sizd(1),1)*0.02;

plot(xd,cl800,'.');

hold on;

sizd=size(cl1000);
xd=ones(sizd)*0.99+randn(sizd(1),1)*0.02;

plot(xd,cl1000,'.');

hold on;


sizd=size(cl1200);
xd=ones(sizd)*1.19+randn(sizd(1),1)*0.02;

plot(xd,cl1200,'.');

hold on;

plot([0.4 0.6 0.8],m(1:3),'-o','linewidth',1,'Color','k');
hold on;
plot([0.8 1 1.2],m(4:6),'-o','linewidth',1,'Color','k');
hold on;

y=[0:0.2:1.6]
plot(y,y,'--k')

set(gca, 'Fontname', 'Arial','FontSize',16);
xlim([0 1.6])
ylim([0 1.6])




