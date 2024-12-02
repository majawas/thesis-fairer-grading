%diary('ex_squares_design_qr.txt');
%    Maja Was

G = [3.0 3.3 3.7 4.0 NaN NaN;  % Hermione
     2.7 3.0 NaN 3.7 4.0 NaN;  % Harry
     NaN 2.7 3.0 NaN 3.7 4.0;  % Ron 
     NaN NaN 2.7 3.0 3.3 3.7]; % Neville

% Apply the successive approximations function
[lsqr_mu, lsqr_nu, lsqr_errorsum] = design_qr_squares(G);

% % Display the results

disp('Least squares using design matrix and Theorem 2.6 (QR decomposition):');
disp(' ');

disp('LS mu (student aptitudes):');
disp(lsqr_mu);

disp('LS nu (course inflation):');
disp(lsqr_nu);

disp('Sum of squared errors:');
disp(lsqr_errorsum);

%diary off;