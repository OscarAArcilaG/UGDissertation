function TPtgCallBack(Source,EventData)

    global M GP FP TP ZZ TN GG SP

	t = EventData.NewValue.Title;
	if strcmp(t,'Obseved Values')
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
    elseif strcmp(t,'User Values')
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