function [mu, nu, errorsum] = successive_approx_squares(G, tol, max_iter)
    % G is the m x n grade matrix (students x courses) with NaN for missing entries
    % tol is the convergence tolerance
    % max_iter is the maximum number of iterations

    % C is a cell array where C{i} contains the columns (courses) for row i (student)
    % S is a cell array where S{j} contains the rows (students) for column j (course)
    [C, S] = csfunc(G);  % Obtain sets C and S using csfunc
    [m, n] = size(G);    % Dimensions of G (students x courses)

    % Initialize mu and nu
    mu = zeros(m, 1);  % Students' aptitudes
    nu = zeros(1, n);  % Courses' inflation factors

    % Iterative scheme: successive approximations
    for iter = 1:max_iter
        mu_old = mu;
        nu_old = nu;

        % Update mu_i for each student (student's aptitude)
        for i = 1:m
            courses = C{i};  % Courses taken by student i
            if ~isempty(courses)
                sum_val = 0;
                for j = courses
                    sum_val = sum_val + (G(i, j) - nu_old(j));  % Adjust using nu from previous step
                end
                mu(i) = sum_val / length(courses);  % Update mu_i
            end
        end

        % Update nu_j for each course (course inflation)
        for j = 1:n
            students = S{j};  % Students who took course j
            if ~isempty(students)
                sum_val = 0;
                for i = students
                    sum_val = sum_val + (G(i, j) - mu(i));  % Adjust using updated mu
                end
                nu(j) = sum_val / length(students);  % Update nu_j
            end
        end

        % Apply shift to ensure sum(nu) = 0
        nu = nu - mean(nu, 'omitnan');

        % Check for convergence
        if norm(mu - mu_old) < tol && norm(nu - nu_old) < tol
            % === Calculate the sum of squared errors ===
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
            break;
        end
    end

    if iter == max_iter
        disp('Maximum iterations reached without convergence.');
    end
end
