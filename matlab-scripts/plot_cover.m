%    Maja Was

G = [3.0 3.3 3.7 4.0 NaN NaN;  % Hermione
     2.7 3.0 NaN 3.7 4.0 NaN;  % Harry
     NaN 2.7 3.0 NaN 3.7 4.0;  % Ron 
     NaN NaN 2.7 3.0 3.3 3.7]; % Neville

% Get the sets C and S using the csfunc
[C, S] = csfunc(G); 

% Parameters for the iterative scheme
tol = 1e-5;  % Tolerance level for convergence
max_iter = 100;  % Maximum number of iterations

% Apply the successive approximations function
[mu, nu, ls_errorsum] = successive_approx_absolute(G, tol, max_iter);

% Preparing data for 3D plot
% Flatten the matrices: we will plot all available grades
grades = G(~isnan(G));  % Get all non-NaN grades from G
[students, courses] = find(~isnan(G));  % Get indices of valid grades

% Scatter plot in 3D: student indices, course indices, and grades
figure;
scatter3(students, courses, grades, 'filled', 'MarkerFaceColor', 'b');

% Label the axes
xlabel('Student Index (i)');
ylabel('Course Index (j)');
zlabel('Grades');

hold on;

% Create a meshgrid for student indices and course indices
[Student_grid, Course_grid] = meshgrid(1:size(G, 1), 1:size(G, 2));

% Calculate the regression plane as mu_i + nu_j
grade_plane = nan(size(Student_grid));  % Initialize grade_plane with NaNs

% Loop through each grid point to calculate the corresponding grade
for i = 1:size(Student_grid, 1)
    for j = 1:size(Student_grid, 2)
        student_idx = Student_grid(i, j);
        course_idx = Course_grid(i, j);
        % Calculate the grade as mu_i + nu_j
        grade_plane(i, j) = mu(student_idx) + nu(course_idx);
    end
end

% Plot the regression plane
surf(Student_grid, Course_grid, grade_plane, 'EdgeColor', 'none', 'FaceAlpha', 0.5);

% Add a color gradient for the surface
colormap('jet');
colorbar;

% Final plot settings
grid on;
hold off;
view(3);  % 3D view
title('3D Regression of Grades by Student and Course');