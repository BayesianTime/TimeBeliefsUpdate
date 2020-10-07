function a_bootBayes(  );

clear;

%read data from xlsx files
data=xlsread('centraldata.xlsx');
sizData=size(data);
data(:,5)=data(:,5)/1000;
data(:,6)=data(:,6)/1000;


parfor isub=1:18;

boot=bootstrapfit(isub, data);

te0(:,:,isub)=boot.te;
para0(:,:,isub)=boot.para;
E0(:,:,isub)=boot.E;

end;

bootMLE.te=squeeze(te0);
bootMLE.para=squeeze(para0);
bootMLE.E=squeeze(E0);

savepath='./';
save(strcat(savepath,'bootMLE.mat'),'bootMLE');
clear bootMLE;



function [boot]=bootstrapfit(isub, data);

sizData=size(data);
j=0;
for i=1:sizData(1);
    if data(i,2)==isub && data(i,1)==1;
        j=j+1;
        sdata(j,:)=data(i,:);
    end;
end;

j=0;
for i=1:sizData(1);
    if data(i,2)==isub && data(i,1)==2;
        j=j+1;
        ldata(j,:)=data(i,:);
    end;
end;

sizData1=size(sdata);
sizData2=size(ldata);

%=======================
iboot=1;

while iboot<=1000; 
 
%try    
    
[bootstat,bootsam] = bootstrp(1,@mean,[1:sizData1(1)]);
for ntri=1:sizData1(1);
data1(ntri,:)=sdata(bootsam(ntri,1),:);
end;

[bootstat,bootsam] = bootstrp(1,@mean,[1:sizData2(1)]);
for ntri=1:sizData2(1);
data2(ntri,:)=ldata(bootsam(ntri,1),:);
end;


k.sub=isub;      
k.data1=data1;
k.data2=data2;


[a1]=fitModel(k);
E0=fitFun(a1,k);

ts=[0.4 0.6 0.8];
te1=estTe(a1,ts);
ts=[0.8 1 1.2];
te2=estTe(a1,ts);

para0=a1;




    
    boot.para(:,iboot)=para0';
    boot.te(1:3,iboot)=te1';
    boot.te(4:6,iboot)=te2';
    boot.E(:,iboot)=E0;
    
%end;

iboot=iboot+1;
end;



function [a1]=fitModel(k);

% begin to fit data
options=optimset('fminsearch');
options.TolX=0.001;
options.Display='final';
            
r0=rand(1,2)*0.1;
c0=[0.2 0.2]; 
c1=c0+r0;
            
[a1,sfval,sexit,soutput]=fminsearch(@fitFun,c1,options,k);
            
               

function E=fitFun(a1,k);
ws=a1(1);
wp=a1(2);

ts1=[0.4 0.6 0.8];
q=estTe(a1,ts1);

ts=k.data1(:,5);
tp=k.data1(:,6);
sizts=size(ts);

for i=1:sizts(1);
    for j=1:3;
        tss1=ts(i,1);
        tss2=ts1(1,j);
        if tss1==tss2;
            te(i,1)=q(1,j);
        end;
    end;
end;


logPro1=-log(normpdf(tp,(te),(te.*wp)));
E1=sum(logPro1); 
clear ts;
clear tp;

ts1=[0.8 1 1.2];
q=estTe(a1,ts1);

ts=k.data2(:,5);
tp=k.data2(:,6);
sizts=size(ts);

for i=1:sizts(1);
    for j=1:3;
        tss1=ts(i,1);
        tss2=ts1(1,j);
        if tss1==tss2;
            te(i,1)=q(1,j);
        end;
    end;
end;



logPro2=-log(normpdf(tp,te,(te.*wp)));
E2=sum(logPro2); 

E=E1+E2;


function q=estTe(a1,ts);

ws=a1(1);
wp=a1(2);

q=ts*((-1+sqrt(1+4*(ws^2)))/(2*(ws^2)));


 
