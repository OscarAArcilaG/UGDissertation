function GPcallbackfn(Source,~,Param)

    global M GP FP TP ZZ TN GG SP

    if isnan(str2double(get(Source,'String')))
        set(Source,'string',num2str(GP.(Param),'%.2f'));
    else
        M.change = 1;
        
        GP.(Param) = str2double(get(Source,'String'));
        
        if strcmp(Param,'T')
            if GP.T < 25
                GP.T = 25;
            end
        end
            
        if strcmp(Param,'fs')
            if GP.fs < 6
                GP.fs = 6;
            end
        end
        
        set(GP.Tedit,'string',num2str(GP.T,'%.2f'));
        set(GP.fsedit,'string',num2str(GP.fs,'%.2f'));

        GP.tt = 1/GP.fs*(0:GP.T*60*GP.fs).';
        if (mod(length(GP.tt),2)==1)
            GP.tt(end) = [];
        end
        GP.RndAcc = randn(1,length(GP.tt));	
        GP.NGenAcc = GP.RndAcc/max(abs(GP.RndAcc));
        GP.nfft = 2^(nextpow2(length(GP.tt))-6);
        GP.noverlap = GP.nfft/2;
        GP.window = GP.nfft;
        [GP.psd,GP.ff] = pwelch(GP.NGenAcc,GP.nfft,GP.noverlap,GP.window,GP.fs);
        set(M.LN1,'XData',GP.tt/60,'YData',GP.NGenAcc);
        set(M.LN2,'XData',GP.ff,'YData',db(GP.psd));
        
        if FP.fhone > GP.fs/2 - 0.01
            FP.fhone = GP.fs/2 - 0.01;
        end
        FP.fggone = GP.fs/3;
        FP.fggmaxone = GP.fs/2 - 0.01;
        set(FP.fhSlider1,'value',FP.fhone);
        set(FP.fhedit1,'string',num2str(FP.fhone,'%.3f'));
        set(FP.fggSlider1,'min',0.6,'max',FP.fggmaxone,'value',FP.fggone);
        set(FP.fggedit1,'string',num2str(FP.fggone,'%.3f'));
        if FP.fhtwo > GP.fs/2 - 0.01
            FP.fhtwo = GP.fs/2 - 0.01;
        end
        if FP.fggtwo > GP.fs/2 - 0.01
            FP.fggtwo = GP.fs/2 - 0.01;
        end
        set(FP.fhedit2,'string',num2str(FP.fhtwo,'%.3f'));
        set(FP.fggedit2,'string',num2str(FP.fggtwo,'%.3f'));

        TPslid = [0.025 0.35-0.05 0.725 0.20];
        TPlbl = [0 TPslid(2)-0.10 0.20 0.1];
        Tnticks = 5;
        Tlblmargin = 0.05;
        Tlblvals = linspace(0.6,FP.fggmaxone,Tnticks);
        for k = 1:Tnticks
            Txpos = (Tlblmargin + (k-1)*(TPslid(3) - 2*Tlblmargin)/(Tnticks-1)) - TPlbl(3)/2;
            TPlbl(1) = 0.025 + Txpos;
            uicontrol('Parent',FP.tb1,...
                      'Units','normalized',...
                      'FontSize',6,...
                      'HorizontalAlignment','center',...
                      'Style','text',...
                      'Position',TPlbl,...
                      'String',sprintf('%.3f',Tlblvals(k)));
        end

        FP.zglabel1 = uicontrol('Parent',FP.tb1,...
                                'Units','normalized',...
                                'FontSize',8,...
                                'HorizontalAlignment','center',...
                                'Style','text',...
                                'Position',[0.025 0.10-0.05 0.95 0.20],...
                                'String','Low-pass Damping [ - ]');

        FP.zgSlider1 = uicontrol('Parent',FP.tb1,...
                                 'style','slider',...
                                 'units','normalized',...
                                 'position',[0.025 0.125-0.05 0.725 0.25*10/30],...
                                 'min',0.019,...
                                 'max',0.153,...
                                 'value',FP.zgone,...
                                 'SliderStep',[0.01 0.01],...
                                 'Tooltip','Select Desired Low-pass Damping [ - ]',...
                                 'callback',{@FPCallBack1,'zg'});

        TPslid = [0.025 0.125-0.05 0.725 0.20];
        TPlbl = [0 TPslid(2)-0.10 0.20 0.1];
        Tnticks = 5;
        Tlblmargin = 0.05;
        Tlblvals = linspace(0.019,0.153,Tnticks);
        for k = 1:Tnticks
            Txpos = (Tlblmargin + (k-1)*(TPslid(3) - 2*Tlblmargin)/(Tnticks-1)) - TPlbl(3)/2;
            TPlbl(1) = 0.025 + Txpos;
            uicontrol('Parent',FP.tb1,...
                      'Units','normalized',...
                      'FontSize',6,...
                      'HorizontalAlignment','center',...
                      'Style','text',...
                      'Position',TPlbl,...
                      'String',sprintf('%.3f',Tlblvals(k)));
        end

        FP.zgedit1 = uicontrol('Parent',FP.tb1,...
                               'style','edit',...
                               'units','normalized',...
                               'position',[0.775 0.125-0.05 0.20 0.25*10/30],...
                               'string',num2str(FP.zgone,'%.3f'),...
                               'Tooltip','Write Desired Low-pass Damping [ - ]',...
                               'callback',{@FPCallBack2,'zg'});

        if FP.Seltab == 1
            FP.whone = FP.fhone*2*pi;
            FP.wgone = FP.fggone*2*pi;
            FP.numeqone = conv([1 0],[2*FP.zgone*FP.wgone FP.wgone^2]);
            FP.deneqone = conv([1 2*FP.zhone*FP.whone FP.whone^2],[1 2*FP.zgone*FP.wgone FP.wgone^2]);
            FP.Hone = tf(FP.numeqone,FP.deneqone);
            FP.H = FP.Hone;
            FP.GenAccone = lsim(FP.Hone,GP.RndAcc,GP.tt);
            FP.NGenAcc = FP.GenAccone/max(abs(FP.GenAccone));
        elseif FP.Seltab == 2
            [FP.fhbtwo,FP.fhatwo] = butter(FP.fhotwo,FP.fhtwo/(GP.fs/2),'high');
            [FP.fggbtwo,FPtwo.fgga] = butter(FP.fggotwo,FP.fggtwo/(GP.fs/2),'low');
            FP.btwo = conv(FP.fhbtwo,FP.fggbtwo);
            FP.atwo = conv(FP.fhatwo,FP.fggatwo);
            FP.Htwo = tf(FP.btwo,FP.atwo);
            FP.H = FP.Htwo;
            FP.GenAcctwo = filtfilt(FP.btwo,FP.atwo,GP.RndAcc);
            FP.GenAcctwo = FP.GenAcctwo(:);
            FP.NGenAcc = FP.GenAcctwo/max(abs(FP.GenAcctwo));
        end
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
    end
    
    guidata(Source,M);
end