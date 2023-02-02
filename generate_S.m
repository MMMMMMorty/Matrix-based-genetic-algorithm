function [S_retain,S_discard] = generate_S(n_chrom, path_value, p_select)
%GENERATE_S 此处显示有关此函数的摘要
%   此处显示详细说明
S_retain = zeros(n_chrom, n_chrom);
S_discard = zeros(n_chrom,n_chrom);
n_retain = fix(n_chrom * p_select);
%适应度不可能为整数
fitness = 1./ path_value;

probs = (fitness) ./ sum((fitness));
idexs = (1 : n_chrom);
retain_idx = randsrc(1,n_retain,[idexs; probs]);

for i = 1: n_retain
    v = retain_idx(1, i);
    S_retain(i, v) = 1;
end
n_discard = n_chrom - n_retain;
else_idx = randsrc(1,n_discard * 2,[idexs; probs]);

for i = 1: n_discard
    v = else_idx(1, i);
    S_retain(i + n_retain, v) = 1;
end

for i = 1: n_discard
    v = else_idx(1, i + n_discard);
    S_discard(i + n_retain, v) = 1;
end

end