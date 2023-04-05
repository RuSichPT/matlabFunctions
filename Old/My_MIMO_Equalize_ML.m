function [Out_Symbols_ML] = My_MIMO_Equalize_ML(Y,H_estim,M,numTx)
% Модель Y = X*H+ksi; модуляция - psk

% Y - принятые символы [Поток,numTx]
% H_estim - оценка матрицы
% M - порядок модуляции
% numTx - кол-во передающих антенн
Out_Symbols_ML = [];
bps = log2(M);
S = 0:2^(bps*numTx)-1; %Все возможные варианты x в десятичном виде 
allBits = de2bi(S, 'left-msb')'; %Все возможные варианты x в битах 
for i =1:numTx
    tmp = allBits(1+(i-1)*bps:bps+(i-1)*bps,:); % tmp - временная переменная
    allSymb(i,:) = bi2de(tmp','left-msb') ; %Все возможные варианты x в символах от 0 до M-1
end
allTxSig = pskmod(allSymb,M); %Все возможные варианты x в символах IQ

for i = 1:size(Y,1)    
    r = Y(i,:);
%     tic
    [~, k] = min(sum(abs(repmat(r,[2^(bps*numTx),1]) - allTxSig.'*H_estim).^2,2));
    % Суммирование происходит по антеннам 
    estML = allSymb(:,k);
%     time_ML = toc;
    Out_Symbols_ML = [Out_Symbols_ML  estML];    
end
Out_Symbols_ML = Out_Symbols_ML.';
% Выходные данные в символах от 0 до M-1
end

