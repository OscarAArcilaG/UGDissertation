function OpenFileCallBack(~,~,~)

    global M GP FP TP ZZ TN GG SP miniaturePath

    [fileName, filePath] = uigetfile('*.smg', 'Select a ''Synthetic Moonquake Generator'' file');
    
    jframe = get(gcf,'javaframe');
    jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));
    
    if isequal(fileName, 0) || isequal(filePath, 0)
        msg1 = msgbox('File selection was canceled.');
        jframe = get(msg1,'javaframe');
        jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));
    else
        close(M.fg);
        selectedFile = fullfile(filePath, fileName);
        
        msg2 = msgbox(['Processing File: ', selectedFile]);
        jframe = get(msg2,'javaframe');
        jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));
        
        load(selectedFile,'-mat');
        
        set(GP.Tedit,'string',num2str(GP.T,'%.2f'));
        set(GP.fsedit,'string',num2str(GP.fs,'%.2f'));

        set(FP.zhSlider1,'value',FP.zhone);
        set(FP.zhedit1,'string',num2str(FP.zhone,'%.3f'));
        set(FP.fggSlider1,'value',FP.fggone);
        set(FP.fggedit1,'string',num2str(FP.fggone,'%.3f'));
        set(FP.fhSlider1,'value',FP.fhone);
        set(FP.fhedit1,'string',num2str(FP.fhone,'%.3f'));
        set(FP.zgSlider1,'value',FP.zgone);
        set(FP.zgedit1,'string',num2str(FP.zgone,'%.3f'));
        set(FP.fhoedit2,'string',num2str(FP.fhotwo,'%.0f'));
        set(FP.fggoedit2,'string',num2str(FP.fggotwo,'%.0f'));
        set(FP.fggedit2,'string',num2str(FP.fggtwo,'%.3f'));
        set(FP.fhedit2,'string',num2str(FP.fhtwo,'%.3f'));

        set(TP.t1Slider,'min',TP.t1min,'max',TP.t1max,'value',TP.t1one);
        set(TP.aSlider,'min',TP.amin,'max',TP.amax,'value',TP.aone);
        set(TP.t2Slider,'min',TP.t2min,'max',TP.t2max,'value',TP.t2one);
        set(TP.cSlider,'min',TP.cmin,'max',TP.cmax,'value',TP.cone);
        set(TP.t1edit,'string',num2str(TP.t1one,'%.3f'));
        set(TP.aedit,'string',num2str(TP.aone,'%.3f'));
        set(TP.t2edit,'string',num2str(TP.t2one,'%.3f'));
        set(TP.cedit,'string',num2str(TP.cone,'%.3f'));

        TPslid = [0.025 0.70-0.05 0.725 0.045];
        TPlbl = [0 TPslid(2)-0.03 0.15 0.03];
        Tnticks = 5;
        Tlblmargin = 0.05;
        Tlblvals = linspace(TP.t1min,TP.t1max,Tnticks);
        for k = 1:Tnticks
            Txpos = (Tlblmargin + (k-1)*(TPslid(3) - 2*Tlblmargin)/(Tnticks-1)) - TPlbl(3)/2;
            TPlbl(1) = 0.025 + Txpos;
            uicontrol(	'Parent',TP.tb1,...
                        'Units','normalized',...
                        'FontSize',6,...
                        'HorizontalAlignment','center',...
                        'Style','text',...
                        'Position',TPlbl,...
                        'String',sprintf('%.3f',Tlblvals(k)),...
                        'Tag','t1Slider1ticklabel');
        end

        TPslid = [0.025 0.50-0.05 0.725 0.045];
        TPlbl = [0 TPslid(2)-0.03 0.15 0.03];
        Tnticks = 5;
        Tlblmargin = 0.05;
        Tlblvals = linspace(TP.amin,TP.amax,Tnticks);
        for k = 1:Tnticks
            Txpos = (Tlblmargin + (k-1)*(TPslid(3) - 2*Tlblmargin)/(Tnticks-1)) - TPlbl(3)/2;
            TPlbl(1) = 0.025 + Txpos;
            uicontrol(	'Parent',TP.tb1,...
                        'Units','normalized',...
                        'FontSize',6,...
                        'HorizontalAlignment','center',...
                        'Style','text',...
                        'Position',TPlbl,...
                        'String',sprintf('%.3f',Tlblvals(k)),...
                        'Tag','aslider1ticklabel');
        end

        TPslid = [0.025 0.30-0.05 0.725 0.045];
        TPlbl = [0 TPslid(2)-0.03 0.15 0.03];
        Tnticks = 5;
        Tlblmargin = 0.05;
        Tlblvals = linspace(TP.t2min,TP.t2max,Tnticks);
        for k = 1:Tnticks
            Txpos = (Tlblmargin + (k-1)*(TPslid(3) - 2*Tlblmargin)/(Tnticks-1)) - TPlbl(3)/2;
            TPlbl(1) = 0.025 + Txpos;
            uicontrol(	'Parent',TP.tb1,...
                        'Units','normalized',...
                        'FontSize',6,...
                        'HorizontalAlignment','center',...
                        'Style','text',...
                        'Position',TPlbl,...
                        'String',sprintf('%.3f',Tlblvals(k)),...
                        'Tag','t2slider1ticklabel');
        end

        TPslid = [0.025 0.10-0.05 0.725 0.045];
        TPlbl = [0 TPslid(2)-0.03 0.15 0.03];
        Tnticks = 5;
        Tlblmargin = 0.05;
        Tlblvals = linspace(TP.cmin,TP.cmax,Tnticks);
        for k = 1:Tnticks
            Txpos = (Tlblmargin + (k-1)*(TPslid(3) - 2*Tlblmargin)/(Tnticks-1)) - TPlbl(3)/2;
            TPlbl(1) = 0.025 + Txpos;
            uicontrol(	'Parent',TP.tb1,...
                        'Units','normalized',...
                        'FontSize',6,...
                        'HorizontalAlignment','center',...
                        'Style','text',...
                        'Position',TPlbl,...
                        'String',sprintf('%.3f',Tlblvals(k)),...
                        'Tag','cslider1ticklabel');
        end

        set(TP.t1edit2,'string',num2str(TP.t1two,'%.3f'));
        set(TP.aedit2,'string',num2str(TP.atwo,'%.3f'));
        set(TP.t2edit2,'string',num2str(TP.t2two,'%.3f'));
        set(TP.cedit2,'string',num2str(TP.ctwo,'%.3f'));        
        
        set(TP.PGAedit, 'String',num2str(TP.PGA,'%.3f'));

        set(M.LN1,'XData',GP.tt/60,'YData',GP.NGenAcc);
        set(M.LN2,'XData',GP.ff,'YData',db(GP.psd));
        set(M.LN3,'XData',FP.w/2/pi,'YData',db(squeeze(FP.mag)));
        set(M.LN4,'XData',FP.w/2/pi,'YData',squeeze(FP.ph));
        set(M.LN5,'XData',GP.tt/60,'YData',TP.mqSN*TP.PGA);
        set(M.LN5.Parent,'YLim',[-1.1 1.1]*TP.PGA);
        set(M.LN6,'XData',GP.tt/60,'YData',TP.winN*TP.PGA);
        set(M.LN7,'XData',GP.tt/60,'YData',envelope(TP.mqSN*TP.PGA,floor(length(TP.mqSN)/100),'rms'));        
        set(M.LN8,'XData',TP.ff,'YData',db(TP.psd));
        
        set(ZZ.Zedit,'string',num2str(ZZ.Z,'%.3f'));
        set(TN.Tminedit,'string',num2str(TN.Tmin,'%.3f'));
        set(TN.Tmaxedit,'string',num2str(TN.Tmax,'%.3f'));
        set(TN.Tnumedit,'string',num2str(TN.Tnum,'%.0f'));
        set(GG.ggedit,'string',num2str(GG.gg,'%.3f'));
        
        SpecMQ

        set(M.LN9,'XData',TN.Tn,'YData',SP.ResD);
        set(M.LN10,'XData',TN.Tn,'YData',SP.ResV);
        set(M.LN11,'XData',TN.Tn,'YData',SP.ResA);
        set(M.LN12,'XData',TN.Tn,'YData',SP.ResSV);
        set(M.LN13,'XData',TN.Tn,'YData',SP.ResSA);
        
        if FP.Seltab == 1
            set(FP.tg,'SelectedTab',FP.tb1)
        elseif FP.Seltab == 2
            set(FP.tg,'SelectedTab',FP.tb2)
        end
        
        if TP.Seltab == 1
            set(TP.tg,'SelectedTab',TP.tb1)
        elseif FP.Seltab == 2
            set(TP.tg,'SelectedTab',TP.tb2)
        end
        
        if TP.Checked == 1
            set(TP.radioButton1,'Value',1);
        elseif TP.Checked == 2
            set(TP.radioButton2,'Value',1);
        elseif TP.Checked == 3
            set(TP.radioButton3,'Value',1);
        end

        if M.Seltab == 1
            set(M.tg,'SelectedTab',M.tb1)
        elseif M.Seltab == 2
            set(M.tg,'SelectedTab',M.tb2)
        end
        
        msg3 = msgbox(['Project loaded: ', selectedFile]);
        jframe = get(msg3,'javaframe');
        jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));

        guidata(M.fg,M);        
    end    
end