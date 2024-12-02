function [mu, nu, errorsum] = successive_approx_absolute(G, tol, max_iter)
    % G is the m x n matrix of grades, with NaN for missing entries
    % tol is the convergence tolerance
    % max_iter is the maximum number of iterations

    % C is a cell array where C{i} contains the columns (courses) for row i (student)
    % S is a cell array where S{j} contains the rows (students) for column j (course)
    [C, S] = csfunc(G);  % Obtain sets C and S using csfunc
    [m, n] = size(G);    % Dimensions of G (students x courses)

    % Initialize mu and nu
    mu = zeros(m, 1);  % Students' aptitudes
    nu = zeros(1, n);  % Courses' inflation factors (as a row vector)

    % Iterative scheme: successive approximations
    for iter = 1:max_iter
        mu_old = mu;
        nu_old = nu;

        % Update mu (students' aptitudes)
        for i = 1:m
            courses = C{i};  % Courses taken by student i
            if ~isempty(courses)
                valid_values = G(i, courses) - nu(courses);  % Subtract current nu values
                mu(i) = median(valid_values(~isnan(valid_values)));  % Ignore NaN entries
            end
        end

        % Update nu (courses' inflation factors)
        for j = 1:n
            students = S{j};  % Students who took course j
            if ~isempty(students)
                valid_values = G(students, j) - mu(students);  % Subtract current mu values
                nu(j) = median(valid_values(~isnan(valid_values)));  % Ignore NaN entries
            end
        end

        % Apply shift to ensure sum(nu) = 0
        nu = nu - mean(nu, 'omitnan');  % Ignore NaN when computing the mean

        % Check for convergence
        if max(abs(mu - mu_old)) < tol && max(abs(nu - nu_old)) < tol
            % === Calculate Sum of Absolute Errors ===
            errorsum = 0;
            for i = 1:m
                courses = C{i};  % Courses taken by student i
                for j = courses
                    error = abs(G(i, j) - mu(i) - nu(j));  % Absolute error for each valid (i, j)
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
