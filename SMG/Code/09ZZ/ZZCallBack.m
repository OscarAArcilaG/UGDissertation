function ZZCallBack(Source,~,Param)

    global M GP FP TP ZZ TN GG SP

    if isnan(str2double(get(Source,'String')))
        set(Source,'string',num2str(ZZ.(Param),'%.3f'));
    else
    
        ZZ.(Param) = str2double(get(Source,'String'));
        
        if strcmp(Param,'Z')
            if ZZ.Z < 0
                ZZ.Z = 0;
            elseif ZZ.Z > 99.999
                ZZ.Z = 99.999;
            end
        end
        
        set(ZZ.Zedit,'string',num2str(ZZ.Z,'%.3f'));
        
        SpecMQ

        set(M.LN9,'XData',TN.Tn,'YData',SP.ResD);
        set(M.LN10,'XData',TN.Tn,'YData',SP.ResV);
        set(M.LN11,'XData',TN.Tn,'YData',SP.ResA);
        set(M.LN12,'XData',TN.Tn,'YData',SP.ResSV);
        set(M.LN13,'XData',TN.Tn,'YData',SP.ResSA);
        
    end
    
    guidata(Source,M);
end