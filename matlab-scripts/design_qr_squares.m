function [mu, nu, errorsum] = design_qr_squares(G)
    % This function solves the least squares problem with the constraint sum(nu_j) = 0.
    % G is the grade matrix where G(i, j) is the grade of student i in course j.
    % NaN values in G indicate missing grades.
    
    [m, n] = size(G); % Number of students and courses
    [C, ~] = csfunc(G); % Get the valid indices of students and courses
    
    % Initialize the design matrix A and the vector g
    num_grades = sum(~isnan(G(:))); % Total number of valid grades
    A = zeros(num_grades, m + n); % Design matrix
    g = zeros(num_grades, 1);     % Grades vector
    
    % Fill in A and g
    row = 1; % Row counter for A and g
    for i = 1:m
        for j = C{i} % Courses taken by student i
            A(row, i) = 1;          % Coefficient for mu_i
            A(row, m + j) = 1;      % Coefficient for nu_js
            g(row) = G(i, j);       % Grade value
            row = row + 1;
        end
    end
    
    % Add constraint: sum(nu_j) = 0
    A_constraint = [zeros(1, m), ones(1, n)];
    A = [A; A_constraint]; % Append the constraint row to A
    g = [g; 0];            % Append the corresponding constraint value to g
    
    % Solve the least squares problem using QR decomposition (Theorem 2.6)
    [Q, R_tilde] = qr(A, 0); % QR decomposition of A
    R = R_tilde(1:m + n, :); % Extract the upper triangular matrix R
    g_tilde = Q' * g;        % Compute Q^T * g
    x = R \ g_tilde(1:m + n); % Solve the triangular system

    % Extract the student effects (mu)
    mu = x(1:m);

    % Extract the course effects (nu)
    nu = x(m+1:m+n)';

   % === Calculate Sum of Absolute Errors ===
   errorsum = 0;
   for i = 1:m
       courses = C{i};  % Courses taken by student i
       for j = courses
           error = (G(i, j) - mu(i) - nu(j))^2;  % Absolute error for each valid (i, j)
           if ~isnan(error)
               errorsum = errorsum + error;  % Accumulate the sum
           end
       end
   end

    %disp(A);
    %disp(g);
    
end
