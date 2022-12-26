function adj = data_adj(data)

n = size(data, 2);
adj = zeros(n);

for ii = 1 : n
    for jj = (ii+1) : n
        adj(ii, jj) = sum(data(:, ii) .* data(:, jj));
        adj(jj, ii) = adj(ii, jj);
    end
end

end