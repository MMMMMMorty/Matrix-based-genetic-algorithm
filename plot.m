function [] = plot()
%PLOT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    syms x y
    F = @(x, y) 2*(1-x)^2*exp(-(x^2)-(y+1)^2)-10*(x/5 - x^2 - y^7)*exp(-x^2-y^2)-1/5^exp(-(x+1)^2 - y^2);
    dFdx = diff(F,x,1)
    dFdy = diff(F,y,1)
    fsurf(F,[-5 5 -5 5])
    a = (4-(-4))/2^(40/2)
end

