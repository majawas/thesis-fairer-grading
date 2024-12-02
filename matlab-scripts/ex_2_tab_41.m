%    Example 2 (Table 4.1)
%    Maja Was

grades = [
    3.3, 3.7, 4.0, NaN, NaN, NaN, NaN, NaN; % Muna
    3.0, 3.3, 3.7, 4.0, NaN, NaN, NaN, NaN; % Fermione
    NaN, 3.0, 3.3, 3.7, 4.0, NaN, NaN, NaN; % Garry
    NaN, NaN, 3.0, 3.3, 3.7, 4.0, NaN, NaN; % Ton
    NaN, NaN, NaN, 3.0, 3.3, 3.7, 4.0, NaN; % Keville
    NaN, NaN, NaN, NaN, 3.0, 3.3, 3.7, 4.0; % Braco
    NaN, NaN, NaN, NaN, NaN, 3.0, 3.3, 3.7  % Kinny
];

% Display the matrix
disp('Grades Matrix:');
disp(grades);

% Parameters for the iterative scheme
tol = 1e-5;  % Tolerance level for convergence
max_iter = 100;  % Maximum number of iterations

% Apply the successive approximations function
[ls2_mu, ls2_nu, ls2_errorsum] = successive_approx_squares(grades, tol, max_iter);

% % Display the results

disp('Least squares using successive approximation (Algorithm 3.3):');
disp(' ');

disp('LS mu (student aptitudes):');
disp(ls2_mu);

disp('LS nu (course inflation):');
disp(ls2_nu);

disp('Sum of squared errors:');
disp(ls2_errorsum);

% Apply the successive approximations function
[lad2_mu, lad2_nu, lad2_errorsum] = successive_approx_absolute(grades, tol, max_iter);

% % Display the results

disp('LAD using successive approximation:');
disp(' ');

disp('LAD mu (student aptitudes):');
disp(lad2_mu);

disp('LAD nu (course inflation):');
disp(lad2_nu);

disp('Sum of absolute errors:');
disp(lad2_errorsum);
