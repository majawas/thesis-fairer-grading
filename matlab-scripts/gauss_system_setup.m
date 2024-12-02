% Creates the linear system (A and g) to find mu based on equation (3.7)
% It also can solve the system using \ but result is not unique and might not
% always be the optimal solution, so we excludet it from the output.

function [A, g] = gauss_system_setup(G)
    % G is the matrix of grades, with NaN for missing entries

    % Number of students and courses
    [m, n] = size(G); % Number of students - m and courses - n

    % C{i} is the set of courses taken by student i
    % S{j} is the set of students that took course j
    [C, S] = csfunc(G);

    % ni(i) is the number of courses taken by student i
    % mj(j) is the number of students that took course j    
    for i = 1:m
        ni(i) = length(C{i});
    end

    for j = 1:n
        mj(j) = length(S{j});
    end

    % Initialize mu (aptitudes) as a zero vector
    mu = zeros(m, 1);
    
    % Initialize a matrix to represent the linear system A * mu = g
    A = zeros(m, m);
    g = zeros(m, 1);
    
    % Build the system of equations
    for i = 1:m
        % Build the i-th equation in the system for mu_i
        for j = C{i} % Loop over courses taken by student i
            % Contribution from the student's own grade in course j
            inner_sum = 0;
            for i_prim = S{j} % Loop over students that took course j
                A(i, i_prim) = A(i, i_prim) + (1 / (ni(i) * mj(j)));
                inner_sum = inner_sum + G(i_prim, j) / mj(j);
            end

            % Right-hand side b_i includes corrected grades
            g(i) = g(i) - (G(i, j) - inner_sum) / ni(i);
        end
        A(i, i) = A(i, i) - 1;
    end
    
    mu = A \ g; % Solve the regularized system
end