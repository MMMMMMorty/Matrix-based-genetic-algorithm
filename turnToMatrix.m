function [outputArg1] = turnToMatrix(single_new_pop, p_end)
%TURNTOMATRIX �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
outputArg1 = zeros(1, p_end + 1);
%same_col_list = same_col;
[~, b] = size(single_new_pop);
    for i = 1 : b
        %�õ�����
        num = single_new_pop(1, i);
        outputArg1(1, num+1) = 1;
        %�жϲ�Ϊ������ں��棬���Ϊ���򴴽�һ���µ�
        %if any(same_col_list(num+1,:)) == 1
        %    same_col_list{num+1} = [same_col_list{num+1,:}, z];
        %else
        %    same_col_list{num+1} = z;
        %end
    end
end

