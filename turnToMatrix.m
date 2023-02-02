function [outputArg1] = turnToMatrix(single_new_pop, p_end)
%TURNTOMATRIX 此处显示有关此函数的摘要
%   此处显示详细说明
outputArg1 = zeros(1, p_end + 1);
%same_col_list = same_col;
[~, b] = size(single_new_pop);
    for i = 1 : b
        %得到列数
        num = single_new_pop(1, i);
        outputArg1(1, num+1) = 1;
        %判断不为空则加在后面，如果为空则创建一个新的
        %if any(same_col_list(num+1,:)) == 1
        %    same_col_list{num+1} = [same_col_list{num+1,:}, z];
        %else
        %    same_col_list{num+1} = z;
        %end
    end
end

