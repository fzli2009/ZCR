clear all
clf
close all
[x fs]=audioread('D:\experiment\soundclassify\training\glass\2.wav'); %��ȡ��Ƶ�ź� xΪ�ź�������fs�źŲ���Ƶ��
fs
%�жϲ��ϲ���˫����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if size(x,2)>1
    x=(x(:,1)+x(:,2))/2;
end
frame=enframe(x,1024,512);%��֡  ֡��1024 ֡��512
zcr_sum=0;%�������
for i=1:size(frame,1)
    y=frame(i,:);%ÿ֡����
    s=y'.*hamming(1024);%�Ӻ�������
    %%%%%%%%%%%%%%%%%%%%%���������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for j=1:size(s,1)-1 
        zcr_sum=zcr_sum+abs(sgn(s(j+1))-sgn(s(j))); 
    end
    zcr_sum=zcr_sum/2;
    m(:,i) = zcr_sum;%��ÿ֡�Ĺ����ʱ��浽����m��
end
size(m)
m=[m,zeros(1,80-length(m))]
size(m)
figure(1)
plot(m)
xlabel('֡��/֡');
ylabel('������');
title('��ʱƽ��������')