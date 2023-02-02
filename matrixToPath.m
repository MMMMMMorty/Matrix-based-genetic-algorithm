% ����·�����Ⱥ���,������������Ϊ1������Ϊ0
function [path_value] = matrixToPath(pop, p_start, p_end, x,new_pop1)



[n, ~] = size(pop);
path = [p_start];
path_value = zeros(1, n);
paths = {};
    function [bool] = dowalk(p_start)
        if p_start == p_end 
            bool = 1;
        else
            if dowalk1(p_start) || dowalk2(p_start) || dowalk3(p_start) || dowalk4(p_start) || dowalk5(p_start) || dowalk6(p_start) || dowalk7(p_start) || dowalk8(p_start)
                bool = 1;
            else
                bool = 0;
            end
        end
    end
    function [bool] = dowalk1(p_start)
        if p_start + 1 < p_end + 2 && single_pop(1, p_start + 1) == 1 && ismember(p_start + 1, path) == 0%���ұ�
                path = [path, p_start + 1];
                p_start = p_start + 1;
                bool =  dowalk(p_start);
        else 
            bool = 0;
        end
    end
    function [bool] = dowalk2(p_start)
        if p_start + x <p_end +2 && single_pop(1, p_start + x ) == 1 && ismember(p_start + x, path) == 0%���ϱ�
                path = [path, p_start + x];
                p_start = p_start + x;
                bool =  dowalk(p_start);
        else 
            bool = 0;
        end
    end
    function [bool] = dowalk3(p_start)
        if p_start + x + 1 < p_end + 2 && single_pop(1, p_start + x + 1 ) == 1 && ismember( p_start + x + 1, path) == 0 %�����ұ�
                path = [path, p_start + x + 1];
                p_start = p_start + x + 1;
                bool =  dowalk(p_start);
        else 
            bool = 0;
        end
    end
    function [bool] = dowalk4(p_start)
        if p_start + x - 1 < p_end + 2 && single_pop(1, p_start + x - 1 ) == 1 && ismember( p_start + x - 1, path) == 0 %�������
                path = [path, p_start + x - 1];
                p_start = p_start + x - 1;
                bool =  dowalk(p_start);
        else 
            bool = 0;
        end
    end
    function [bool] = dowalk5(p_start)
        if p_start - 1> 0 && single_pop(1, p_start -1  ) == 1 && ismember(p_start - 1, path) == 0%�����
                path = [path, p_start - 1];
                p_start = p_start - 1;
                bool =  dowalk(p_start);
        else 
            bool = 0;
        end
    end
    function [bool] = dowalk6(p_start)
        if p_start - x> 0 && single_pop(1, p_start -x ) == 1 && ismember(p_start - x, path) == 0%���±�
                path = [path, p_start - x];
                p_start = p_start - x;
                bool =  dowalk(p_start);
        else 
            bool = 0;
        end
    end
    function [bool] = dowalk7(p_start)
        if p_start - x + 1 > 0 && single_pop(1, p_start - x + 1 ) == 1 && ismember(p_start -x + 1, path) == 0%�����ұ�
                path = [path, p_start - x + 1];
                p_start = p_start - x + 1;
                bool =  dowalk(p_start);
        else 
            bool = 0;
        end
    end
    function [bool] = dowalk8(p_start)
        if p_start - x - 1 > 0 && single_pop(1, p_start - x - 1 ) == 1 && ismember(p_start -x -1, path) == 0%�������
                path = [path, p_start - x - 1];
                p_start = p_start - x - 1;
                bool =  dowalk(p_start);
        else 
            bool = 0;
        end
    end
    for i = 1 : n
        single_pop = pop{i};
        if single_pop(1, p_start + 1) == 0
            break
        else
            %check �������ң��Ƿ񳬳�����
            %�ҳ�һ��·
            %ѭ��
            %�ĳ����Թ�
            status = dowalk(p_start);
            paths{i} = path;
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
end
