function comp = node_adj_comp(node, adj)

g = adj>0;
comp = g(:, node);

done = zeros(size(g, 1), 1);
done(node) = 1;

c = comp;
c(done==1) = 0;

while sum(c(:, 1)) > 0
    for ii = 1 : size(g, 1)
        if c(ii) == 1
            comp = (comp + g(:, ii))>0;
            done(ii) = 1;
        end
    end
    c = comp;
    c(done==1) = 0;
end

end