clear;

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

nerp1=b1erp(326:550,:,:);
nerp2=b2erp(376:600,:,:);
nerp3=b3erp(426:650,:,:);
nerp4=b4erp(426:650,:,:);
nerp5=b5erp(476:700,:,:);
nerp6=b6erp(526:750,:,:);

x=-100:4:796;
base1=mean(nerp1(1:25,:,:),1);
base2=mean(nerp2(1:25,:,:),1);
base3=mean(nerp3(1:25,:,:),1);
base4=mean(nerp4(1:25,:,:),1);
base5=mean(nerp5(1:25,:,:),1);
base6=mean(nerp6(1:25,:,:),1);

sizx=size(x);
for i=1:sizx(2);
    berp1(i,:,:)=nerp1(i,:,:)-base1;
    berp2(i,:,:)=nerp2(i,:,:)-base2;
    berp3(i,:,:)=nerp3(i,:,:)-base3;
    berp4(i,:,:)=nerp4(i,:,:)-base4;
    berp5(i,:,:)=nerp5(i,:,:)-base5;
    berp6(i,:,:)=nerp6(i,:,:)-base6;
end;



erp1=mean(berp1(:,:,[1:18]),3);
erp2=mean(berp2(:,:,[1:18]),3);
erp3=mean(berp3(:,:,[1:18]),3);
erp4=mean(berp4(:,:,[1:18]),3);
erp5=mean(berp5(:,:,[1:18]),3);
erp6=mean(berp6(:,:,[1:18]),3);

%ferp1=erp1(:,22);
%ferp2=erp2(:,22);
%ferp3=erp3(:,22);
%ferp4=erp4(:,22);
%ferp5=erp5(:,22);
%ferp6=erp6(:,22);

ferp1=erp1(:,53);
ferp2=erp2(:,53);
ferp3=erp3(:,53);
ferp4=erp4(:,53);
ferp5=erp5(:,53);
ferp6=erp6(:,53);

lineStyles = linspecer(6);  %makes N colors for you to use: lineStyles(ii,:)

C = linspecer(6);

subplot(1,2,1)

plot(x,ferp1,'-', 'Color',C(1,:),'LineWidth',2);
hold on;
plot(x,ferp2,'-', 'Color',C(2,:),'LineWidth',2);
hold on;
plot(x,ferp3,'-', 'Color',C(3,:),'LineWidth',2);
hold on;



set(gca, 'xlim', [-100, 800]);
set(gca, 'ylim', [-3, 3]);
set(gca,'ydir','reverse')
plot([-200, 800],[0,0],'k','LineWidth',2);
plot([-100, -100],[-0.2,0.2],'k','LineWidth',2);
plot([200, 200],[-0.2,0.2],'k','LineWidth',2);
plot([400, 400],[-0.2,0.2],'k','LineWidth',2);
plot([600, 600],[-0.2,0.2],'k','LineWidth',2);
plot([800, 800],[-0.2,0.2],'k','LineWidth',2);

plot([0, 0],[-1,1],'k','LineWidth',2);
plot([-20,20],[1,1],'k','LineWidth',2);
plot([-20,20],[-1,-1],'k','LineWidth',2);

subplot(1,2,2)

plot(x,ferp4,'-', 'Color',C(4,:),'LineWidth',2);
hold on;
plot(x,ferp5,'-', 'Color',C(5,:),'LineWidth',2);
hold on;
plot(x,ferp6,'-', 'Color',C(6,:),'LineWidth',2);
hold on;



set(gca, 'xlim', [-100, 800]);
set(gca, 'ylim', [-3, 3]);
set(gca,'ydir','reverse')
plot([-200, 800],[0,0],'k','LineWidth',2);
plot([-100, -100],[-0.2,0.2],'k','LineWidth',2);
plot([200, 200],[-0.2,0.2],'k','LineWidth',2);
plot([400, 400],[-0.2,0.2],'k','LineWidth',2);
plot([600, 600],[-0.2,0.2],'k','LineWidth',2);
plot([800, 800],[-0.2,0.2],'k','LineWidth',2);

plot([0, 0],[-1,1],'k','LineWidth',2);
plot([-20,20],[1,1],'k','LineWidth',2);
plot([-20,20],[-1,-1],'k','LineWidth',2);
