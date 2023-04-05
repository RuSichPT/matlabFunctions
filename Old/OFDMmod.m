function [dataOutput] = OFDMmod(dataInput,Nsymb,Msc,Ngi,N)
% dataInput [1 x поток]
% dataOutput [1 x поток]
    dataOutput = [];
    for i = 0:Nsymb-1
        Spectr_OFDM = zeros(1,N); 
        Spectr_OFDM(1:Msc/2) = dataInput(i*Msc+1:i*Msc + Msc/2); % Помешаем символы на поднесущие левая часть
        Spectr_OFDM(N - Msc/2 + 1 :N) = dataInput(i*Msc + Msc/2+1:(i+1)*Msc);% Помешаем символы на поднесущие правая часть
        dataOFDM_signal = ifft(Spectr_OFDM,N);% Получаем временную реализацию
        OFDM_signal_guard = [dataOFDM_signal(N-Ngi+1:N) dataOFDM_signal dataOFDM_signal(1:Ngi)];% Защитные интервалы
        dataOutput = [dataOutput OFDM_signal_guard];
    end
end

