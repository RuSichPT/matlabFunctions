function plot_ber(ber,snr,bps,str,N,flag,varargin)
% str - ���� �������, N - ������ �����
% 'k','r','g','b','c'
% flag = 1 ��������� ����� ������,flag = 0 �� ���������
if flag == 1
    figure()
end
if (nargin==7)
    semilogy(snr-(10*log10(bps)),ber,str,'LineWidth',N,'Color',varargin{1})
else
    semilogy(snr-(10*log10(bps)),ber,str,'LineWidth',N)
end
hold on;
grid on;
xlim([0 snr(end)]);
ylim([10^-6 10^0]);
xlabel('E_b / N_0 , dB');
ylabel('BER');
end

