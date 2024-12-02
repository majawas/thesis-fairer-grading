diary('ex_absolute_lp.txt');
%    Maja Was

G = [3.0 3.3 3.7 4.0 NaN NaN;  % Hermione
     2.7 3.0 NaN 3.7 4.0 NaN;  % Harry
     NaN 2.7 3.0 NaN 3.7 4.0;  % Ron 
     NaN NaN 2.7 3.0 3.3 3.7]; % Neville

[epsilon, lpmu, lpnu, lp_errorsum] = solve_lp_absolute(G);

disp('LAD using linear programming:');
disp(' ');

disp('LP mu (student aptitudes):');
disp(lpmu);

disp('LP nu (course inflation):');
disp(lpnu);

disp('LP sum of absolute errors:');
disp(lp_errorsum);

diary off;