%diary('ex_squares_design_ch.txt');
%    Maja Was
 
G = [3.0 3.3 3.7 4.0 NaN NaN;  % Hermione
     2.7 3.0 NaN 3.7 4.0 NaN;  % Harry
     NaN 2.7 3.0 NaN 3.7 4.0;  % Ron 
     NaN NaN 2.7 3.0 3.3 3.7]; % Neville

% Apply the successive approximations function
[lsch_mu, lsch_nu, lsch_errorsum] = design_cholesky_squares(G);

% % Display the results

disp('LS using design matrix and Theorem 2.4 (Cholesky decomposition):');
disp(' ');

disp('LS mu (student aptitudes):');
disp(lsch_mu);

disp('LS nu (course inflation):');
disp(lsch_nu);

disp('Sum of squared errors:');
disp(lsch_errorsum);

%diary off;