function c_plot_P3Total( );

clear;
x=[0.4 0.6 0.8 0.8 1 1.2];

for isub=1:18;
    
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

m(1,isub)=mean(cs400,1);
m(2,isub)=mean(cs600,1);
m(3,isub)=mean(cs800,1);
m(4,isub)=mean(cl800,1);
m(5,isub)=mean(cl1000,1);
m(6,isub)=mean(cl1200,1);



sd(1,isub)=std(cs400,0,1);
sd(2,isub)=std(cs600,0,1);
sd(3,isub)=std(cs800,0,1);
sd(4,isub)=std(cl800,0,1);
sd(5,isub)=std(cl1000,0,1);
sd(6,isub)=std(cl1200,0,1);



end;




load('bootP3Bays.mat')
mpara=squeeze(mean(bootP3Bays.para,2))
mpara0=mpara;
clear mpara;
mpara=mpara0(:,[1:18]);
clear mpara0;


load('./行为结果/bootBays.mat')
tes=squeeze(mean(bootBays.te,2));
mpara0=tes;
clear tes;
tes=mpara0(:,:);
clear mpara0;



x=[0.6 0.6 0.6 1 1 1];
for i=1:18;
dte(:,i)=x'-tes(:,i);
end;

for i=1:6;
mte(i,:)=dte(i,:).*mpara(1,:)+mpara(3,:);
end;





for i=1:6;
msd1(i,:)=dte(i,:).*mpara(2,:)+mpara(4,:);
end;




plot(m(:),mte(:),'o')

hold on;



plot(sd(:),msd1(:),'.k')

hold on;

xx=-10:0.1:30;
plot(xx,xx,'--k');


xlim([-8 20])
ylim([-8 20])
set(gca, 'Fontname', 'Arial','FontSize',16);