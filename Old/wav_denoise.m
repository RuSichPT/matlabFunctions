function [Freq_Char_Est_1_1,Freq_Char_Est_2_1] = wav_denoise(Freq_Char_Est_1,Freq_Char_Est_2)
%������� ��������������
% ������� ������������ � ����������� �������������� �
% ���������� �� ������������ (�������� ������ 4�� ������� � 4�
% ������� ����������
tmp01 = fftshift(Freq_Char_Est_1);
tmp02 = fftshift(Freq_Char_Est_2);        
tmp1 = [fliplr(tmp01(1:10)) tmp01 fliplr(tmp01(end-9:end))]; % �������� ����� � ������ �������� ����� ����� �� ���������
tmp2 = [fliplr(tmp02(1:10)) tmp02 fliplr(tmp02(end-9:end))];   
[tmp11] = H_WAV('db4',4,tmp1);
[tmp21] = H_WAV('db4',4,tmp2);          
[Freq_Char_Est_1_1] = fftshift(tmp11(11:end-10));
[Freq_Char_Est_2_1] = fftshift(tmp21(11:end-10));
end

