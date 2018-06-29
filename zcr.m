clear all
clf
close all
[x fs]=audioread('D:\experiment\soundclassify\training\glass\2.wav'); %读取音频信号 x为信号样本，fs信号采样频率
fs
%判断并合并单双声道%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if size(x,2)>1
    x=(x(:,1)+x(:,2))/2;
end
frame=enframe(x,1024,512);%分帧  帧长1024 帧移512
zcr_sum=0;%过零点数
for i=1:size(frame,1)
    y=frame(i,:);%每帧数据
    s=y'.*hamming(1024);%加汉明窗窗
    %%%%%%%%%%%%%%%%%%%%%计算过零率%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for j=1:size(s,1)-1 
        zcr_sum=zcr_sum+abs(sgn(s(j+1))-sgn(s(j))); 
    end
    zcr_sum=zcr_sum/2;
    m(:,i) = zcr_sum;%将每帧的过零率保存到变量m中
end
size(m)
m=[m,zeros(1,80-length(m))]
size(m)
figure(1)
plot(m)
xlabel('帧数/帧');
ylabel('过零数');
title('短时平均过零率')