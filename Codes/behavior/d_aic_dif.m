load('bootBays.mat');
AIC(:,1)=2*2+2*mean(bootBays.E,1);

load('bootMLE.mat');
AIC(:,2)=2*2+2*mean(bootMLE.E,1);

difAIC=AIC(:,2)-AIC(:,1);


bar(difAIC([1:18]));
set(gca, 'xlim',[0 19]);  
set(gca, 'Fontname', 'Arial','FontSize',16);