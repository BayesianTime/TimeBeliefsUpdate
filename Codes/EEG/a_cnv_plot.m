load('./expMean/s400.mat');%0dlt
load('./expMean/s600.mat');%ldlt
load('./expMean/s800.mat');%sdlt
load('./expMean/l800.mat');%0dst
load('./expMean/l1000.mat');%ldst
load('./expMean/l1200.mat');%sdst
load('./expMean/times.mat');

b1erp = permute(s400,[2 1 3]);
b2erp = permute(s600,[2 1 3]);
b3erp = permute(s800,[2 1 3]);
b4erp = permute(l800,[2 1 3]);
b5erp = permute(l1000,[2 1 3]);
b6erp = permute(l1200,[2 1 3]);

base1=mean(b1erp(201:251,:,:),1);
base2=mean(b2erp(201:251,:,:),1);
base3=mean(b3erp(201:251,:,:),1);
base4=mean(b4erp(201:251,:,:),1);
base5=mean(b5erp(201:251,:,:),1);
base6=mean(b6erp(201:251,:,:),1);

x=times;
sizx=size(x);
for i=1:sizx(2);
    berp1(i,:,:)=b1erp(i,:,:)-base1;
    berp2(i,:,:)=b2erp(i,:,:)-base2;
    berp3(i,:,:)=b3erp(i,:,:)-base3;
    berp4(i,:,:)=b4erp(i,:,:)-base4;
    berp5(i,:,:)=b5erp(i,:,:)-base5;
    berp6(i,:,:)=b6erp(i,:,:)-base6;
end;



% erp1=mean(berp1(:,:,[6 7 9 10 11 12 14 16 18]),3);
erp1=mean(berp1(:,:,[1:18]),3);
erp2=mean(berp2(:,:,[1:18]),3);
erp3=mean(berp3(:,:,[1:18]),3);
erp4=mean(berp4(:,:,[1:18]),3);
erp5=mean(berp5(:,:,[1:18]),3);
erp6=mean(berp6(:,:,[1:18]),3);

ferp1=erp1(:,53);
ferp2=erp2(:,53);
ferp3=erp3(:,53);
ferp4=erp4(:,53);
ferp5=erp5(:,53);
ferp6=erp6(:,53);

C = linspecer(6);


subplot(1,2,1)
plot(x,ferp1, '-', 'Color',C(1,:), 'LineWidth',2);%(ltime;0distance;ldistance;sdistance,EF)
hold on;
plot(x,ferp2,'-', 'Color', C(2,:), 'LineWidth',2);
hold on;
plot(x,ferp3, '-', 'Color',C(3,:), 'LineWidth',2);
hold on;


set(gca, 'xlim', [-200, 1600]);
set(gca, 'ylim', [-7, 3]);
set(gca,'ydir','reverse')
plot([-200, 1600],[0,0],'k','LineWidth',2);
plot([-200, -200],[-0.2,0.2],'k','LineWidth',2);
plot([200, 200],[-0.2,0.2],'k','LineWidth',2);
plot([400, 400],[-0.2,0.2],'k','LineWidth',2);
plot([600, 600],[-0.2,0.2],'k','LineWidth',2);
plot([800, 800],[-0.2,0.2],'k','LineWidth',2);
plot([1000, 1000],[-0.2,0.2],'k','LineWidth',2);
plot([1200, 1200],[-0.2,0.2],'k','LineWidth',2);
plot([1400, 1400],[-0.2,0.2],'k','LineWidth',2);
plot([1600, 1600],[-0.2,0.2],'k','LineWidth',2);


plot([0, 0],[-2,2],'k','LineWidth',2);
plot([-20,20],[2, 2],'k','LineWidth',2);
plot([-20,20],[1,1],'k','LineWidth',2);
plot([-20,20],[-1,-1],'k','LineWidth',2);
plot([-20,20],[-2,-2],'k','LineWidth',2);







subplot(1,2,2)
plot(x,ferp4, '-', 'Color',C(4,:),'LineWidth',2);%(ltime;0distance;ldistance;sdistance,EF)
hold on;
plot(x,ferp5, '-', 'Color',C(5,:),'LineWidth',2);
hold on;
plot(x,ferp6, '-', 'Color',C(6,:),'LineWidth',2);
hold on;

set(gca, 'xlim', [-200, 1600]);
set(gca, 'ylim', [-7, 3]);
set(gca,'ydir','reverse')
plot([-200, 1600],[0,0],'k','LineWidth',2);
plot([-200, -200],[-0.2,0.2],'k','LineWidth',2);
plot([200, 200],[-0.2,0.2],'k','LineWidth',2);
plot([400, 400],[-0.2,0.2],'k','LineWidth',2);
plot([600, 600],[-0.2,0.2],'k','LineWidth',2);
plot([800, 800],[-0.2,0.2],'k','LineWidth',2);
plot([1000, 1000],[-0.2,0.2],'k','LineWidth',2);
plot([1200, 1200],[-0.2,0.2],'k','LineWidth',2);
plot([1400, 1400],[-0.2,0.2],'k','LineWidth',2);
plot([1600, 1600],[-0.2,0.2],'k','LineWidth',2);


plot([0, 0],[-2,2],'k','LineWidth',2);
plot([-20,20],[2, 2],'k','LineWidth',2);
plot([-20,20],[1,1],'k','LineWidth',2);
plot([-20,20],[-1,-1],'k','LineWidth',2);
plot([-20,20],[-2,-2],'k','LineWidth',2);



