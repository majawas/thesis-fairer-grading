function [C, S] = csfunc(G)
% This function takes the matrix with grades and possible NaN's and returns
% the C and S, which are sets of courses that were actually taken by a student 
% or students that actually took a course

[m, n] = size(G); % Number of students - m and courses - n
C = {}; % empty cell arrays
S = {};
select = ~isnan(G);

% C(i) is the set of courses taken by student i
for i=1:m % going through each cell entry from 1 to m
    % Find the indices where the value is 1 in the i-th row
    C{i} = find(select(i,:) == 1);
end

% S(j) is the set of students that took course j
for j=1:n % going through each cell entry from 1 to n
    % Find the indices where the value is 1 in the j-th column
    S{j} = find(select(:,j) == 1)';
end

end