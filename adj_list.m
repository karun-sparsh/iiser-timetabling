function list = adj_list(adj)

list = [];

for ii = 1 : size(adj, 1)
    kk = 1;
    for jj = 1 : size(adj, 2)
        if adj(ii, jj) > 0
            list(ii, kk) = jj;
            kk = kk + 1;
        end
    end
end

end