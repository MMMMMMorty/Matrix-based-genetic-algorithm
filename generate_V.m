function [V] = generate_V(pm, n_chrom, n_gene)
%���ɱ������.
%Returns: np.array: shapeΪ(n_chrom, n_gene).
probs = [1-pm, pm];
V = randsrc(n_chrom, n_gene,[[0, 1]; probs]);
V = V .* normrnd(0,1,n_chrom,n_gene);
%ʡ���˸����͵�״̬
end