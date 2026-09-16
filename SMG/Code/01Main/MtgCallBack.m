function MtgCallBack(Source,EventData,~)

    global M GP FP TP ZZ TN GG SP

	t = EventData.NewValue.Title;
    
	if strcmp(t,'Synthetic Accelerogram')
        %Do Nothing
    elseif strcmp(t,'Response Spectrum')
        if M.change == 1
        
            SpecMQ

            set(M.LN9,'XData',TN.Tn,'YData',SP.ResD);
            set(M.LN10,'XData',TN.Tn,'YData',SP.ResV);
            set(M.LN11,'XData',TN.Tn,'YData',SP.ResA);
            set(M.LN12,'XData',TN.Tn,'YData',SP.ResSV);
            set(M.LN13,'XData',TN.Tn,'YData',SP.ResSA);
            
            M.change = 0;
        end
    end
    
    guidata(Source,M);
end