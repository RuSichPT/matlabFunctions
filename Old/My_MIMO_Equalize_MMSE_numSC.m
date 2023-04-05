function [Out_dataMod_MMSE] = My_MIMO_Equalize_MMSE_numSC(Y,H_estim,sigma)
% ������ Y = X*H+ksi; 

% ���������� ��� ������ ����������
% Y - �������� ������� [msc,symb_ofdm,numTx]
% H_estim - ������ ������� ���� [msc,numTx,numRx]
% msc - ���-�� ����������,symb_ofdm - ���-�� �������� ofdm
% sigma - ��� ���� (������������)
for i = 1:size(Y,1)    
    h_estim = squeeze(H_estim(i,:,:));
    inv_H_MMSE = inv(h_estim*h_estim'+2*sigma(1:size(h_estim,1),1:size(h_estim,1))^2); %% �� ��� ����� ���������
    Out_dataMod_MMSE(i,:,:) =  squeeze(Y(i,:,:))*h_estim'*inv_H_MMSE;
end
% �������� ������ � �������� IQ
end

