clc;
clear;
close all;

% load('band_pass');
% [num,den]=sos2tf(SOS,G);

load('fir');

fs=100;
% snr=-20;
T=15;
t=0:1/fs:T-1/fs;
len=length(t);
zs1=4*exp(1j*2*pi*(0.8+35*t-0.6*t.^2+0.1/3*t.^3));
zs2=4*exp(1j*2*pi*(4+50*t+2.5*t.^2-1/15*t.^3));
zs=zs1+zs2;
ff=(0:len-1)*fs/len;
% zn=awgn(zs1+zs2,snr,'measured');

[s,f,t1]=spectrogram(zs1+zs2,5*fs,round((5-0.1)*fs),2*fs,fs);
figure;imagesc(t1,f,abs(s));axis xy;

% 完全估准
zs_est1=zs.*exp(-1j*2*pi*(-0.6*t.^2+0.1/3*t.^3));
[s,f,t2]=spectrogram(zs_est1,5*fs,round((5-0.1)*fs),2*fs,fs);
figure;imagesc(t2,f,abs(s));axis xy;
% figure;plot(ff,abs(fft(zs_est1)).^4);
% figure;plot(ff,abs(fft(zs_est1)));

% % 偏差不大
% zs_est1=zs.*exp(-1j*2*pi*(-0.5*t.^2+0.15/3*t.^3));
% [s,f,t2]=spectrogram(zs_est1,5*fs,round((5-0.1)*fs),2*fs,fs);
% figure;imagesc(t2,f,abs(s));axis xy;
% figure;plot(ff,abs(fft(zs_est1)).^4);
% figure;plot(ff,abs(fft(zs_est1)));
% 
% % 偏差大
% zs_est1=zs.*exp(-1j*2*pi*(-1.5*t.^2+0.5/3*t.^3));
% [s,f,t2]=spectrogram(zs_est1,5*fs,round((5-0.1)*fs),2*fs,fs);
% figure;imagesc(t2,f,abs(s));axis xy;
% figure;plot(ff,abs(fft(zs_est1)).^4);
% figure;plot(ff,abs(fft(zs_est1)));

% 滤波
zs_est1_filter=filter(Num,1,zs_est1);
zs_est1_res=zs_est1_filter.*exp(1j*2*pi*(-0.6*t.^2+0.1/3*t.^3));
zs_est_remain=zs-zs_est1_res;

[s,f,t1]=spectrogram(zs_est1_res,5*fs,round((5-0.1)*fs),2*fs,fs);
figure;imagesc(t1,f,abs(s));axis xy;
[s,f,t1]=spectrogram(zs_est_remain,5*fs,round((5-0.1)*fs),2*fs,fs);
figure;imagesc(t1,f,abs(s));axis xy;
[s,f,t1]=spectrogram(zs1,5*fs,round((5-0.1)*fs),2*fs,fs);
figure;imagesc(t1,f,abs(s));axis xy;
[s,f,t1]=spectrogram(zs2,5*fs,round((5-0.1)*fs),2*fs,fs);
figure;imagesc(t1,f,abs(s));axis xy;
% zs_est2=zs.*exp(-1j*2*pi*(2.5*t.^2-1/15*t.^3));
% [s,f,t2]=spectrogram(zs_est2,5*fs,round((5-0.1)*fs),2*fs,fs);
% figure;imagesc(t2,f,abs(s));axis xy;
