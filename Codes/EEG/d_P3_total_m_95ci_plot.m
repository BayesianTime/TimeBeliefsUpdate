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

m1=m(:,[1:18]);
clear m;
m=m1;

sd1=sd(:,[1:18]);
clear sd;
sd=sd1;

mm=mean(m,2);

for ii=1:6;
[boot]=bootstrapfit(1000,m(ii,:)');
mse(ii)=1.96*std(boot.m,0,2);

end;

msd=mean(sd,2);

for ii=1:6;
[boot]=bootstrapfit(1000,sd(ii,:)');
sdse(ii)=1.96*std(boot.m,0,2);

end;


subplot(1,2,1);
errorbar(x,mm,mse,'o','linewidth',1,'Color','k', 'MarkerSize', 5,...
    'MarkerEdgeColor','k','MarkerFaceColor','k');
hold on;

subplot(1,2,2);

errorbar(x,msd,sdse,'o','linewidth',1,'Color','k', 'MarkerSize',5,...
    'MarkerEdgeColor','k','MarkerFaceColor','k');
hold on;


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
tes=mpara0(:,[1:18]);
clear mpara0;



x=[0.6 0.6 0.6 1 1 1];
for i=1:18;
dte(:,i)=x'-tes(:,i);
end;

for i=1:6;
mte(i,:)=dte(i,:).*mpara(1,:)+mpara(3,:);
end;

m1=squeeze(mean(mte,2));

for ii=1:6;
[boot]=bootstrapfit(1000,mte(ii,:)');
mse1(ii)=1.96*std(boot.m,0,2);

end;


for i=1:6;
msd1(i,:)=dte(i,:).*mpara(2,:)+mpara(4,:);
end;

m2=squeeze(mean(msd1,2));

for ii=1:6;
[boot]=bootstrapfit(1000,msd1(ii,:)');
mse2(ii)=1.96*std(boot.m,0,2);

end;

C = linspecer(4);

x=[0.4 0.6 0.8 0.8 1 1.2];

subplot(1,2,1);
%errorbar(x(1:3),m1(1:3),mse1(1:3),'-o','linewidth',2,'Color',C(1,:), 'MarkerSize',5,...
%    'MarkerEdgeColor',C(1,:),'MarkerFaceColor',C(1,:));
plt.m=m1(1:3);
plt.se=mse1(1:3)';
plt.color=C(1,:);
plt.xrange=[0.2 1.4];
plt.yrange=[-3 3];
plt.x=x(1:3);
d_plotpic(plt);
set(gca, 'Fontname', 'Arial','FontSize',16);

hold on;

%errorbar(x(4:6),m1(4:6),mse1(4:6),'-o','linewidth',2,'Color',C(1,:), 'MarkerSize',5,...
%    'MarkerEdgeColor',C(1,:),'MarkerFaceColor',C(1,:));

plt.m=m1(4:6);
plt.se=mse1(4:6)';
plt.color=C(1,:);
plt.xrange=[0.2 1.4];
plt.yrange=[-3 3];
plt.x=x(4:6);
d_plotpic(plt);
set(gca, 'Fontname', 'Arial','FontSize',16);


hold on;

subplot(1,2,2);

%errorbar(x(1:3),m2(1:3),mse2(1:3),'-o','linewidth',2,'Color',C(1,:), 'MarkerSize',5,...
%    'MarkerEdgeColor',C(1,:),'MarkerFaceColor',C(1,:));

plt.m=m2(1:3);
plt.se=mse2(1:3)';
plt.color=C(1,:);
plt.xrange=[0.2 1.4];
plt.yrange=[5 14];
plt.x=x(1:3);
d_plotpic(plt);
set(gca, 'Fontname', 'Arial','FontSize',16);

hold on;
%errorbar(x(4:6),m2(4:6),mse2(4:6),'-o','linewidth',2,'Color',C(1,:), 'MarkerSize',5,...
%    'MarkerEdgeColor',C(1,:),'MarkerFaceColor',C(1,:));

plt.m=m2(4:6);
plt.se=mse2(4:6)';
plt.color=C(1,:);
plt.xrange=[0.2 1.4];
plt.yrange=[4 14];
plt.x=x(4:6);
d_plotpic(plt);
set(gca, 'Fontname', 'Arial','FontSize',16);



hold on;






function [boot]=bootstrapfit(nboot,data);

sizData=size(data);


%=======================
iboot=2;

while iboot<=nboot; 
 
%try    
    
[bootstat,bootsam] = bootstrp(1,@mean,[1:sizData(1)]);
for ntri=1:sizData(1);
data1(ntri,:)=data(bootsam(ntri,1),:);
end;

boot.m(iboot)=mean(data1);
boot.sd(iboot)=std(data1);
    
%end;

iboot=iboot+1;

end;


function d_plotpic(plt);
m=plt.m;
se=plt.se;
color=plt.color;
xrange=plt.xrange;
yrange=plt.yrange;
x=plt.x

y1=m-se;
y2=m+se;


[xx,yy]=fill2line(x,y1,y2);
h=fill(xx,yy,color,'EdgeColor',color,'FaceAlpha',0.5,'EdgeAlpha',0.3);
set(h,'edgecolor','white');
set(gca, 'ylim',yrange);      %[0.7, 1.0000001]
set(gca, 'xlim',xrange);            %[0, 24]

hold on;

plot(x,m,'-',...
                'LineWidth',2,...
                'Color',color)
            hold on;
hold on;



            
function [xx,yy]=fill2line(x,y1,y2)


sizX=size(x);
xx(1:sizX(2))=x;
xx(sizX(2)+1:sizX(2)*2)=x(1,sizX(2):-1:1);

yy(1:sizX(2))=y1';
yy(sizX(2)+1:sizX(2)*2)=y2(sizX(2):-1:1,1);
