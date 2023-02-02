function [C, invert_C] = generate_C(ps,pc, n_chrom, n_gene)
%�������ڽ���ľ���
%Returns: np.array, np.array: �ֱ��Ӧ�����Ͷ���Ⱦɫ������ڽ���ľ���, shape��Ϊ(n_chrom, n_gene)
C = zeros(n_chrom, n_gene);
n_retain = fix(n_chrom * ps);
C(1:n_retain, :) = ones(n_retain, n_gene);
probs = [pc, 1-pc];
%C(n_retain + 1:end, :) = randsrc(n_chrom - n_retain, n_gene,[[0, 1]; probs]);
total = randsrc(n_chrom - n_retain, 1,[[0, 1]; probs]);
for i = 1:n_chrom - n_retain
    if total(i,1)==1
        %����ǰ��һ��
        rand_col = randi([1 n_gene],1,1);
        C(n_retain + i, rand_col(1, 1):end) = 1;
    end
end
invert_C = ones(n_chrom, n_gene) -C;
end