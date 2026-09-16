function TPCallBack2(Source,~,Param)

    global M GP FP TP ZZ TN GG SP

    if isnan(str2double(get(Source,'String')))
        if strcmp(Param,'t1')
            set(Source,'string',num2str(TP.t1one,'%.3f'));
        elseif strcmp(Param,'a')
            set(Source,'string',num2str(TP.aone,'%.3f'));
        elseif strcmp(Param,'t2')
            set(Source,'string',num2str(TP.t2one,'%.3f'));
        elseif strcmp(Param,'c')
            set(Source,'string',num2str(TP.cone,'%.3f'));
        end
    else
        M.change = 1;
    
        TP.(Param) = str2double(get(Source,'String'));

    if strcmp(Param,'t1')
        if TP.Checked == 1
            if TP.t1 < 4.9112
                TP.t1 = 4.9112;
            elseif TP.t1 > 19.9832
                TP.t1 = 19.9832;
            end
        elseif TP.Checked == 2
            if TP.t1 < 4.8709
                TP.t1 = 4.8709;
            elseif TP.t1 > 14.1745
                TP.t1 = 14.1745;
            end
        elseif TP.Checked == 3
            if TP.t1 < 3.7868
                TP.t1 = 3.7868;
            elseif TP.t1 > 7.8382
                TP.t1 = 7.8382;
            end
        end
        TP.t1one = TP.t1;
        if TP.t2one <= TP.t1one
            TP.t2one = TP.t1one + 0.004;
        end
    end

    if strcmp(Param,'a')
        if TP.Checked == 1
            if TP.a <= 0.1879
                TP.a = 0.1879;
            elseif TP.a > 4.3490
                TP.a = 4.3490;
            end
        elseif TP.Checked == 2
            if TP.a <= 0.3714
                TP.a = 0.3714;
            elseif TP.a > 2.2694
                TP.a = 2.2694;
            end
        elseif TP.Checked == 3
            if TP.a <= 0.3811
                TP.a = 0.3811;
            elseif TP.a > 1.7402
                TP.a = 1.7402;
            end
        end
        
        TP.aone = TP.a;
    end
    
    if strcmp(Param,'t2')
        if TP.Checked == 1
            if TP.t2 < 4.9164
                TP.t2 = 4.9164;
            elseif TP.t2 > 22.6608
                TP.t2 = 22.6608;
            end
        elseif TP.Checked == 2
            if TP.t2 < 4.8756
                TP.t2 = 4.8756;
            elseif TP.t2 > 16.3818
                TP.t2 = 16.3818;
            end
        elseif TP.Checked == 3
            if TP.t2 < 5.2963
                TP.t2 = 5.2963;
            elseif TP.t2 > 11.2301
                TP.t2 = 11.2301;
            end
        end
        TP.t2one = TP.t2;
        if TP.t2one <= TP.t1one
            TP.t1one = TP.t2one - 0.004;
        end
    end
    
    if strcmp(Param,'c')
        if TP.Checked == 1
            if TP.c < -4.8428
                TP.c = -4.8428;
            elseif TP.c > -1.7363
                TP.c = -1.7363;
            end
        elseif TP.Checked == 2
            if TP.c < -5.0450
                TP.c = -5.0450;
            elseif TP.c > -1.7919
                TP.c = -1.7919;
            end
        elseif TP.Checked == 3
            if TP.c < -6.8821
                TP.c = -6.8821;
            elseif TP.c > -3.8256
                TP.c = -3.8256;
            end
        end
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