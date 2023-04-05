function [Out_Symbols_ML] = My_MIMO_Equalize_ML_numSC(Y,H_estim,M,numTx)
% ������ Y = X*H+ksi; ��������� - qam

% ���������� ��� ������ ����������
% Y - �������� ������� [msc,symb_ofdm,numTx]
% H_estim - ������ ������� ���� [msc,numTx,numRx]
% msc - ���-�� ����������,symb_ofdm - ���-�� �������� ofdm
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
allTxSig = qammod(allSymb,M); %��� ��������� �������� x � �������� IQ
allTxSig = allTxSig.';

for j = 1:size(Y,2)
    for i = 1:size(Y,1)    
        r = squeeze(Y(i,j,:)).';
        h_estim = squeeze(H_estim(i,:,:));
    %     tic
        [~, k] = min(sum(abs(repmat(r,[2^(bps*numTx),1]) - allTxSig*h_estim).^2,2));
        % ������������ ���������� �� �������� 
        estML = allSymb(:,k).';
    %     time_ML = toc;
        Out_Symbols_ML = [Out_Symbols_ML; de2bi(estML,bps,'left-msb').'];    
    end
end
% �������� ������ � �������� �� 0 �� M-1
end

