function b_oneSub(  );
clear;

%read data from xlsx files
data=xlsread('centraldata.xlsx');
sizData=size(data);
data(:,5)=data(:,5)/1000;
data(:,6)=data(:,6)/1000;

for isub=18:18;

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


ms400=squeeze(mean(s400,1));
ms600=squeeze(mean(s600,1));
ms800=squeeze(mean(s800,1));
ml800=squeeze(mean(l800,1));
ml1000=squeeze(mean(l1000,1));
ml1200=squeeze(mean(l1200,1));


sds400=squeeze(std(s400,0,1));
sds600=squeeze(std(s600,0,1));
sds800=squeeze(std(s800,0,1));
sdl800=squeeze(std(l800,0,1));
sdl1000=squeeze(std(l1000,0,1));
sdl1200=squeeze(std(l1200,0,1));


m(:,1)=ms400(6,18)';
m(:,2)=ms600(6,18)';
m(:,3)=ms800(6,18)';
m(:,4)=ml800(6,18)';
m(:,5)=ml1000(6,18)';
m(:,6)=ml1200(6,18)';

se(:,1)=1.96*sds400(6,18)'/sqrt(300);
se(:,2)=1.96*sds600(6,18)'/sqrt(300);
se(:,3)=1.96*sds800(6,18)'/sqrt(300);
se(:,4)=1.96*sdl800(6,18)'/sqrt(300);
se(:,5)=1.96*sdl1000(6,18)'/sqrt(300);
se(:,6)=1.96*sdl1200(6,18)'/sqrt(300);
%============



x=[0.4 0.6 0.8 0.8 1 1.2];
%plot([0.4 0.6 0.8 0.8 1 1.2],mt,'o');

errorbar(x(1:3),m(1:3),se(1:3),'-o','linewidth',1,'Color','k', 'MarkerSize',5,...
    'MarkerEdgeColor','k','MarkerFaceColor','k');
hold on;

errorbar(x(4:6),m(4:6),se(4:6),'-o','linewidth',1,'Color','k', 'MarkerSize',5,...
    'MarkerEdgeColor','k','MarkerFaceColor','k');
hold on;

C = linspecer(2);


load('bootBays.mat')
mte=squeeze(mean(bootBays.te,2));
sete=squeeze(std(bootBays.te,0,2));
m=mte(:,12);
se=1.96*sete(:,12);
%errorbar(x(1:3),m(1:3),se(1:3),'-o','linewidth',2,'Color',C(1,:), 'MarkerSize',5,...
%    'MarkerEdgeColor',C(1,:),'MarkerFaceColor',C(1,:));
hold on;

%errorbar(x(4:6),m(4:6),se(4:6),'-o','linewidth',2,'Color',C(1,:), 'MarkerSize',5,...
%    'MarkerEdgeColor',C(1,:),'MarkerFaceColor',C(1,:));
hold on;

plt.m=m(1:3);
plt.se=se(1:3);
plt.color=C(1,:);
plt.xrange=[0.4 1.2];
plt.yrange=[0.4 1.2];
plt.x=[0.4 0.6 0.8];
d_plotpic(plt);

hold on;

plt.m=m(4:6);
plt.se=se(4:6);
plt.color=C(1,:);
plt.xrange=[0.4 1.2];
plt.yrange=[0.4 1.2];
plt.x=[0.8 1 1.2];
d_plotpic(plt);





load('bootMLE.mat')

mte=squeeze(mean(bootMLE.te,2));
sete=squeeze(std(bootMLE.te,0,2));
m=mte(:,12);
se=1.96*sete(:,12);
%errorbar(x(1:3),m(1:3),se(1:3),'-o','linewidth',2,'Color',C(2,:), 'MarkerSize',5,...
%    'MarkerEdgeColor',C(2,:),'MarkerFaceColor',C(2,:));
hold on;

%errorbar(x(4:6),m(4:6),se(4:6),'-o','linewidth',2,'Color',C(2,:), 'MarkerSize',5,...
%    'MarkerEdgeColor',C(2,:),'MarkerFaceColor',C(2,:));
hold on;



hold on;

plt.m=m(1:3);
plt.se=se(1:3);
plt.color=C(2,:);
plt.xrange=[0.4 1.2];
plt.yrange=[0.4 1.2];
plt.x=[0.4 0.6 0.8];
d_plotpic(plt);

hold on;

plt.m=m(4:6);
plt.se=se(4:6);
plt.color=C(2,:);
plt.xrange=[0.2 1.4];
plt.yrange=[0.2 1.4];
plt.x=[0.8 1 1.2];
d_plotpic(plt);

y=[0.2:0.2:1.4]
plot(y,y,'--k')
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
                'LineWidth',1,...
                'Color',color)
            hold on;
hold on;



            
function [xx,yy]=fill2line(x,y1,y2)


sizX=size(x);
xx(1:sizX(2))=x;
xx(sizX(2)+1:sizX(2)*2)=x(1,sizX(2):-1:1);

yy(1:sizX(2))=y1';
yy(sizX(2)+1:sizX(2)*2)=y2(sizX(2):-1:1,1);
            
