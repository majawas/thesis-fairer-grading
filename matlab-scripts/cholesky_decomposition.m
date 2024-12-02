function L = cholesky_decomposition(A)
    % Check if the matrix A is square
    [n, m] = size(A);
    if n ~= m
        error('Matrix must be square.');
    end

    % Initialize L as a zero matrix
    L = zeros(n, n);

    % Cholesky decomposition
    for j = 1:n
        % Compute diagonal elements
        L(j, j) = round(sqrt(A(j, j) - sum(L(j, 1:j-1).^2)),2);

        % Compute off-diagonal elements
        for i = (j + 1):n
            L(i, j) = round((A(i, j) - sum(L(i, 1:j-1) .* L(j, 1:j-1))) / L(j, j),2);
        end
    end
end
