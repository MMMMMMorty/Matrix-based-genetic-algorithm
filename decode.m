function [x,y] = decode(node,n)
%DECODE 此处显示有关此函数的摘要
% 点所在列（从左到右编号1.2.3...）横坐标
x = mod(node, n) + 1; 
% 点所在行（从上到下编号行1.2.3...）纵坐标
y = fix(node / n) + 1;
end

