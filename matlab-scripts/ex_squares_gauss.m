%diary('ex_squares_gauss.txt');
%    Maja Was

G = [3.0 3.3 3.7 4.0 NaN NaN;  % Hermione
     2.7 3.0 NaN 3.7 4.0 NaN;  % Harry
     NaN 2.7 3.0 NaN 3.7 4.0;  % Ron 
     NaN NaN 2.7 3.0 3.3 3.7]; % Neville

[gA, gb] = gauss_system_setup(G);

disp('LS linear system to solve (infinitely many solutions):');
disp(' ');

disp('A:');
disp(gA);

disp('b:');
disp(gb);

gmu = [3.8305; 3.5215; 3.186; 2.8405];

disp('mu:');
disp(gmu);

% Get the sets C and S using the csfunc
[C, S] = csfunc(G); 

% Dimensions
[~, n_j] = size(G);  % Get the number of courses (columns)
nu = zeros(1, n_j);  % Initialize nu_j array

% Loop over each j to calculate nu_j
for j = 1:n_j
    m_j = length(S{j});  % Number of students who took course j (size of S{j})
    if m_j > 0
        summation = sum(G(S{j}, j) - gmu(S{j}));  % Sum (X_ij - mu_i) for i in S{j}
        nu(j) = (1 / m_j) * summation;  % Compute nu_j
    else
        nu(j) = NaN;  % Handle empty set (if no students took course j)
    end
end

% Display results
disp('Computed nu values:');
disp(nu);

errorsum = 0;  % Initialize the sum of squared errors
for i = 1:m
    courses = C{i};  % Courses taken by student i (C{i} from csfunc)
    for j = courses
        % Compute the squared error for each (i, j)
        error = (G(i, j) - gmu(i) - nu(j))^2;  
        % Accumulate the sum of errors
        errorsum = errorsum + error;
    end
end

% Display the total sum of squared errors
disp('Sum of squared errors:');
disp(errorsum);

%diary off;