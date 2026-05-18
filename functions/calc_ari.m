function ari = calc_ari(l1, l2)
% Adjusted Rand Index (ARI)

C = confusionmat(l1, l2);

n = sum(C(:));

sum_ij = sum(sum(C .* (C - 1) / 2));
sum_i  = sum(sum(C,2) .* (sum(C,2) - 1) / 2);
sum_j  = sum(sum(C,1) .* (sum(C,1) - 1) / 2);

n2 = n * (n - 1) / 2;

exp_idx = (sum_i * sum_j) / n2;

ari = (sum_ij - exp_idx) / ...
      ((sum_i + sum_j)/2 - exp_idx);
end
