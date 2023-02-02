

function [path, distance] = BFSTraversal(startNode, endNode, Graph)
% �����������
% Graph ͼ��ͨ����
[m, n]=size(Graph);
%��¼�Ƿ񱻷���
move_x = [0 0 -1 1 1 -1 -1 1];
move_y = [1 -1 0 0 1 -1 1 -1];

nodelist=zeros(m,n);
queue=startNode;
[x_start, y_start] = decode(startNode, n);
x_now = x_start;
y_now = y_start;
[x_tar, y_tar] = decode(endNode, n);
nodelist(y_now, x_now)=1;
result= - ones(m,n);
result(y_now, x_now) = 0;
path = [];
distance = 0;
%dis = [];
reach = false;
while isempty(queue)==false
    %��ջ i�ǵ�ǰ��node
    i=queue(1);
    queue(1)=[];
    %�����ǰ������
    [x_now, y_now] = decode(i, n);
    if x_now == x_tar && y_now == y_tar
        reach = true;
        break
    end
    for j=1:8
        %�ӵ�ǰ����������
        next_x = x_now + move_x(1, j);
        next_y = y_now + move_y(1, j);
        %û�߹�����ͼ�в�Ϊ�ϰ��ģ��������
        if y_now >= 1&& x_now >=1 && next_x >= 1 && next_x <= n && next_y >= 1 && next_y <= m && nodelist( next_y, next_x) == 0 && Graph(next_y, next_x) == 0
            %��ǰ״̬��ջ
            node = encode(next_x, next_y, n);
            queue=[queue;node];
            nodelist(next_y, next_x)=1;
            result(next_y, next_x)=encode(x_now, y_now, n);
        end
    end
end
function print(x, y)
    if x == x_start && y == y_start
        return
    end
    %����ǰһ���ڵ�
    [x_last, y_last] = decode(result(y, x),n);
    print(x_last, y_last)
    %�����ǰ�ڵ�
    node = encode(x,y, n);
    %dis = [dis norm([x,y]-[x_last, y_last])];
    path = [path node];
end
if reach == true
    print(x_tar, y_tar)
    %distance = sum(dis);
    %���̾���
    %[~,distance] = size(path);
    %ɾ����������һ��
    %distance = distance - 1;
else
    path = [];
    distance = Inf;
end
end
