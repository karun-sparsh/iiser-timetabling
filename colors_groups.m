function groups = colors_groups(colors)

binary = list_zerone(colors)';
groups = adj_list(binary);

end