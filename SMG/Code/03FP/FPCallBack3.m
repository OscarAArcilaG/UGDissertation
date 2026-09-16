function FPcallbackfn3(Source,~,Param)

    global M GP FP TP MZ UV TN GG SP

    if isnan(str2double(get(Source, 'String')))
        if strcmp(Param,'fho')
            set(Source,'string',num2str(FP.fhotwo,'%.0f'));
        elseif strcmp(Param,'fh')
            set(Source,'string',num2str(FP.fhtwo,'%.3f'));
        elseif strcmp(Param,'fggo')
            set(Source,'string',num2str(FP.fggotwo,'%.0f'));
        elseif strcmp(Param,'fgg')
            set(Source,'string',num2str(FP.fggtwo,'%.3f'));
        end
    else
        M.change = 1;
    
        FP.(Param) = str2double(get(Source,'String'));
        
        if strcmp(Param,'fh')
            if FP.fh > GP.fs/2 - 0.01
                FP.fh = GP.fs/2 - 0.01;
            elseif FP.fh < 0.1 
                FP.fh = 0.1;
            end
            FP.fhtwo = FP.fh;
        end
        
        if strcmp(Param,'fho')
            if FP.fho < 1
                FP.fho = 1;
            elseif FP.fho > 4
                FP.fho = 4;
            else
                FP.fho = ceil(FP.fho);
            end
            FP.fhotwo = FP.fho;
        end
        
        if strcmp(Param,'fgg')
            if FP.fgg > GP.fs/2 - 0.01
                FP.fgg = GP.fs/2 - 0.01;
            elseif FP.fgg < 0.01
                FP.fgg = 0.01;
            end
            FP.fggtwo = FP.fgg;
        end

        if strcmp(Param,'fggo')
            if FP.fggo < 1
                FP.fggo = 1;
            elseif FP.fggo > 4
                FP.fggo = 4;
            else
                FP.fggo = ceil(FP.fggo);
            end
            FP.fggotwo = FP.fggo;
        end
        
        set(FP.fhoedit2,'string',num2str(FP.fhotwo,'%.0f'));
        set(FP.fggoedit2,'string',num2str(FP.fggotwo,'%.0f'));
        set(FP.fggedit2,'string',num2str(FP.fggtwo,'%.3f'));
        set(FP.fhedit2,'string',num2str(FP.fhtwo,'%.3f'));

        [FP.fhbtwo,FP.fhatwo] = butter(FP.fhotwo,FP.fhtwo/(GP.fs/2),'high');
        [FP.fggbtwo,FP.fggatwo] = butter(FP.fggotwo,FP.fggtwo/(GP.fs/2),'low');
        FP.btwo = conv(FP.fhbtwo,FP.fggbtwo);
        FP.atwo = conv(FP.fhatwo,FP.fggatwo);
        FP.Htwo = tf(FP.btwo,FP.atwo);
        FP.H = FP.Htwo;
        FP.GenAcctwo = filtfilt(FP.btwo,FP.atwo,GP.RndAcc);
        FP.GenAcctwo = FP.GenAcctwo(:);
        FP.NGenAcc = FP.GenAcctwo/max(abs(FP.GenAcctwo));
        [FP.mag,FP.ph,FP.w] = bode(FP.H);
        
        set(M.LN3,'XData',FP.w/2/pi,'YData',db(squeeze(FP.mag)));
        set(M.LN4,'XData',FP.w/2/pi,'YData',squeeze(FP.ph));

        if TP.Seltab == 1
            TP.N01 = floor(TP.t1one*length(GP.tt)/100);
            TP.n01 = TP.N01;
            TP.win01 = ((1:TP.n01)/TP.n01).^TP.aone;
            TP.win01 = TP.win01(:);
            TP.N02 = ceil(TP.t2one*length(GP.tt)/100);
            TP.N03 = length(GP.tt);
            TP.n03 = TP.N03 - TP.N02 + 1;
            TP.win03 = exp(TP.cone*(1:TP.n03)/TP.n03);
            TP.win03 = TP.win03(:);
            TP.n02 = length(GP.tt) - length(TP.win01) - length(TP.win03);
            TP.win02 = ones(TP.n02,1);
            TP.winNone = [TP.win01; TP.win02; TP.win03];
            TP.winN = TP.winNone;
        if TP.Seltab == 2
            TP.N01 = floor(TP.t1two*length(GP.tt)/100);
            TP.n01 = TP.N01;
            TP.win01 = ((1:TP.n01)/TP.n01).^TP.atwo;
            TP.win01 = TP.win01(:);
            TP.N02 = ceil((100 - TP.t2two)*length(GP.tt)/100);
            TP.N03 = length(GP.tt);
            TP.n03 = TP.N03 - TP.N02 + 1;
            TP.win03 = exp(TP.ctwo*(1:TP.n03)/TP.n03);
            TP.win03 = TP.win03(:);
            TP.n02 = length(GP.tt) - length(TP.win01) - length(TP.win03);
            TP.win02 = ones(TP.n02,1);
            TP.winNtwo = [TP.win01; TP.win02; TP.win03];
            TP.winN = TP.winNtwo;
        end  
        TP.mqS = FP.NGenAcc.*TP.winN;
        TP.mqSN = TP.mqS/max(abs(TP.mqS));
        [TP.psd,TP.ff] = pwelch(TP.mqSN*TP.PGA,GP.nfft,GP.noverlap,GP.window,GP.fs);
        
        set(M.LN5,'XData',GP.tt/60,'YData',TP.mqSN*TP.PGA);
        set(M.LN5.Parent,'YLim',[-1.1 1.1]*TP.PGA);
        set(M.LN6,'XData',GP.tt/60,'YData',TP.winN*TP.PGA);
        set(M.LN7,'XData',GP.tt/60,'YData',envelope(TP.mqSN*TP.PGA,floor(length(TP.mqSN)/100),'rms'));        
        set(M.LN8,'XData',TP.ff,'YData',db(TP.psd));
        
        guidata(Source,M);
        
    end
end