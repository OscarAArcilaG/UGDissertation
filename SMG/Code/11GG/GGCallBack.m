function GGCallBack(Source,~,Param)

    global M GP FP TP ZZ TN GG SP

    if isnan(str2double(get(Source,'String')))
        set(Source,'string',num2str(GG.(Param),'%.3f'));
    else
        GG.(Param) = str2double(get(Source,'String'));
        
        if strcmp(Param,'gg')
            if GG.gg < 0.001
                GG.gg = 0.001;
            end
        end

        set(GG.ggedit,'string',num2str(GG.gg,'%.3f'));
        
        SpecMQ

        set(M.LN9,'XData',TN.Tn,'YData',SP.ResD);
        set(M.LN10,'XData',TN.Tn,'YData',SP.ResV);
        set(M.LN11,'XData',TN.Tn,'YData',SP.ResA);
        set(M.LN12,'XData',TN.Tn,'YData',SP.ResSV);
        set(M.LN13,'XData',TN.Tn,'YData',SP.ResSA);
    end
    
    guidata(Source,M);
end