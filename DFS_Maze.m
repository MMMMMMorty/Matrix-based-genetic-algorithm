function DFS_Maze(maze)
% ��������������ȱ��������ݷ���������Թ�������·��
% maze:���Թ���������0��ʾ����ȥ�ߵ�·
%? ?? ?? ?? ?? ?? ?? ?1��ʾ�ϰ�
%? ?? ?? ?? ?? ?? ?? ?2��ʾ���
%? ?? ?? ?? ?? ?? ?? ?3��ʾ����
%? ?? ?? ?? ?? ?? ?? ?5��ʾ·��
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
% �����ĸ�����
directions = kron(eye(2),[-1,1]);
disp(directions);
% ·������
sol = 0;
[I,J] = find(maze == 2);% �ҵ����
search(I,J);
disp(sol);
    % �ú����жϸõ��Ƿ���Ծ���
    function z = cango(x,y) %#ok<*BADCH>
    % ��try���жϱ߽�
        z = true;
            try
                if ismember(maze(x,y),[1,2,5])% ·�ϻ����Ѿ��߹�
                    z = false;
                end
            catch
                    z = false; % �߽�
            end
    end
    function search(x,y)
        if maze(x,y) == 3 % �ҵ�����
            disp(maze);% ��ӡ·��
            sol = sol + 1;% ��ĸ�������
            return% ����
        end
    % ����4������
        for i = 1 : 4
            if cango(x + directions(1,i),y + directions(2,i)) % ���������
                if maze(x + directions(1,i),y + directions(2,i)) ~= 3
                    maze(x + directions(1,i),y + directions(2,i)) = 5;% ��¼����
                end
                search(x + directions(1,i),y + directions(2,i)); % ����Ѱ����һ����
                if maze(x + directions(1,i),y + directions(2,i)) ~= 3
                    maze(x + directions(1,i),y + directions(2,i)) = 0; % �ص��ýڵ㣬����Ѱ����һ������
                end
            end
        end
    end
end