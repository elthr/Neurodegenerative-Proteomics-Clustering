function acc = cluster_agreement(a, b)
% Computes best label-matching accuracy between two clusterings

k = max(max(a), max(b));

perms_b = perms(1:k);

best_acc = 0;

for i = 1:size(perms_b,1)

    b_perm = zeros(size(b));

    for j = 1:k
        b_perm(b == j) = perms_b(i,j);
    end

    best_acc = max(best_acc, mean(a == b_perm));

end

acc = best_acc;
end
