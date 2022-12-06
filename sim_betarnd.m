% 假设X服从beta分布，现使用均匀分布映射再与matlab内置函数比较

clc;
clear;
close all;

X=betarnd(1,1,1,1e4);
figure;histogram(X);