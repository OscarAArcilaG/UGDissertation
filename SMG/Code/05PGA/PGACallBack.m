function PGACallBack(Source,~,~)

    global M GP FP TP ZZ TN GG SP

    inputValue = str2double(get(Source,'String'));
    
    if isnan(inputValue)
        set(TP.PGAedit,'String',num2str(TP.PGA,'%.3f'));
    else
        M.change = 1;
        
        if inputValue < 0.001
            inputValue = 0.001;
        elseif inputValue > 100
            inputValue = 100
        end
        
        TP.PGA = inputValue;
    
        set(TP.PGAedit,'String',num2str(TP.PGA,'%.3f'));
        
        [TP.psd,TP.ff] = pwelch(TP.mqSN*TP.PGA,GP.nfft,GP.noverlap,GP.window,GP.fs);
        
        set(M.LN5,'XData',GP.tt/60,'YData',TP.mqSN*TP.PGA);
        set(M.LN5.Parent,'YLim',[-1.1 1.1]*TP.PGA);
        set(M.LN6,'XData',GP.tt/60,'YData',TP.winN*TP.PGA);
        set(M.LN7,'XData',GP.tt/60,'YData',envelope(TP.mqSN*TP.PGA,floor(length(TP.mqSN)/100),'rms'));        
        set(M.LN8,'XData',TP.ff,'YData',db(TP.psd));
    end

    guidata(Source,M);
end
