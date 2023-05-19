function [C, lambda] = mimoCapacity(H, snr_dB)
    % H - матрица канала размерностью [Nrx Ntx]
    % F - матрица прекодирования
    % snr_dB - в дБ
    snr = 10.^(snr_dB/10);
    numRx = size(H,1);
    numTx = size(H,2);
    
    C = zeros(1,length(snr));
    for i = 1:length(snr_dB) 
        sigma = svd(H); % eig(H*H') = svd(H)^2 
        lambda = sigma.^2;
        C(i) = 1/numRx * sum(log2(1 + 1/numTx*snr(i)*abs(lambda))); % 1/numSTS нормировка по потокам 
%         C(i) = 1/numRx * log2(det(eye(numRx) + 1/numTx*snr(i)*(H*H')));  для проверки
    end
    
end