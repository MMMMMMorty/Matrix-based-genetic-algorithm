% ����·�����Ⱥ���,������������Ϊ1������Ϊ0
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
        %check �������ң��Ƿ񳬳�����
        %�ҳ�һ��·
        %ѭ��
        while p_start < p_end
            if p_start + 1 < p_end + 2 && single_pop(1, p_start + 1) == 1 && ismember(p_start + 1, path) == 0%���ұ�
                path = [path, p_start + 1];
                p_start = p_start + 1;
            elseif p_start + x <p_end +2 && single_pop(1, p_start + x ) == 1 && ismember(p_start + x, path) == 0%���ϱ�
                path = [path, p_start + x];
                p_start = p_start + x;
            elseif p_start + x + 1 < p_end + 2 && single_pop(1, p_start + x + 1 ) == 1 && ismember( p_start + x + 1, path) == 0 %�����ұ�
                path = [path, p_start + x + 1];
                p_start = p_start + x + 1;
            elseif p_start + x - 1 < p_end + 2 && single_pop(1, p_start + x - 1 ) == 1 && ismember( p_start + x - 1, path) == 0 %�������
                path = [path, p_start + x - 1];
                p_start = p_start + x - 1;
            elseif p_start - 1> 0 && single_pop(1, p_start -1  ) == 1 && ismember(p_start - 1, path) == 0%�����
                path = [path, p_start - 1];
                p_start = p_start - 1;
            elseif p_start - x> 0 && single_pop(1, p_start -x ) == 1 && ismember(p_start - x, path) == 0%���±�
                path = [path, p_start - x];
                p_start = p_start - x;
            elseif p_start - x + 1 > 0 && single_pop(1, p_start - x + 1 ) == 1 && ismember(p_start -x + 1, path) == 0%�����ұ�
                path = [path, p_start - x + 1];
                p_start = p_start - x + 1;
            elseif p_start - x - 1 > 0 && single_pop(1, p_start - x - 1 ) == 1 && ismember(p_start -x -1, path) == 0%�������
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
        % ��i�����У������ұ��1.2.3...��
       % x_now = mod(single_pop(1, j), x) + 1; 
        % ��i�����У����ϵ��±����1.2.3...��
        %y_now = fix(single_pop(1, j) / x) + 1;
        % ��i+1�����С���
        %x_next = mod(single_pop(1, j + 1), x) + 1;
        %y_next = fix(single_pop(1, j + 1) / x) + 1;
       % if abs(x_now - x_next) + abs(y_now - y_next) == 1
         %   path_value(1, i) = path_value(1, i) + 1;
       % else
       %     path_value(1, i) = path_value(1, i) + sqrt(2);
       % end
    %end
end
