function en = adj_enum2(adj)

n = size(adj, 1);
m = 1;
en = zeros(n*n, 1);

for ii = 1 : n
    for jj = (ii+1) : n
        count = 0;
        
        if m > 1
            for kk = 1 : (m - 1)
                if adj(ii, jj) == en(kk)
                    count = count + 1;
                end
            end
        end
        
        if count == 0
            en(m) = adj(ii, jj);
            m = m + 1;
        end
    end
end

en(en==0) = [];
en = sort(en);

v = zeros(size(en));
for p = 1 : size(en, 1)
    v(p) = sum(adj(:)==en(p))/2;
end

A = [];
A(1:size(en, 1), 1) = en;
A(:, 2) = v;
A(:, 3) = en .* v;
A = sortrows(A,[3 1 2]);

en = A(:, 1);

end