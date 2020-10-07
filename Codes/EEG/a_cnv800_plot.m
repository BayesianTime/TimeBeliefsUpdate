eeglab


load('./expMean/s400.mat');%0dlt
load('./expMean/s600.mat');%ldlt
load('./expMean/s800.mat');%sdlt
load('./expMean/l800.mat');%0dst
load('./expMean/l1000.mat');%ldst
load('./expMean/l1200.mat');%sdst
load('./expMean/times.mat');
load('./expMean/chan.mat');


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


%[6 7 9 10 11 12 14 16 18]
erp1=mean(berp1(:,:,[1:18]),3);
erp2=mean(berp2(:,:,[1:18]),3);
erp3=mean(berp3(:,:,[1:18]),3);
erp4=mean(berp4(:,:,[1:18]),3);
erp5=mean(berp5(:,:,[1:18]),3);
erp6=mean(berp6(:,:,[1:18]),3);

%ferp1=mean(erp1(:,[4 5 36]),2);
%ferp2=mean(erp2(:,[4 5 36]),2);
%ferp3=mean(erp3(:,[4 5 36]),2);
%ferp4=mean(erp4(:,[4 5 36]),2);
%ferp5=mean(erp5(:,[4 5 36]),2);
%ferp6=mean(erp6(:,[4 5 36]),2);

ferp1=erp1(:,53);
ferp2=erp2(:,53);
ferp3=erp3(:,53);
ferp4=erp4(:,53);
ferp5=erp5(:,53);
ferp6=erp6(:,53);

dif=ferp4-ferp3;

C = linspecer(2);

subplot(1,2,1);
plot(x,ferp3,'-', 'Color',C(1,:),'LineWidth',2);%(ltime;0distance;ldistance;sdistance,EF)
hold on;
plot(x,ferp4,'-', 'Color',C(2,:),'LineWidth',2);
hold on;
plot(x,dif,'k','LineWidth',2);
hold on;



set(gca, 'xlim', [-200, 1600]);
set(gca, 'ylim', [-6.5, 3.5]);
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


merp1=mean(erp1(501:576,:),1);
merp2=mean(erp2(501:576,:),1);
merp3=mean(erp3(501:576,:),1);
merp4=mean(erp4(501:576,:),1);
merp5=mean(erp5(501:576,:),1);
merp6=mean(erp6(501:576,:),1);
topdif=merp4-merp3;
subplot(1,2,2);
topoplot(topdif,chan,'style','both', 'electrodes','on');
