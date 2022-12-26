function dtf = colors_adj_dtf(color, adj)

dtf = 0;

for row = 1 : size(color, 1)

    list = color(row, :);
    list(list==0)=[];

    if size(list, 2) > 1
        for ii = 1 : (size(list, 2)-1)
            for jj = (ii+1) : size(list, 2)
                dtf = dtf + adj(list(ii), list(jj));
            end
        end
    end

end

end