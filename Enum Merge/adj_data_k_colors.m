function colors = adj_data_k_colors(adj, data, k)

enum = adj_enum(adj);
colors = [];

while sum(adj(:)) > 0

    adj_ii = adj > 0;

    max_deg = 0;
    jj = 1;
    while max_deg==0
        if sum(adj_ii(jj, :)) == max(sum(adj_ii(:,:)))
            max_deg = jj;
        end
        jj = jj + 1;
    end

    comp = node_adj_comp(max_deg, adj_ii);
    adj_ii(comp==0, :)=0;                   adj_ii(:, comp==0)=0;
    colors_ii = adj_colors(adj_ii);         colors_ii(comp==0) = 0;

    ii = 1;
    while max(colors_ii) > k
        adj_ii = adj > enum(ii);

        max_deg = 0;
        jj = 1;
        while max_deg==0
            if sum(adj_ii(jj, :)) == max(sum(adj_ii(:,:)))
                max_deg = jj;
            end
            jj = jj + 1;
        end
    
        comp = node_adj_comp(max_deg, adj_ii);
        adj_ii(comp==0, :)=0;                   adj_ii(:, comp==0)=0;
        colors_ii = adj_colors(adj_ii);         colors_ii(comp==0) = 0;
        ii = ii + 1;
    end
    
    k_merge = colors_ii;
    binary = list_zerone(k_merge)';
    k_merge = adj_list(binary);
    if ~isempty(k_merge)
        k_merge = sortrows(k_merge,[1]);
    end
    
    if sum(k_merge(:)>0)<=k
        k_merge = k_merge(:);
        k_merge(~any(k_merge, 2), :) = [];
    end

    if isempty(colors)
        colors = k_merge;
        data_new = data;

        for col = 1 : size(data_new, 2)
            if sum(k_merge(:)==col)==0
                data_new(:, col) = zeros(size(data_new, 1), 1);
            end
        end

        for row = 1 : size(k_merge, 1)
            list_row = k_merge(row, :);
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

        data_colors = data_new;
    else
        while size(k_merge, 1)>0
            list_row = k_merge(1, :);
            list_row(list_row==0) = [];

            if size(colors, 1)<k
                for m = 1 : size(list_row, 2)
                    colors((size(colors,1)+1), m) = list_row(m);
                end
                data_new = data;
        
                for col = 1 : size(data_new, 2)
                    if sum(k_merge(:)==col)==0
                        data_new(:, col) = zeros(size(data_new, 1), 1);
                    end
                end
        
                for row = 1 : size(k_merge, 1)
                    list_row = k_merge(row, :);
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
        
                data_colors = data_new;
                k_merge(1, :) = [];
            else
                data_new = data;
        
                for col = 1 : size(data_new, 2)
                    if sum(list_row(:)==col)==0
                        data_new(:, col) = zeros(size(data_new, 1), 1);
                    end
                end
            
                if size(list_row, 2)>1
                    for jj = 2 : size(list_row, 2)
                        data_new(:, list_row(1)) = data_new(:, list_row(1)) + data_new(:, list_row(jj));
                        data_new(:, list_row(jj)) = zeros(size(data_new, 1), 1);
                    end
                end
            
                data_new = data_new > 0;
                data_new(:, ~any(data_new, 1)) = [];
            
                data_merge(1 : size(data_colors, 1), 1 : size(data_colors, 2)) = data_colors;
                data_merge(:, (size(data_colors, 2)+1)) = data_new;
    
                adj = data_adj(data_merge);
                m = min(adj(size(data_merge, 2), 1:(size(data_merge, 2)-1)));
    
                kk = 1;
                list = [];
                for jj = 1 : (size(adj, 2)-1)
                    if adj(size(data_merge, 2), jj) == m
                        list(kk) = jj;
                        kk = kk + 1;
                    end
                end
            
                if size(list, 2)==1
                    row = list(1);
                else
                    v = zeros(size(list, 2), 2);
                    for rows = 1 : size(list, 2)
                        v(rows, 1) = sum(data_merge(:, list(rows)) .* data_merge(:, size(data_merge, 2)));
                        row = colors(list(rows), :);
                        row(row==0) = [];
                        v(rows, 2) = size(row, 2) + size(list_row, 2);
                    end
                    A = [];
                    A(1:size(list, 2), 1) = list;
                    A(:, 2:3) = v;
                    A = sortrows(A,[2 3 1]);
                    row = A(1, 1);
                end
            
                list_rows = colors(row, :);
                list_rows(list_rows==0) = [];
            
                merge = [];
                for m = 1 : size(list_rows, 2) + size(list_row, 2)
                    if m <= size(list_rows, 2)
                        merge(m) = list_rows(m);
                    else
                        merge(m) = list_row(m-size(list_rows, 2));
                    end
                end
            
                for n = 1 : size(merge, 2)
                    colors(row, n) = merge(n);
                end
    
                data_colors = data_merge;
                data_colors(:, row) = data_colors(:, row) + data_colors(:, size(data_merge, 2));

                data_colors(:, size(data_merge, 2)) = [];
                k_merge(1, :) = [];
            end
        end
    end

    adj(comp, :) = 0;                          adj(:, comp) = 0;

end

end