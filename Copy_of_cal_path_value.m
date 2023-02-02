% 计算路径长度函数,仅当上下左右为1，其余为0
function [path_value] = Copy_of_cal_path_value(pop, p_start, p_end, x)



[n, ~] = size(pop);
path = [p_start];
path_value = zeros(1, n);
paths = [];
for i = 1 : n
    single_pop = pop{i};
    if single_pop(1, p_start + 1) == 0
        break
    else
        %check 上下左右，是否超出界限
        %找出一条路
        %循环
        while p_start < p_end
            if p_start + 1 < p_end + 2 && single_pop(1, p_start + 1) == 1 && ismember(p_start + 1, path) == 0%走右边
                path = [path, p_start + 1];
                p_start = p_start + 1;
            elseif p_start + x <p_end +2 && single_pop(1, p_start + x ) == 1 && ismember(p_start + x, path) == 0%走上边
                path = [path, p_start + x];
                p_start = p_start + x;
            elseif p_start + x + 1 < p_end + 2 && single_pop(1, p_start + x + 1 ) == 1 && ismember( p_start + x + 1, path) == 0 %走上右边
                path = [path, p_start + x + 1];
                p_start = p_start + x + 1;
            elseif p_start + x - 1 < p_end + 2 && single_pop(1, p_start + x - 1 ) == 1 && ismember( p_start + x - 1, path) == 0 %走上左边
                path = [path, p_start + x - 1];
                p_start = p_start + x - 1;
            elseif p_start - 1> 0 && single_pop(1, p_start -1  ) == 1 && ismember(p_start - 1, path) == 0%走左边
                path = [path, p_start - 1];
                p_start = p_start - 1;
            elseif p_start - x> 0 && single_pop(1, p_start -x ) == 1 && ismember(p_start - x, path) == 0%走下边
                path = [path, p_start - x];
                p_start = p_start - x;
            elseif p_start - x + 1 > 0 && single_pop(1, p_start - x + 1 ) == 1 && ismember(p_start -x + 1, path) == 0%走下右边
                path = [path, p_start - x + 1];
                p_start = p_start - x + 1;
            elseif p_start - x - 1 > 0 && single_pop(1, p_start - x - 1 ) == 1 && ismember(p_start -x -1, path) == 0%走下左边
                path = [path, p_start - x - 1];
                p_start = p_start - x - 1;
            else
                continue
            end
        end
        paths(i, 1) = path;
    end
    disp(paths)
    %single_pop = pop{i, 1};
    %[~, m] = size(single_pop);
    %for j = 1 : m - 1
        % 点i所在列（从左到右编号1.2.3...）
       % x_now = mod(single_pop(1, j), x) + 1; 
        % 点i所在行（从上到下编号行1.2.3...）
        %y_now = fix(single_pop(1, j) / x) + 1;
        % 点i+1所在列、行
        %x_next = mod(single_pop(1, j + 1), x) + 1;
        %y_next = fix(single_pop(1, j + 1) / x) + 1;
       % if abs(x_now - x_next) + abs(y_now - y_next) == 1
         %   path_value(1, i) = path_value(1, i) + 1;
       % else
       %     path_value(1, i) = path_value(1, i) + sqrt(2);
       % end
    %end
end
