function k_merge = data_merge(data, merge)

k_merge(:, :, 1) = merge;

for col = 1 : size(data, 2)
    if sum(k_merge==col)==0
        data(:, col) = zeros(size(data, 1), 1);
    end
end

data_new = data;

for row = 1 : size(k_merge, 1)
    list_row = k_merge(row, :, 1);
    list_row(list_row==0)=[];

    if size(list_row, 2)>1
        for jj = 2 : size(list_row, 2)
            data_new(:, list_row(1)) = data_new(:, list_row(1)) + data_new(:, list_row(jj));
            data_new(:, list_row(jj)) = zeros(size(data_new, 1), 1);
        end
    end

end

data_new = data_new > 0;
data_new(:, ~any(data_new, 1)) = [];

adj = data_adj(data_new);
m = min(adj(adj>0));
kk = 1;
list = [];

for ii = 1 : size(adj, 1)
    for jj = (ii+1) : size(adj, 2)
        if adj(ii, jj) == m
            list(kk, :) = [ii jj];
            kk = kk + 1;
        end
    end
end

for ll = 1 : size(list, 1)
    row1 = list(ll, 1);
    row2 = list(ll, 2);

    list_row1 = k_merge(row1, :, 1);
    list_row1(list_row1==0) = [];
    list_row2 = k_merge(row2, :, 1);
    list_row2(list_row2==0) = [];

    k_merge(:, :, (ll+1)) = k_merge(:, :, 1);
    k_merge(row2, :, (ll+1)) = zeros(size(k_merge(row2, :, (ll+1))));

    merge = [];
    for m = 1 : size(list_row1, 2) + size(list_row2, 2)
        if m <= size(list_row1, 2)
            merge(m) = list_row1(m);
        else
            merge(m) = list_row2(m-size(list_row1, 2));
        end
    end

    for n = 1 : size(merge, 2)
        k_merge(row1, n, (ll+1)) = merge(n);
    end
end

end