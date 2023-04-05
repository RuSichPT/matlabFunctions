function [Out_Symbols_ML] = My_MIMO_Equalize_ML(Y,H_estim,M,numTx)
% ������ Y = X*H+ksi; ��������� - psk

% Y - �������� ������� [�����,numTx]
% H_estim - ������ �������
% M - ������� ���������
% numTx - ���-�� ���������� ������
Out_Symbols_ML = [];
bps = log2(M);
S = 0:2^(bps*numTx)-1; %��� ��������� �������� x � ���������� ���� 
allBits = de2bi(S, 'left-msb')'; %��� ��������� �������� x � ����� 
for i =1:numTx
    tmp = allBits(1+(i-1)*bps:bps+(i-1)*bps,:); % tmp - ��������� ����������
    allSymb(i,:) = bi2de(tmp','left-msb') ; %��� ��������� �������� x � �������� �� 0 �� M-1
end
allTxSig = pskmod(allSymb,M); %��� ��������� �������� x � �������� IQ

for i = 1:size(Y,1)    
    r = Y(i,:);
%     tic
    [~, k] = min(sum(abs(repmat(r,[2^(bps*numTx),1]) - allTxSig.'*H_estim).^2,2));
    % ������������ ���������� �� �������� 
    estML = allSymb(:,k);
%     time_ML = toc;
    Out_Symbols_ML = [Out_Symbols_ML  estML];    
end
Out_Symbols_ML = Out_Symbols_ML.';
% �������� ������ � �������� �� 0 �� M-1
end

