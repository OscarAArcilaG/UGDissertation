function FPcallbackfn2(Source,~,Param)

    global M GP FP TP ZZ TN GG SP

    if isnan(str2double(get(Source,'String')))
        if strcmp(Param,'fh')
            set(Source,'string',num2str(FP.fhone,'%.3f'));
        elseif strcmp(Param,'zh')
            set(Source,'string',num2str(FP.zhone,'%.3f'));
        elseif strcmp(Param,'fgg')
            set(Source,'string',num2str(FP.fggone,'%.3f'));
        elseif strcmp(Param,'zg')
            set(Source,'string',num2str(FP.zgone,'%.3f'));
        end
    else
        M.change = 1;
    
        FP.(Param) = str2double(get(Source,'String'));

        if strcmp(Param,'fh')
            if FP.fh > GP.fs/2 - 0.01
                FP.fh = GP.fs/2 - 0.01;
            elseif FP.fh > 0.7
                FP.fh = 0.7;
            elseif FP.fh < 0.2
                FP.fh = 0.2;
            end
            FP.fhone = FP.fh;
            if FP.fhone > FP.fggone
                FP.fggone = FP.fhone;
            end
        end

        if strcmp(Param,'zh')
            if FP.zh > 50
                FP.zh = 50;
            elseif FP.zh < 0.08
                FP.zh = 0.08;
            end
            FP.zhone = FP.zh;
        end

        if strcmp(Param,'fgg')
            if FP.fgg > FP.fggmaxone
                FP.fgg = FP.fggmaxone;
            elseif FP.fgg < 0.60
                FP.fgg = 0.60;
            end
            FP.fggone = FP.fgg;
            if FP.fhone > FP.fggone
                FP.fhone = FP.fggone;
            end
        end

        if strcmp(Param,'zg')
            if FP.zg > 0.153
                FP.zg = 0.153;
            elseif FP.zg < 0.019
                FP.zg = 0.019;
            end
            FP.zgone = FP.zg;
        end

        set(FP.zhSlider1,'value',FP.zhone);
        set(FP.zhedit1,'string',num2str(FP.zhone,'%.3f'));
        set(FP.fggSlider1,'value',FP.fggone);
        set(FP.fggedit1,'string',num2str(FP.fggone,'%.3f'));
        set(FP.fhSlider1,'value',FP.fhone);
        set(FP.fhedit1,'string',num2str(FP.fhone,'%.3f'));
        set(FP.zgSlider1,'value',FP.zgone);
        set(FP.zgedit1,'string',num2str(FP.zgone,'%.3f'));

        FP.whone = FP.fhone*2*pi;
        FP.wgone = FP.fggone*2*pi;
        FP.numeqone = conv([1 0],[2*FP.zgone*FP.wgone FP.wgone^2]);
        FP.deneqone = conv([1 2*FP.zhone*FP.whone FP.whone^2],[1 2*FP.zgone*FP.wgone FP.wgone^2]);
        FP.Hone = tf(FP.numeqone,FP.deneqone);
        FP.H = FP.Hone;
        FP.GenAccone = lsim(FP.Hone,GP.RndAcc,GP.tt);
        FP.NGenAcc = FP.GenAccone/max(abs(FP.GenAccone));
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
        
        guidata(Source,M);
        
    end
end