% 基于遗传算法的栅格法机器人路径规划
clc;
clear;
% 输入数据,即栅格地图
G=  [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
     0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 1 1 1 0 1 0 1 1 0 0 0 0 0 0;
     0 1 1 1 0 0 0 0 0 0 1 0 1 1 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 1 1 0 1 1 1 1 0 0 0 0 0 0;
     0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0;
     0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0;
     0 0 1 1 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 0;
     0 0 1 1 0 0 1 1 1 0 1 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 1 1 1 0 1 0 0 0 0 0 0 1 1 0; 
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 1 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
%G = [0 0 0 1 0;
%     0 0 0 0 0;
%     0 0 1 0 0;
%     1 0 1 0 0;
%     0 0 0 0 0;];
p_start = 0;   % 起始序号
p_end = 399;   % 终止序号
NP = 200;      % 种群数量
max_gen = 1;  % 最大进化代数
ps = 0.1;      % 选择概率
pc = 0.8;      % 交叉概率
pm = 0.2;      % 变异概率
%init_path = [];
z = 1;  
new_pop1 = {}; % 元包类型路径
new_population = {};
single_new_population = zeros(1, p_end + 1);
[y, x] = size(G);
% 起点所在列（从左到右编号1.2.3...）
xs = mod(p_start, x) + 1; 
% 起点所在行（从上到下编号行1.2.3...）
ys = fix(p_start / x) + 1;
% 终点所在列、行
xe = mod(p_end, x) + 1;
ye = fix(p_end / x) + 1;
% 种群初始化step1，必经节点,从起始点所在行开始往上，在每行中挑选一个自由栅格，构成必经节点
pass_num = ye - ys + 1;
pop = zeros(NP, pass_num);

%[path, distance] = a_star(logical(NG), ones(size(NG)), 0, 399)
%[path, distance] = BFSTraversal(0,399, G)
for i = 1 : NP
    %%初始化一条可行路径，将除去起点和终点，每一行找一个可行点，并且将其链接为无间断路径，最终将其对应的数字变为1.
    pop(i, 1) = p_start;
    j = 1;
    % 除去起点和终点
    for yk = ys+1 : ye-1
        j = j + 1;
        % 每一行的可行点
        can = []; 
        for xk = 1 : x
            % 栅格序号
            no = (xk - 1) + (yk - 1) * x;
            if G(yk, xk) == 0
                % 把点加入can矩阵中
                can = [can no];
            end
        end
        can_num = length(can);
        % 产生随机整数
        index = randi(can_num);
        % 为每一行加一个可行点
        pop(i, j) = can(index);
    end        
    pop(i, end) = p_end;
    %pop
end

%[result, dis]=BFSTraversal(31, 40, G);
mean_path_value = zeros(1, max_gen);
min_path_value = zeros(1, max_gen);
cor_paths = {};
% 循环迭代操作
for i = 1 : max_gen
    % 计算适应度值  
    [path_value, cor_path] = calculate_path_value(G, pop);
    % 计算路径长度
    %path_value = matrixToPath(new_population, p_start, p_end, x,new_pop1);
    %path_value = cal_path_value(new_pop1, x);
    % 计算路径平滑度
    %mean_path_value(1, i) = sum(path_value)/(NP - n_invalid);
    mean_path_value(1, i) = mean(path_value(isfinite(path_value)));
    min_path = min(path_value(path_value~=0));
    m = find(path_value == min_path);
    min_path_value(1, i) = path_value(1, m(1, 1));
    cor_paths{i} = cor_path{m};
    % 选择操作
    [S_retain,S_discard] = generate_S(NP, path_value, ps);
    % 交叉操作
    [C, C_] = generate_C(ps,pc, NP, y);
    % 变异操作
    [V] = generate_V(pm, NP, y);
    % 更新种群
    pop = fix(S_retain*pop.*C + S_discard*pop.*C_ + V);
    pop(:,1) = p_start;
    pop(:,end) = p_end;
  end

%变成连续的路径

% 画每次迭代平均路径长度和最优路径长度图
figure(1)
plot(1:max_gen,  mean_path_value, 'r')
hold on;
plot(1:max_gen, min_path_value, 'b')
legend('平均路径长度', '最优路径长度');
min_path_value(1, end);
% 在地图上画路径
min_path = min(min_path_value(min_path_value>0))
min_index = find(min_path_value == min_path);
min_path = cor_paths{min_index(1, 1)}

figure(2)
hold on;
title('遗传算法机器人运动轨迹'); 
xlabel('坐标x'); 
ylabel('坐标y');
DrawMap(G);
[~, min_path_num] = size(min_path);
for i = 1:min_path_num
    % 路径点所在列（从左到右编号1.2.3...）
    %x_min_path(1, i) = mod(min_path(1, i), x) + 1; 
    % 路径点所在行（从上到下编号行1.2.3...）
    %y_min_path(1, i) = fix(min_path(1, i) / x) + 1;
    [y_min_path(1, i),x_min_path(1, i)] = decode(min_path(1,i), x);
end
hold on;
plot(x_min_path, y_min_path, 'r')


