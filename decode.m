function [x,y] = decode(node,n)
%DECODE �˴���ʾ�йش˺�����ժҪ
% �������У������ұ��1.2.3...��������
x = mod(node, n) + 1; 
% �������У����ϵ��±����1.2.3...��������
y = fix(node / n) + 1;
end

