function colors = adj_colors(adj)

list = adj_list(adj);
g = adj>0;
d = sum(g(:,:));
[dd, vlist] = sort(-d);
clear dd;

colors = zeros(size(adj, 1), 1);

for ii = 1 : size(adj, 1)
    v = vlist(ii);
    if v <= size(list, 1)
        vneig = list(v, :);
        vneig(vneig==0) = [];
        cneig = unique(colors(vneig));  % colors on neighbors
    
        if isempty(cneig)
            mc = 0;
        else
            mc = cneig(length(cneig)); % max color seen on neighbors
        end
    
        avail = setdiff(1:mc,cneig); % colors available (if any)
    
        if isempty(avail)
            colors(v) = mc+1;
        else
            colors(v) = min(avail);
        end
    end
end

end