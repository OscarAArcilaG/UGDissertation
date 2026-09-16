function RadioButtonCallBack(Source,~, ~)

    global M GP FP TP ZZ TN GG SP

    M.change = 1;

    isChecked1 = get(TP.radioButton1, 'Value');
    isChecked2 = get(TP.radioButton2, 'Value');
    isChecked3 = get(TP.radioButton3, 'Value');
    
    if isChecked1
        TP.Checked = 1;
        TP.t1minone   =  4.9112;
        TP.t1one      = 10.3561;
        TP.t1maxone   = 19.9832;
        TP.aminone    = 0.1879;
        TP.aone       = 1.6230;
        TP.amaxone    = 4.3490;
        TP.t2minone   = 4.9164;
        TP.t2one      = 12.2103;
        TP.t2maxone   = 22.6608;
        TP.cminone    = -4.8428;
        TP.cone       = -3.1044;
        TP.cmaxone    = -1.7363;
    elseif isChecked2
        TP.Checked = 2;
        TP.t1minone   = 4.8709;
        TP.t1one      = 8.4829;
        TP.t1maxone   = 14.1745;
        TP.aminone    = 0.3714;
        TP.aone       = 0.7460;
        TP.amaxone    = 2.2694;
        TP.t2minone   = 4.8756;
        TP.t2one      = 9.5416;
        TP.t2maxone   = 16.3818;
        TP.cminone    = -5.0450;
        TP.cone       = -3.2158;
        TP.cmaxone    = -1.7919;
    elseif isChecked3
        TP.Checked = 3;
        TP.t1minone   = 3.7868;
        TP.t1one      = 6.0933;
        TP.t1maxone   = 7.8382;
        TP.aminone    = 0.3811;
        TP.aone       = 1.0063;
        TP.amaxone    = 1.7402;
        TP.t2minone   = 5.2963;
        TP.t2one      = 8.7476;
        TP.t2maxone   = 11.2301;
        TP.cminone    = -6.8821;
        TP.cone       = -4.8535;
        TP.cmaxone    = -3.8256;
    end
    set(TP.t1Slider,'min',TP.t1minone,'max',TP.t1maxone,'value',TP.t1one);
    set(TP.aSlider,'min',TP.aminone,'max',TP.amaxone,'value',TP.aone);
    set(TP.t2Slider,'min',TP.t2minone,'max',TP.t2maxone,'value',TP.t2one);
    set(TP.cSlider,'min',TP.cminone,'max',TP.cmaxone,'value',TP.cone);
    set(TP.t1edit,'string',num2str(TP.t1one,'%.3f'));
    set(TP.aedit,'string',num2str(TP.aone,'%.3f'));
    set(TP.t2edit,'string',num2str(TP.t2one,'%.3f'));
    set(TP.cedit,'string',num2str(TP.cone,'%.3f'));

    TPslid = [0.025 0.70-0.05 0.725 0.045];
    TPlbl = [0 TPslid(2)-0.03 0.15 0.03];
    Tnticks = 5;
    Tlblmargin = 0.05;
    Tlblvals = linspace(TP.t1minone,TP.t1maxone,Tnticks);
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
    Tlblvals = linspace(TP.aminone,TP.amaxone,Tnticks);
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
    Tlblvals = linspace(TP.t2minone,TP.t2maxone,Tnticks);
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
    Tlblvals = linspace(TP.cminone,TP.cmaxone,Tnticks);
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

    guidata(Source,M);
end