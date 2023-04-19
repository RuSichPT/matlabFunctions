function plotImpulseFrequencyResponses1(numb_TX, numb_RX, H, sampleRate, delay)
    % numb_TX - номер антенны на Tx, которую строим
    % numb_RX - номер антенны на Rx, которую строим 
    % H = [numRx, numTx, numPath]
    % delay - время прихода задержанных лучей (точки во во временной области)
    
    % numRx - кол-во антенн на Rx
    % numTx - кол-во антенн на Tx
    % numPath - кол-во задержанных сигналов (длина импульсной характеристики)
  
    numPath = size(H,3);
    
    % Оси графиков
    N_FFT = 512;
    m = -N_FFT/2+1:N_FFT/2;
    freq = m * sampleRate/N_FFT;

    % Импульсная характеристика 
    h_time = [];
    for i = 1:numPath
        h_time = cat(2,h_time,H(numb_TX,numb_RX,i));
    end
    abs_h = abs(h_time);
    figure();
    stem(delay, abs_h);
    grid on;
    title("Impulse Response " + num2str(numb_TX)+"x"+num2str(numb_RX));
    ylabel('Magnitude');
    xlabel('Delay (s)');

    % АЧХ
    h_freq = fft(h_time', N_FFT);
    figure();
    plot(freq, mag2db(fftshift(abs(h_freq))));
    grid on;
    title("Frequency Response " + num2str(numb_TX)+"x"+num2str(numb_RX));
    ylabel('dBw');
    xlabel('Frequency (Hz)');
end

