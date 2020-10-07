function f_plot_bfSd(  )
clear;

load('bfSD.mat')


ds=squeeze(mean(bfSD.sdUp,2));

mbf=mean(ds,2);
ci=1.96*std(ds,0,2)/sqrt(18);

C = linspecer(10);
x=[0.4 0.6 0.8 0.8 1 1.2];

plt.m=mbf(1:3);
plt.se=ci(1:3);
plt.color=C(8,:);
plt.xrange=[0.2 1.4];
plt.yrange=[0 10];
plt.x=x(1:3);
d_plotpic(plt);

plt.m=mbf(4:6);
plt.se=ci(4:6);
plt.color=C(10,:);
plt.xrange=[0.2 1.4];
plt.yrange=[-0.01 0.07];
plt.x=x(4:6);
d_plotpic(plt);
hold on;
xx=0.2:0.1:1.4;
yy=xx-xx;

plot(xx,yy,'--')


set(gca, 'Fontname', 'Arial','FontSize',16);



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