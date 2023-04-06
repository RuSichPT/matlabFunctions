function invMat = invMatrixNeumannSeries2(mat, numIter, X)

    % mat - квадратная матрица
    % numIter - кол-во итераций
    % X - первое приближение матрицы mat
    % необходимо numIter -> inf
    
    if (numIter <= 0)
        error("Кол-во итерация не может быть <=0")
    end
    
    invMat = 0;
        
    tmp = eye(size(mat,1)) - X*mat;   
    lambdaMax = max(eig(tmp));
    
    % Условие сходимости
    if (abs(lambdaMax) < 1)   
        for i = 0:numIter - 1
            tmp = eye(size(mat,1)) - X*mat; 
            invMat = invMat + (tmp^i)*X;
        end
    else
        invMat = X;
%         fprintf("Условие сходимости метода NSA %d > 1 нарушено\n", abs(lambdaMax))
    end 
end