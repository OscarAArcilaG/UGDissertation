function TPCallBack1(Source,~,Param)

    global M GP FP TP ZZ TN GG SP

    M.change = 1;

    TP.(Param) = get(Source, 'Value');
    
    if strcmp(Param,'t1')
        TP.t1one = TP.t1;
        if TP.t2one <= TP.t1one
            TP.t2one = TP.t1one + 0.004;
        end
    end

    if strcmp(Param,'a')
        TP.aone = TP.a;
    end
    
    if strcmp(Param,'t2')
        TP.t2one = TP.t2;
        if TP.t2one <= TP.t1one
            TP.t1one = TP.t2one - 0.004;
        end
    end
    
    if strcmp(Param,'c')
        TP.cone = TP.c;
    end
    
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

    TP.mqS = FP.NGenAcc.*TP.winN;
    TP.mqSN = TP.mqS/max(abs(TP.mqS));
    [TP.psd,TP.ff] = pwelch(TP.mqSN*TP.PGA,GP.nfft,GP.noverlap,GP.window,GP.fs);
    
    set(M.LN5,'XData',GP.tt/60,'YData',TP.mqSN*TP.PGA);
    set(M.LN5.Parent,'YLim',[-1.1 1.1]*TP.PGA);
    set(M.LN6,'XData',GP.tt/60,'YData',TP.winN*TP.PGA);
    set(M.LN7,'XData',GP.tt/60,'YData',envelope(TP.mqSN*TP.PGA,floor(length(TP.mqSN)/100),'rms'));        
    set(M.LN8,'XData',TP.ff,'YData',db(TP.psd));
    
    set(TP.t1Slider,'Value',TP.t1one);
    set(TP.aSlider,'Value',TP.aone);
    set(TP.t2Slider,'Value',TP.t2one);
    set(TP.cSlider,'Value',TP.cone);
    set(TP.t1edit,'string',num2str(TP.t1one,'%.3f'));
    set(TP.aedit,'string',num2str(TP.aone,'%.3f'));
    set(TP.t2edit,'string',num2str(TP.t2one,'%.3f'));
    set(TP.cedit,'string',num2str(TP.cone,'%.3f'));

    guidata(Source,M);
    
end