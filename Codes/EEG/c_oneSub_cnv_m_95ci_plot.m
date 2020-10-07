function b_plot_singleCnv( );

clear;
x=[0.4 0.6 0.8 0.8 1 1.2];

for isub=18:18;
    
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


[boot]=bootstrapfit(100,cs400);
mse(1)=1.96*std(boot.m,0,2);
sdse(1)=1.96*std(boot.sd,0,2);

[boot]=bootstrapfit(100,cs600);
mse(2)=1.96*std(boot.m,0,2);
sdse(2)=1.96*std(boot.sd,0,2);

[boot]=bootstrapfit(100,cs800);
mse(3)=1.96*std(boot.m,0,2);
sdse(3)=1.96*std(boot.sd,0,2);

[boot]=bootstrapfit(100,cl800);
mse(4)=1.96*std(boot.m,0,2);
sdse(4)=1.96*std(boot.sd,0,2);

[boot]=bootstrapfit(100,cl1000);
mse(5)=1.96*std(boot.m,0,2);
sdse(5)=1.96*std(boot.sd,0,2);

[boot]=bootstrapfit(100,cl1200);
mse(6)=1.96*std(boot.m,0,2);
sdse(6)=1.96*std(boot.sd,0,2);


errorbar(x,-m,mse,'o','linewidth',1,'Color','k', 'MarkerSize',5,...
    'MarkerEdgeColor','k','MarkerFaceColor','k');
hold on;



load('bootCnvLine.mat')

sl=bootCnvLine.para(1,:,isub)*x(1)+bootCnvLine.para(3,:,isub);
mte(1)=mean(sl,2);
sete(1)=1.96*std(sl,0,2);

sl=bootCnvLine.para(1,:,isub)*x(2)+bootCnvLine.para(3,:,isub);
mte(2)=mean(sl,2);
sete(2)=1.96*std(sl,0,2);

sl=bootCnvLine.para(1,:,isub)*x(3)+bootCnvLine.para(3,:,isub);
mte(3)=mean(sl,2);
sete(3)=1.96*std(sl,0,2);

sl=bootCnvLine.para(1,:,isub)*x(4)+bootCnvLine.para(3,:,isub);
mte(4)=mean(sl,2);
sete(4)=1.96*std(sl,0,2);

sl=bootCnvLine.para(1,:,isub)*x(5)+bootCnvLine.para(3,:,isub);
mte(5)=mean(sl,2);
sete(5)=1.96*std(sl,0,2);

sl=bootCnvLine.para(1,:,isub)*x(6)+bootCnvLine.para(3,:,isub);
mte(6)=mean(sl,2);
sete(6)=1.96*std(sl,0,2);


%=====================
sl=bootCnvLine.para(2,:,isub)*x(1)+bootCnvLine.para(4,:,isub);
msd(1)=mean(sl,2);
sesd(1)=1.96*std(sl,0,2);

sl=bootCnvLine.para(2,:,isub)*x(2)+bootCnvLine.para(4,:,isub);
msd(2)=mean(sl,2);
sesd(2)=1.96*std(sl,0,2);

sl=bootCnvLine.para(2,:,isub)*x(3)+bootCnvLine.para(4,:,isub);
msd(3)=mean(sl,2);
sesd(3)=1.96*std(sl,0,2);

sl=bootCnvLine.para(2,:,isub)*x(4)+bootCnvLine.para(4,:,isub);
msd(4)=mean(sl,2);
sesd(4)=1.96*std(sl,0,2);

sl=bootCnvLine.para(2,:,isub)*x(5)+bootCnvLine.para(4,:,isub);
msd(5)=mean(sl,2);
sesd(5)=1.96*std(sl,0,2);

sl=bootCnvLine.para(2,:,isub)*x(6)+bootCnvLine.para(4,:,isub);
msd(6)=mean(sl,2);
sesd(6)=1.96*std(sl,0,2);

C = linspecer(4);


%errorbar(x,mte,sesd,'-o','linewidth',2,'Color',C(2,:), 'MarkerSize',5,...
%    'MarkerEdgeColor',C(2,:),'MarkerFaceColor',C(2,:));
hold on;


plt.m=mte';
plt.se=sesd';
plt.color=C(4,:);
plt.xrange=[0.2 1.4];
plt.yrange=[0 14];
plt.x=x;
d_plotpic(plt);
set(gca, 'Fontname', 'Arial','FontSize',16);




end;

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


