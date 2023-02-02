function [node] = encode(x_now, y_now, x)
%ENCODE 此处显示有关此函数的摘要
%   此处显示详细说明
%node = sub2ind([20, 20],x_now,y_now) -1;
node = (y_now -1) * x + x_now -1;
end

