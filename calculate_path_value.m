function [path_value, cor_path] = calculate_path_value(map, pop)
%PATH_VALUE �˴���ʾ�йش˺�����ժҪ
% n�Ƕ��ٸ��⣬m�Ƕ�����
[n, m] = size(pop);
distance = 0;
path_value = zeros(1, n);
cor_path = {};
%n_invaild = 0;
%�������Թ�����
    %1-2����һ����̾��룬2-3����һ��....,��n-1 - n����һ�Σ�һ��n-1�Σ������
    for i = 1 : n
        %��¼һ�е�����֮���
        %path_values = zeros(1, m-1);
        paths = [pop(i, 1)];
        for j = 1: m - 1
            %�п���û��·����ô��С���������޴󣬺����ٴ���ɾ������ȥ��
            %[path, distance] = BFSTraversal(pop(i, j), pop(i, j + 1), map);
            %if j>=1 && j <= m -3
            %    map = G(j : j + 3,:);
            %elseif j + 3 > m
            %    map = G(j : end, :)
            %end
             %sizeMap = size(map);
            %[path, distance] = a_star(map, ones(sizeMap), pop(i, j) -(j -1) * sizeMap(2), pop(i, j + 1) -(j -1) * sizeMap(2));
             %path = path + (j -1) * sizeMap(2);
            [path, distance] = Copy_of_a_star(map, ones(size(map)), pop(i, j), pop(i, j + 1));
            %path_values(1,j) = distance;
            if distance == Inf
              break
            end
            [Lia,Locb] = ismember(path,paths);
            if max(Lia) ~= 0
               %index = find(Lia == 1);
               %path_index = Locb(1, index(1,1));
               %paths = [paths(1, 1:path_index - 1), path(1, index :end)]
               path_index = min(Locb(Locb > 0));
               index = find(path == paths(1, path_index));
               paths = [paths(1, 1:path_index - 1), path(1, index :end)];
               % test: a = unique(paths,'stable')
            else    
               paths = [paths path];
            end
        end
        %path_value(1, i) = sum(path_values);
        if distance == Inf
            path_value(1, i) = Inf;
        else
            %[unique_path, ia, ic] = unique(paths,'stable');
            [~, path_value(1, i)] = size(paths);
            path_value(1, i) = path_value(1, i) - 1;
        end
        cor_path{i} = paths;
        %if sum(path_values) == Inf
        %    path_value(1, i) = 0;
        %    n_invaild = n_invaild + 1;
        %    cor_path{i} = [];
        %else
        %    path_value(1, i) = sum(path_values);
        %    cor_path{i} = paths;
        %end
    end
end

