function b_bootP3Bays(  );

clear;

load('./行为结果/bootBays.mat')
mte=squeeze(mean(bootBays.te,2));

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


sizs=size(cs400);
data(1:sizs(1),1)=0.4;
data(1:sizs(1),2)=cs400;
data(1:sizs(1),3)=mte(1,isub);
data(1:sizs(1),4)=0.6;

sizdat=size(data);
sizs=size(cs600);
data((sizdat(1)+1):(sizdat(1)+sizs(1)),1)=0.6;
data((sizdat(1)+1):(sizdat(1)+sizs(1)),2)=cs600;
data((sizdat(1)+1):(sizdat(1)+sizs(1)),3)=mte(2,isub);
data((sizdat(1)+1):(sizdat(1)+sizs(1)),4)=0.6;

sizdat=size(data);
sizs=size(cs800);
data((sizdat(1)+1):(sizdat(1)+sizs(1)),1)=0.8;
data((sizdat(1)+1):(sizdat(1)+sizs(1)),2)=cs800;
data((sizdat(1)+1):(sizdat(1)+sizs(1)),3)=mte(3,isub);
data((sizdat(1)+1):(sizdat(1)+sizs(1)),4)=0.6;

sizdat=size(data);
sizs=size(cl800);
data((sizdat(1)+1):(sizdat(1)+sizs(1)),1)=0.8;
data((sizdat(1)+1):(sizdat(1)+sizs(1)),2)=cl800;
data((sizdat(1)+1):(sizdat(1)+sizs(1)),3)=mte(4,isub);
data((sizdat(1)+1):(sizdat(1)+sizs(1)),4)=1;

sizdat=size(data);
sizs=size(cl1000);
data((sizdat(1)+1):(sizdat(1)+sizs(1)),1)=1;
data((sizdat(1)+1):(sizdat(1)+sizs(1)),2)=cl1000;
data((sizdat(1)+1):(sizdat(1)+sizs(1)),3)=mte(5,isub);
data((sizdat(1)+1):(sizdat(1)+sizs(1)),4)=1;

sizdat=size(data);
sizs=size(cl1200);
data((sizdat(1)+1):(sizdat(1)+sizs(1)),1)=1.2;
data((sizdat(1)+1):(sizdat(1)+sizs(1)),2)=cl1200;
data((sizdat(1)+1):(sizdat(1)+sizs(1)),3)=mte(6,isub);
data((sizdat(1)+1):(sizdat(1)+sizs(1)),4)=1;

boot=bootstrapfit(isub, data);

para0(:,:,isub)=boot.para;
E0(:,:,isub)=boot.E;


clear data;

end;

bootP3Bays.para=squeeze(para0);
bootP3Bays.E=squeeze(E0);

savepath='./';
save(strcat(savepath,'bootP3Bays.mat'),'bootP3Bays');
clear bootP3Bays;


function [boot]=bootstrapfit(isub, data);

sizData=size(data);


%=======================
iboot=1;

while iboot<=1000; 
 
%try    
    
[bootstat,bootsam] = bootstrp(1,@mean,[1:sizData(1)]);
for ntri=1:sizData(1);
data1(ntri,:)=data(bootsam(ntri,1),:);
end;

k.sub=isub;      
k.data=data1;

[a1]=fitModel(k);
E0=fitFun(a1,k);

para0=a1;

boot.para(:,iboot)=para0';
boot.E(:,iboot)=E0;
    
%end;

iboot=iboot+1;

end;



function [a1]=fitModel(k);

% begin to fit data
options=optimset('fminsearch');
options.TolX=0.001;
options.Display='final';
            
r0=rand(1,4);
c0=[10 0 0 10]; 
c1=c0+r0;
            
[a1,sfval,sexit,soutput]=fminsearch(@fitFun,c1,options,k);
            
               
function E=fitFun(a1,k);

wm=a1(1);
wsd=a1(2);
wc1=a1(3);
wc2=a1(4);

dt=k.data(:,4)-k.data(:,3);
nts=k.data(:,2);

logPro=-log(normpdf(nts,dt*wm+wc1,dt*wsd+wc2));
E=sum(logPro); 
