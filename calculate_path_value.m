function [path_value, cor_path] = calculate_path_value(map, pop)
%PATH_VALUE 此处显示有关此函数的摘要
% n是多少个解，m是多少行
[n, m] = size(pop);
distance = 0;
path_value = zeros(1, n);
cor_path = {};
%n_invaild = 0;
%解两层迷宫问题
    %1-2计算一次最短距离，2-3计算一次....,，n-1 - n计算一次，一共n-1次，再相加
    for i = 1 : n
        %记录一行的两两之间的
        %path_values = zeros(1, m-1);
        paths = [pop(i, 1)];
        for j = 1: m - 1
            %有可能没有路，那么大小将会是无限大，后面再处理，删除或者去掉
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

