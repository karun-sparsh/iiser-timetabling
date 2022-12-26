%% iiser-timetabling
%% MATLAB files for the timetabling problem, grouping of courses using a modified version of greedy colouring.

%% n is desired number of groups.

%% data is a matrix in which rows represent students while columns represent courses.
% data(i, j) = 1 if student 'i' has chosen course 'j' and 0 otherwise.

%% adj is a matrix in which both rows and columns represent courses.
% adj(i, j) = number of students who have chosen both courses 'i' & 'j'.
adj = data_adj(data);
%adj = adj>0;

%% greedy is the grouping obtained by coloring using greedy algorithm.
greedy = adj_colors(adj);
% a vector with 'i'th entry for 'i'th course group number.
greedy = colors_groups(greedy);
% each row is a group.

%% merge is the grouping obtained by using greedy merge algorithm.
merge = data_k_merge(data, n);
% each row is a group.

%% enum is the grouping obtained by using enum merge algorithm.
enum = adj_data_k_colors(adj, data, n);
% each row is a group.

%% enum2 is the grouping obtained by using enum2 merge algorithm.
enum2 = adj_data_k_colors2(adj, data, n);
% each row is a group.

%% dtf is distance to fesibility, or simply dis-satisfaction.
% lower the better.
dtf_merge = colors_adj_dtf(merge, adj);
dtf_enum = colors_adj_dtf(enum, adj);
dtf_enum2 = colors_adj_dtf(enum2, adj);
