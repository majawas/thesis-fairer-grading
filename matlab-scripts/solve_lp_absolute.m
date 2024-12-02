function [epsilon, mu, nu, errorsum] = solve_lp_absolute(G)
    % G is the m x n matrix of grades, with NaN for missing entries.
    % The function returns epsilon (absolute deviations), mu (student parameters),
    % nu (course parameters), and errorsum (the objective value).

    [m, n] = size(G);  % Dimensions of the grade matrix

    % === Generate (i, j) Pairs ===
    P = [];  % Initialize the set of (i, j) pairs
    for i = 1:m
        for j = 1:n
            if ~isnan(G(i, j))  % Check if G(i, j) is valid (not NaN)
                P = [P; i, j];  % Append the valid (i, j) pair
            end
        end
    end

    num_pairs = size(P, 1);  % Number of (i, j) pairs

    % === Decision Variables ===
    num_epsilon = num_pairs;  % One t_ij per (i, j)
    num_mu = m;  % One mu_i per student
    num_nu = n;  % One nu_j per course
    num_vars = num_epsilon + num_mu + num_nu;  % Total decision variables

    % === Objective Function ===
    c = [ones(num_epsilon, 1); zeros(num_mu + num_nu, 1)];  % Minimize sum of t_ij

    % === Inequality Constraints ===
    A = zeros(2 * num_pairs, num_vars);
    b = zeros(2 * num_pairs, 1);
    for k = 1:num_pairs
        i = P(k, 1);  % Student index
        j = P(k, 2);  % Course index
        row_lower = 2 * k - 1;  % Lower bound constraint
        row_upper = 2 * k;  % Upper bound constraint

        % Lower bound: -epsilon <= Gij - mu_i - nu_j
        A(row_lower, k) = -1;  % -epsilon
        A(row_lower, num_epsilon + i) = 1;  % +mu_i
        A(row_lower, num_epsilon + num_mu + j) = 1;  % +nu_j
        b(row_lower) = G(i, j);  % +Gij

        % Upper bound: Gij - mu_i - nu_j <= epsilon
        A(row_upper, k) = -1;  % -epsilon
        A(row_upper, num_epsilon + i) = -1;  % -mu_i
        A(row_upper, num_epsilon + num_mu + j) = -1;  % -nu_j
        b(row_upper) = -G(i, j);  % -Gij
    end

    % === Equality Constraint (sum of nu_j = 0) ===
    Aeq = zeros(1, num_vars);
    Aeq(num_epsilon + num_mu + 1:end) = 1;  % Only affect nu_j
    beq = 0;

    % === Bounds ===
    lb = [-inf(num_epsilon, 1); -inf(num_mu, 1); -inf(num_nu, 1)];  % No lower bounds
    ub = [];  % No upper bounds

    % === Solve Using linprog ===
    options = optimoptions('linprog', ...
        'OptimalityTolerance', 1e-9, ...
        'ConstraintTolerance', 1e-9, ...
        'Display', 'none');  % Suppress output

    [x, errorsum] = linprog(c, A, b, Aeq, beq, lb, ub, options);

    % === Extract Results ===
    epsilon = x(1:num_epsilon);  % Extract t_ij values
    mu = x(num_epsilon + 1:num_epsilon + num_mu);  % Extract mu values
    nu = (x(num_epsilon + num_mu + 1:end))';  % Extract nu values
end
