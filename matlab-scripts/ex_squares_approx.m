%diary('ex_squares_approx.txt');
%    Maja Was

G = [3.0 3.3 3.7 4.0 NaN NaN;  % Hermione
     2.7 3.0 NaN 3.7 4.0 NaN;  % Harry
     NaN 2.7 3.0 NaN 3.7 4.0;  % Ron 
     NaN NaN 2.7 3.0 3.3 3.7]; % Neville

% Parameters for the iterative scheme
tol = 1e-5;  % Tolerance level for convergence
max_iter = 100;  % Maximum number of iterations

% Apply the successive approximations function
[ls_mu, ls_nu, ls_errorsum] = successive_approx_squares(G, tol, max_iter);

% % Display the results

disp('Least squares using successive approximation (Algorithm 3.3):');
disp(' ');

disp('LS mu (student aptitudes):');
disp(ls_mu);

disp('LS nu (course inflation):');
disp(ls_nu);

disp('Sum of squared errors:');
disp(ls_errorsum);

%diary off;