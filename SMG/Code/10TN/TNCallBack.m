function TNCallBack(Source,~,Param)

    global M GP FP TP ZZ TN GG SP

    if isnan(str2double(get(Source,'String')))
        if strcmp(Param,'Tmin') || strcmp(Param,'Tmax')
            set(Source,'string',num2str(TN.(Param),'%.3f'));
        elseif strcmp(Param,'Tnum')
            set(Source,'string',num2str(TN.Tnum,'%.0f'));
        end
    else
        TN.(Param) = str2double(get(Source,'String'));
        
        if strcmp(Param,'Tmin')
            if TN.Tmin < 0.001
                TN.Tmin = 0.001;
            elseif TN.Tmin > 99.999
                TN.Tmin = 99.999;
            end
        end
        
        if strcmp(Param,'Tmax')
            if TN.Tmax < 0.002
                TN.Tmax = 0.002;
            elseif TN.Tmax > 100
                TN.Tmax = 100;
            end
        end
        
        if (TN.Tmin >= TN.Tmax) 
           TN.Tmin = 0.01;
           TN.Tmax = 10;
        end
        
        if strcmp(Param,'Tnum')
            if TN.Tnum < 10
                TN.Tnum = 10;
            elseif TN.Tnum >= 10000
                TN.Tnum = 10000;
            else
                TN.Tnum = ceil(TN.Tnum);
            end
        end
        
        TN.Tn=logspace(log10(TN.Tmin),log10(TN.Tmax),TN.Tnum);

        set(TN.Tminedit,'string',num2str(TN.Tmin,'%.3f'));
        set(TN.Tmaxedit,'string',num2str(TN.Tmax,'%.3f'));
        set(TN.Tnumedit,'string',num2str(TN.Tnum,'%.0f'));
        
        SpecMQ

        set(M.LN9,'XData',TN.Tn,'YData',SP.ResD);
        set(M.LN10,'XData',TN.Tn,'YData',SP.ResV);
        set(M.LN11,'XData',TN.Tn,'YData',SP.ResA);
        set(M.LN12,'XData',TN.Tn,'YData',SP.ResSV);
        set(M.LN13,'XData',TN.Tn,'YData',SP.ResSA);

    end
    
    guidata(Source,M);
end