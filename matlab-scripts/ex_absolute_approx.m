diary('ex_absolute_approx.txt');
%    Maja Was

G = [3.0 3.3 3.7 4.0 NaN NaN;  % Hermione
     2.7 3.0 NaN 3.7 4.0 NaN;  % Harry
     NaN 2.7 3.0 NaN 3.7 4.0;  % Ron 
     NaN NaN 2.7 3.0 3.3 3.7]; % Neville

% Parameters for the iterative scheme
tol = 1e-5;  % Tolerance level for convergence
max_iter = 100;  % Maximum number of iterations

% Apply the successive approximations function
[lad_mu, lad_nu, lad_errorsum] = successive_approx_absolute(G, tol, max_iter);

% % Display the results

disp('LAD using successive approximation:');
disp(' ');

disp('LAD mu (student aptitudes):');
disp(lad_mu);

disp('LAD nu (course inflation):');
disp(lad_nu);

disp('Sum of absolute errors:');
disp(lad_errorsum);

diary off;