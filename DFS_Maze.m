function DFS_Maze(maze)
% 本函数用深度优先遍历（回溯法）来求解迷宫的所有路径
% maze:是迷宫矩阵，其中0表示可以去走的路
%? ?? ?? ?? ?? ?? ?? ?1表示障碍
%? ?? ?? ?? ?? ?? ?? ?2表示入口
%? ?? ?? ?? ?? ?? ?? ?3表示出径
%? ?? ?? ?? ?? ?? ?? ?5表示路径
%? ?? ?? ?? ? 0 2 0 0 1
%? ?? ?? ?? ? 0 1 1 0 1
%? ?? ?? ?? ? 0 1 3 0 1
%? ?? ?? ?? ? 0 1 0 0 1

% copyright: qbb 2013-3-12
if nargin == 0
    maze=  [0 2 0 0 1;
         0 1 1 0 1;
         0 1 0 0 1;
         0 1 3 0 1];
end
% 定义四个方向
directions = kron(eye(2),[-1,1]);
disp(directions);
% 路径个数
sol = 0;
[I,J] = find(maze == 2);% 找到起点
search(I,J);
disp(sol);
    % 该函数判断该点是否可以经过
    function z = cango(x,y) %#ok<*BADCH>
    % 用try来判断边界
        z = true;
            try
                if ismember(maze(x,y),[1,2,5])% 路障或者已经走过
                    z = false;
                end
            catch
                    z = false; % 边界
            end
    end
    function search(x,y)
        if maze(x,y) == 3 % 找到出口
            disp(maze);% 打印路径
            sol = sol + 1;% 解的个数增加
            return% 返回
        end
    % 搜索4个方向
        for i = 1 : 4
            if cango(x + directions(1,i),y + directions(2,i)) % 如果可以走
                if maze(x + directions(1,i),y + directions(2,i)) ~= 3
                    maze(x + directions(1,i),y + directions(2,i)) = 5;% 记录下来
                end
                search(x + directions(1,i),y + directions(2,i)); % 继续寻找下一个点
                if maze(x + directions(1,i),y + directions(2,i)) ~= 3
                    maze(x + directions(1,i),y + directions(2,i)) = 0; % 回到该节点，继续寻找下一个方向
                end
            end
        end
    end
end