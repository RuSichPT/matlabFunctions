function [dataOutput,dataInput] = OFDMdemod_MIMO(dataInput,Nsymb,Msc,Ngi,N,Freq_Char_Est,Freq_Char_Est2)
    dataOutput = [];    
    for i = 0:Nsymb-1        
        data_noisy = dataInput(1:N+2*Ngi);
        dataInput(1:N+2*Ngi) = [];
        data_noisy(1:Ngi)= []; % ������� �������� ���������
        data_noisy(end-Ngi+1:end)= [];% ������� �������� ���������
        Spectr_noisy = fft(data_noisy,N);
        if (mod(i,4)<2)% �������� ��� i=0 � i=1
            dataMod_noisy = [Spectr_noisy(1:Msc/2) Spectr_noisy(N-Msc/2 + 1: N)]./ Freq_Char_Est;
        else % �������� ��� i=2 � i=3
            dataMod_noisy = [Spectr_noisy(1:Msc/2) Spectr_noisy(N-Msc/2 + 1: N)]./ Freq_Char_Est2;
        end        
        dataOutput = [dataOutput dataMod_noisy];
    end
end

