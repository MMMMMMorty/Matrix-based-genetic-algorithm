function [V] = generate_V(pm, n_chrom, n_gene)
%生成变异矩阵.
%Returns: np.array: shape为(n_chrom, n_gene).
probs = [1-pm, pm];
V = randsrc(n_chrom, n_gene,[[0, 1]; probs]);
V = V .* normrnd(0,1,n_chrom,n_gene);
%省略了浮点型的状态
end