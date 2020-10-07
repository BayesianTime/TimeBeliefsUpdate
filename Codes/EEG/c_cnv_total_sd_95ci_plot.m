function b_plot_CnvTall( );

clear;
x=[0.4 0.6 0.8 0.8 1 1.2];

for isub=1:18;
    
loadpath='./expCnv/';
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


mm=mean(m,2);

for ii=1:6;
[boot]=bootstrapfit(100,m(ii,:)');
mse(ii)=1.96*std(boot.m,0,2);

end;

msd=mean(sd,2);

for ii=1:6;
[boot]=bootstrapfit(100,sd(ii,:)');
sdse(ii)=1.96*std(boot.m,0,2);

end;





errorbar(x,msd,sdse,'o','linewidth',1,'Color','k', 'MarkerSize',5,...
    'MarkerEdgeColor','k','MarkerFaceColor','k');
hold on;



load('bootCnvLine.mat')

for ii=1:6;
mte(ii,:,:)=bootCnvLine.para(1,:,:)*x(ii)+bootCnvLine.para(3,:,:);
end;

m=squeeze(mean(mte,2));
mm=mean(m,2);
for ii=1:6;
[boot]=bootstrapfit(100,m(ii,:)');
mse(ii)=1.96*std(boot.m,0,2);
end;



for ii=1:6;
sdte(ii,:,:)=bootCnvLine.para(2,:,:)*x(ii)+bootCnvLine.para(4,:,:);
end;

sd=squeeze(mean(sdte,2));
msd=mean(sd,2);
for ii=1:6;
[boot]=bootstrapfit(100,sd(ii,:)');
sdse(ii)=1.96*std(boot.m,0,2);

end;

C = linspecer(4);



%errorbar(x,msd,sdse,'-o','linewidth',2,'Color',C(2,:), 'MarkerSize',5,...
%    'MarkerEdgeColor',C(2,:),'MarkerFaceColor',C(2,:));
hold on;

plt.m=msd;
plt.se=sdse';
plt.color=C(3,:);
plt.xrange=[0.2 1.4];
plt.yrange=[0 18];
plt.x=x;
d_plotpic(plt);
set(gca, 'Fontname', 'Arial','FontSize',16);





function [boot]=bootstrapfit(nboot,data);

sizData=size(data);


%=======================
iboot=1;

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

