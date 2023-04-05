function [Out_Symbols_KB] = My_MIMO_Equalize_K_BEST(dataNoise,num_k,H_estim,N,M)
% ������ Y = X*H+ksi; ��������� - psk
% y = x*H   y.' = H.'*x.' ������� H_estim.' dataNoise.'

% dataNoise - �������� ������� [�����,numTx]
% num_k - ����� K-best
% N - numTx;
% M - ���������
Out_Symbols_KB = [];
y = dataNoise.';
[Q,R] = qr(H_estim.'); %  ��������� �� QR  y = QR*x
y_tilda = Q'*y; % Q'*Q = 1 �������� y = R*x
for i = 1:size(y,2)
    r = y_tilda(:,i);
    tmp = 1;
    allSymb_help{1} = 0:M -1;  % ��������� �������� x ��� ��������� ������ 
    allTxSig_help{1} = pskmod(allSymb_help{1},M);
    for j =1:N % ���� �� �������     
        for g = 1:num_k^(j-1)
            Symb_help = allSymb_help{g}; 
            TxSig_help = allTxSig_help{g};
            help_r = repmat(r(N-(j-1):N),[1,size(TxSig_help,2)]);
            for i = 1:num_k % ���� �� �            
                if j==1 % ������ ��������
                    [~, k] = min(abs(help_r - R(N,N)*TxSig_help).^2);                               
                else % �����������
                    [~, k] = min(sum(abs(help_r - R(N-(j-1):N,N-(j-1):N)*TxSig_help).^2,1)); 
                end              
                est1{g,j}(:,i) = Symb_help(:,k); %������ ��������                    
                TxSig_help(:,k) = 100;                         
            end
        end
        if j ~= N
            allSymb_help = [];
            ii = 1;
            for g = 1:num_k^(j-1)
                for i = 1:num_k
                    allSymb_help{ii} = [0:M-1;repmat(est1{g,j}(:,i),[1,M])]; % ��������� �������� x 
                    allTxSig_help{ii} = pskmod(allSymb_help{i},M);
                    ii = ii+1;
                end
            end        
        else
            allSymb_end = [];
            allTxSig_end = [];
            for g=1:num_k^(j-1)
                allSymb_end = [allSymb_end est1{g,j}];                 
            end
            allTxSig_end = pskmod(allSymb_end,M);
        end
    end
    help_r1 = repmat(r,[1,size(allTxSig_end,2)]);    
    [~, k] = min(sum(abs(help_r1 - R*allTxSig_end).^2,1));
    estKB = allSymb_end(:,k);
    Out_Symbols_KB = [Out_Symbols_KB  estKB];
end
Out_Symbols_KB = Out_Symbols_KB.';
end

