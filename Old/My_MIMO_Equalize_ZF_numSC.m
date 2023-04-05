function [Out_dataMod_ZF] = My_MIMO_Equalize_ZF_numSC(Y,H_estim)
% ������ Y = X*H+ksi; 

% ���������� ��� ������ ����������
% Y - �������� ������� [msc,symb_ofdm,numTx]
% H_estim - ������ ������� ���� [msc,numTx,numRx]
% msc - ���-�� ����������,symb_ofdm - ���-�� �������� ofdm

for i = 1:size(Y,1)    
    h_estim = squeeze(H_estim(i,:,:));
    inv_H_ZF = inv(h_estim*h_estim');
    Out_dataMod_ZF(i,:,:) =  squeeze(Y(i,:,:))*h_estim'*inv_H_ZF;
end
% �������� ������ � �������� IQ
end

