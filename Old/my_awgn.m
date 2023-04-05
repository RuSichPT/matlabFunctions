function [Y,sigma] = my_awgn(X,snr,varargin)
% X - [�����, numRx]
% varargin{1} - ����������� ��������� ������� 
if nargin == 3
    sigma = varargin{1}*10^((-snr)/20); % ���
    Y =  X+(randn(size(X,1),size(X,2))+ 1i * randn(size(X,1),size(X,2)))*0.707 * sigma;
else
    for i = 1:size(X,2)
        E_tmp(i) = sum(abs(X(:,i)).^2); % �������
        P(i) = E_tmp(i)/(size(X,1));% ������� �������� 
        A(i) = sqrt(P(i)); % ������� ���������
        sigma(i) = A(i)*10^((-snr)/20); % ���
    end
    sigma = diag(sigma);
    Y =  X+(randn(size(X,1),size(X,2))+ 1i * randn(size(X,1),size(X,2)))*0.707 * sigma;
end
end

