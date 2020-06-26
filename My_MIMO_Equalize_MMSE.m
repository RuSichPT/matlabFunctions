function [Out_dataMod_MMSE] = My_MIMO_Equalize_MMSE(Y,H_estim,sigma,fast)
% Модель Y = X*H+ksi; 

% Y - принятые символы [поток,numTx]
% H_estim - оценка матрицы вида [numTx,numRx,поток]
% sigma - СКО шума
h_estim = squeeze(H_estim(:,:,1));
inv_H_ZF = inv(h_estim*h_estim');
N = size(inv_H_ZF,1);
M = size(inv_H_ZF,2);
if fast ==1
    inv_H_MMSE = inv(H_estim*H_estim'+2*sigma^2*eye(N,M));
    Out_dataMod_MMSE = Y*H_estim'*inv_H_MMSE;
else
    for i = 1:size(Y,1)
        h_estim = squeeze(H_estim(:,:,i));
    %     tic
        inv_H_MMSE = inv(h_estim*h_estim'+2*sigma^2*eye(N,M));
        Out_dataMod_MMSE(i,:) = Y(i,:)*h_estim'*inv_H_MMSE;
    %     time_MMSE = toc;
    end
end