% �����Ŵ��㷨��դ�񷨻�����·���滮
clc;
clear;
% ��������,��դ���ͼ
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
p_start = 0;   % ��ʼ���
p_end = 399;   % ��ֹ���
NP = 200;      % ��Ⱥ����
max_gen = 1;  % ����������
ps = 0.1;      % ѡ�����
pc = 0.8;      % �������
pm = 0.2;      % �������
%init_path = [];
z = 1;  
new_pop1 = {}; % Ԫ������·��
new_population = {};
single_new_population = zeros(1, p_end + 1);
[y, x] = size(G);
% ��������У������ұ��1.2.3...��
xs = mod(p_start, x) + 1; 
% ��������У����ϵ��±����1.2.3...��
ys = fix(p_start / x) + 1;
% �յ������С���
xe = mod(p_end, x) + 1;
ye = fix(p_end / x) + 1;
% ��Ⱥ��ʼ��step1���ؾ��ڵ�,����ʼ�������п�ʼ���ϣ���ÿ������ѡһ������դ�񣬹��ɱؾ��ڵ�
pass_num = ye - ys + 1;
pop = zeros(NP, pass_num);

%[path, distance] = a_star(logical(NG), ones(size(NG)), 0, 399)
%[path, distance] = BFSTraversal(0,399, G)
for i = 1 : NP
    %%��ʼ��һ������·��������ȥ�����յ㣬ÿһ����һ�����е㣬���ҽ�������Ϊ�޼��·�������ս����Ӧ�����ֱ�Ϊ1.
    pop(i, 1) = p_start;
    j = 1;
    % ��ȥ�����յ�
    for yk = ys+1 : ye-1
        j = j + 1;
        % ÿһ�еĿ��е�
        can = []; 
        for xk = 1 : x
            % դ�����
            no = (xk - 1) + (yk - 1) * x;
            if G(yk, xk) == 0
                % �ѵ����can������
                can = [can no];
            end
        end
        can_num = length(can);
        % �����������
        index = randi(can_num);
        % Ϊÿһ�м�һ�����е�
        pop(i, j) = can(index);
    end        
    pop(i, end) = p_end;
    %pop
end

%[result, dis]=BFSTraversal(31, 40, G);
mean_path_value = zeros(1, max_gen);
min_path_value = zeros(1, max_gen);
cor_paths = {};
% ѭ����������
for i = 1 : max_gen
    % ������Ӧ��ֵ  
    [path_value, cor_path] = calculate_path_value(G, pop);
    % ����·������
    %path_value = matrixToPath(new_population, p_start, p_end, x,new_pop1);
    %path_value = cal_path_value(new_pop1, x);
    % ����·��ƽ����
    %mean_path_value(1, i) = sum(path_value)/(NP - n_invalid);
    mean_path_value(1, i) = mean(path_value(isfinite(path_value)));
    min_path = min(path_value(path_value~=0));
    m = find(path_value == min_path);
    min_path_value(1, i) = path_value(1, m(1, 1));
    cor_paths{i} = cor_path{m};
    % ѡ�����
    [S_retain,S_discard] = generate_S(NP, path_value, ps);
    % �������
    [C, C_] = generate_C(ps,pc, NP, y);
    % �������
    [V] = generate_V(pm, NP, y);
    % ������Ⱥ
    pop = fix(S_retain*pop.*C + S_discard*pop.*C_ + V);
    pop(:,1) = p_start;
    pop(:,end) = p_end;
  end

%���������·��

% ��ÿ�ε���ƽ��·�����Ⱥ�����·������ͼ
figure(1)
plot(1:max_gen,  mean_path_value, 'r')
hold on;
plot(1:max_gen, min_path_value, 'b')
legend('ƽ��·������', '����·������');
min_path_value(1, end);
% �ڵ�ͼ�ϻ�·��
min_path = min(min_path_value(min_path_value>0))
min_index = find(min_path_value == min_path);
min_path = cor_paths{min_index(1, 1)}

figure(2)
hold on;
title('�Ŵ��㷨�������˶��켣'); 
xlabel('����x'); 
ylabel('����y');
DrawMap(G);
[~, min_path_num] = size(min_path);
for i = 1:min_path_num
    % ·���������У������ұ��1.2.3...��
    %x_min_path(1, i) = mod(min_path(1, i), x) + 1; 
    % ·���������У����ϵ��±����1.2.3...��
    %y_min_path(1, i) = fix(min_path(1, i) / x) + 1;
    [y_min_path(1, i),x_min_path(1, i)] = decode(min_path(1,i), x);
end
hold on;
plot(x_min_path, y_min_path, 'r')


