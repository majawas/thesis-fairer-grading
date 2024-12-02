diary('example_3.txt');
% Maja Was
% Example 3

% Read the CSV file
data = readtable('simulated_grading_dataset.csv');

% Extract data columns
student_ids = data.Student_ID;
course_ids = data.Course_ID;
grades = data.Grade;

% Number of students and courses
num_students = 1000;
num_courses = 100;

% Initialize the grade matrix with NaN
G3 = NaN(num_students, num_courses);

% Populate the matrix with grades
for i = 1:height(data)
    student = student_ids(i);
    course = course_ids(i);
    G3(student, course) = grades(i);
end

grade_count = sum(~isnan(G3), 'all');

% Display the result
% disp(['Number of valid entries: ', num2str(grade_count)]);

% Display the result 
% disp(G3);

% Parameters for the iterative scheme
tol = 1e-6;  % Tolerance level for convergence
max_iter = 1000;  % Maximum number of iterations

% Apply the successive approximations function
[ls3_mu, ls3_nu, ls3_errorsum] = successive_approx_squares(G3, tol, max_iter);

% % Display the results

disp('LS using successive approximation (Algorithm 3.3):');
% disp(' ');
% 
% disp('LS mu (student aptitudes):');
% disp(ls3_mu);
% 
% disp('LS nu (course inflation):');
% disp(ls3_nu);

disp('Average sum of squared errors:');
disp(ls3_errorsum/grade_count);

[lsqr3_mu, lsqr3_nu, lsqr3_errorsum] = design_qr_squares(G3);

% % Display the results

disp('LS using design matrix and Theorem 2.6 (QR decomposition):');
% disp(' ');
% 
% disp('LS mu (student aptitudes):');
% disp(lsqr3_mu);
% 
% disp('LS nu (course inflation):');
% disp(lsqr3_nu);

disp('Average sum of squared errors:');
disp(lsqr3_errorsum/grade_count);

% Apply the successive approximations function
[lad3_mu, lad3_nu, lad3_errorsum] = successive_approx_absolute(G3, tol, max_iter);

% % Display the results

disp('LAD using successive approximation:');
% disp(' ');
% 
% disp('LAD mu (student aptitudes):');
% disp(lad3_mu);
% 
% disp('LAD nu (course inflation):');
% disp(lad3_nu);

disp('Average sum of absolute errors:');
disp(lad3_errorsum/grade_count);

[epsilon3, lpmu3, lpnu3, lp_errorsum3] = solve_lp_absolute(G3);

disp('LAD using linear programming:');
% disp(' ');
% 
% disp('LP mu (student aptitudes):');
% disp(lpmu3);
% 
% disp('LP nu (course inflation):');
% disp(lpnu3);

disp('Average sum of absolute errors:');
disp(lp_errorsum3/grade_count);

diary off;