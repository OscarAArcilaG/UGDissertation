function TPCallBack3(Source,~,Param)

    global M GP FP TP ZZ TN GG SP

    if isnan(str2double(get(Source, 'String')))
        set(Source,'string',num2str(TP.(Param),'%.3f'));
    else
        M.change = 1;
    
        TP.(Param) = str2double(get(Source,'String'));
        
        if strcmp(Param,'t1')
            if TP.t1 < 1 
                TP.t1 = 1;
            elseif TP.t1 > 98
                TP.t1 = 98;
            end
            TP.t1two = TP.t1;
            if TP.t2two <= TP.t1two
                TP.t2two = TP.t1two + 0.004;
            end
        end

        if strcmp(Param,'a')
            if TP.a < 0.01
                TP.a = 0.01;
            elseif TP.a > 10
                TP.a = 10;
            end
            TP.atwo = TP.a;
        end
        
        if strcmp(Param,'t2')
            if TP.t2 < 2 
                TP.fh = 2;
            elseif TP.t2 > 99
                TP.t2 = 99;
            end
            TP.t2two = TP.t2;
                if TP.t2two <= TP.t1two
                TP.t1two = TP.t2two - 0.004;
            end
        end
        
        if strcmp(Param,'c')
            if TP.c < -10
                TP.c = -10;
            elseif TP.c > -1 
                TP.c = -1;
            end
            TP.ctwo = TP.c;
        end
       
        TP.N01 = floor(TP.t1two*length(GP.tt)/100);
        TP.n01 = TP.N01;
        TP.win01 = ((1:TP.n01)/TP.n01).^TP.atwo;
        TP.win01 = TP.win01(:);
        TP.N02 = ceil(TP.t2two*length(GP.tt)/100);
        TP.N03 = length(GP.tt);
        TP.n03 = TP.N03 - TP.N02 + 1;
        TP.win03 = exp(TP.ctwo*(1:TP.n03)/TP.n03);
        TP.win03 = TP.win03(:);
        TP.n02 = length(GP.tt) - length(TP.win01) - length(TP.win03);
        TP.win02 = ones(TP.n02,1);
        TP.winNtwo = [TP.win01; TP.win02; TP.win03];
        TP.winN = TP.winNtwo;

        TP.mqS = FP.NGenAcc.*TP.winN;
        TP.mqSN = TP.mqS/max(abs(TP.mqS));
        [TP.psd,TP.ff] = pwelch(TP.mqSN*TP.PGA,GP.nfft,GP.noverlap,GP.window,GP.fs);
        
        set(M.LN5,'XData',GP.tt/60,'YData',TP.mqSN*TP.PGA);
        set(M.LN5.Parent,'YLim',[-1.1 1.1]*TP.PGA);
        set(M.LN6,'XData',GP.tt/60,'YData',TP.winN*TP.PGA);
        set(M.LN7,'XData',GP.tt/60,'YData',envelope(TP.mqSN*TP.PGA,floor(length(TP.mqSN)/100),'rms'));        
        set(M.LN8,'XData',TP.ff,'YData',db(TP.psd));
        
        set(TP.t1edit2,'string',num2str(TP.t1two,'%.3f'));
        set(TP.aedit2,'string',num2str(TP.atwo,'%.3f'));
        set(TP.t2edit2,'string',num2str(TP.t2two,'%.3f'));
        set(TP.cedit2,'string',num2str(TP.ctwo,'%.3f'));
    end

    guidata(Source,M);
    
end
