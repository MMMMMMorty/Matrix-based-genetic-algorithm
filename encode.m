function [node] = encode(x_now, y_now, x)
%ENCODE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%node = sub2ind([20, 20],x_now,y_now) -1;
node = (y_now -1) * x + x_now -1;
end

