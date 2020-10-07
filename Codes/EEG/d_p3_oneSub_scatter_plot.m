
clear;
x=[0.4 0.6 0.8 0.8 1 1.2];

subn=7;
isub=subn:subn;
    
loadpath='./expP3/';
load(strcat(loadpath,'s', num2str(isub),'_s400.mat'));
cs400=fscnv;
clear fscnv;

load(strcat(loadpath,'s', num2str(isub),'_s600.mat'));
cs600=fscnv;
clear fscnv;

load(strcat(loadpath,'s', num2str(isub),'_s800.mat'));
cs800=fscnv;
clear fscnv;

load(strcat(loadpath,'s', num2str(isub),'_l800.mat'));
cl800=fscnv;
clear fscnv;

load(strcat(loadpath,'s', num2str(isub),'_l1000.mat'));
cl1000=fscnv;
clear fscnv;

load(strcat(loadpath,'s', num2str(isub),'_l1200.mat'));
cl1200=fscnv;
clear fscnv;


m(1)=mean(cs400,1);
m(2)=mean(cs600,1);
m(3)=mean(cs800,1);
m(4)=mean(cl800,1);
m(5)=mean(cl1000,1);
m(6)=mean(cl1200,1);

sd(1)=std(cs400,0,1);
sd(2)=std(cs600,0,1);
sd(3)=std(cs800,0,1);
sd(4)=std(cl800,0,1);
sd(5)=std(cl1000,0,1);
sd(6)=std(cl1200,0,1);


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
set(gca, 'Fontname', 'Arial','FontSize',16);
xlim([0.2 1.4])
ylim([-20 20])


plot([0.8 1 1.2],m(4:6),'-o','linewidth',1,'Color','k');
set(gca, 'Fontname', 'Arial','FontSize',16);
xlim([0.2 1.4])
ylim([-15 20])
