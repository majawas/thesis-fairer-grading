% Solve the system of equations using Cholesky decomposition
% Input matrix A mxn, m>n, create A' * A, vector g, create A' * g

function x = cholesky_solve(A, g)
    % Input matrix M mxn, m>n, create A = M' * M, vector v, create g = A'*g
    % Output x - solution of A'Ax = A'g through Cholesky decomposition
    A_new = round_to_three(A' * A);
    g_new = round_to_three(A' * g);
    L = cholesky_decomposition(A_new);
    %disp(L);
    y = round(L\g_new, 4);
    x = round(L'\y,4);
    %disp(y);
    %disp(x);

end