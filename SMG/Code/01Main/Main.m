M.fg = figure('Name','Synthetic Moonquake Generator',...
              'NumberTitle','off',...
              'MenuBar','none',...
              'Resize','on',...
              'Visible','off');

monitors = get(0,'MonitorPositions');
numMonitors = size(monitors,1);

largestArea = 0;
largestMonitor = 1;
for i = 1:numMonitors
    monitorArea = prod(monitors(i,3:4));
    if monitorArea > largestArea
        largestArea = monitorArea;
        largestMonitor = i;
    end
end

largestMonitorPosition = monitors(largestMonitor,:);

width = 0.90 * largestMonitorPosition(3);
height = 0.90 * largestMonitorPosition(4);
xPos = largestMonitorPosition(1) + (largestMonitorPosition(3) - width)/2;
yPos = largestMonitorPosition(2) + (largestMonitorPosition(4) - height)/2;

set(M.fg,'Position',[xPos,yPos,width,height],'Visible','on');

jframe = get(gcf,'javaframe');
jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));

M.fl = uimenu('Parent',M.fg,'Label','File');
       
uimenu(M.fl,...
       'Label','Open...',...
       'Callback',@OpenFileCallBack,...
       'Accelerator','O');

uimenu(M.fl,...
       'Label','Save As...',...
       'Callback',@SaveFileCallBack,...
       'Accelerator','S');
       
uimenu(M.fl,...
       'Label','Close',...
       'Callback','close all;',...
       'Separator','on',...
       'Accelerator','C');
       
M.hl = uimenu('Parent',M.fg,'Label','?');

uimenu(M.hl,...
       'Label','User Manual',...
       'Callback',@UserManualCallBack);

uimenu(M.hl,...
       'Label','File Associaion',...
       'Callback',@FileAssociaionCallBack);

uimenu(M.hl,...
       'Label','License Agreement',...
       'Callback',@LicenseAgreementCallBack);

uimenu(M.hl, ...
       'Label','About',...
       'Separator','on',...
       'Callback',@AboutCallBack);

M.tg = uitabgroup(M.fg,'SelectionChangedFcn',@MtgCallBack);

M.tb1 = uitab(M.tg,'Title','Synthetic Accelerogram');

M.tb2 = uitab(M.tg,'Title','Response Spectrum');

M.Seltab = 1;
M.change = 0;

GP.T = 85;
GP.fs = 100;
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

FP.Seltab =1;
FP.fho = 2;
FP.fh =  0.4318;
FP.zh = 12.1362;
FP.fggo = 2;
FP.fgg = 0.7100;
FP.zg =  0.0723;
FP.fhone =  0.4318;
FP.zhone = 12.1362;
FP.fggone = GP.fs/3;
FP.fggmaxone = GP.fs/2 - 0.01;
FP.zgone =  0.0723;
FP.fhotwo = 2;
FP.fhtwo =  0.4318;
FP.fggotwo = 2;
FP.fggtwo = 0.7100;
FP.whone = FP.fhone*2*pi;
FP.wgone = FP.fggone*2*pi;
FP.numeqone = conv([1 0],[2*FP.zgone*FP.wgone FP.wgone^2]);
FP.deneqone = conv([1 2*FP.zhone*FP.whone FP.whone^2],[1 2*FP.zgone*FP.wgone FP.wgone^2]);
FP.Hone = tf(FP.numeqone,FP.deneqone);
FP.GenAccone = lsim(FP.Hone,GP.RndAcc,GP.tt);
FP.NGenAcc = FP.GenAccone/max(abs(FP.GenAccone));
FP.H = FP.Hone;
[FP.mag,FP.ph,FP.w] = bode(FP.H);

TP.Seltab = 1;
TP.Checked = 1;
TP.t1 = 10.3561;
TP.a = 1.6230;
TP.t2 = 12.2103;
TP.c = -3.1044;
TP.t1one = 10.3561;
TP.aone = 1.6230;
TP.t2one = 12.2103;
TP.cone = -3.1044;
TP.t1two = 10.3561;
TP.atwo = 1.6230;
TP.t2two = 12.2103;
TP.ctwo = -3.1044;
TP.t1min = 4.9112;
TP.t1max = 19.9832;
TP.amin = 0.1879;
TP.amax = 4.3490;
TP.t2min = 4.9164;
TP.t2max = 22.6608;
TP.cmin = -4.8428;
TP.cmax = -1.7363;
TP.PGA = 1;
TP.N01 = floor(TP.t1*length(GP.tt)/100);
TP.n01 = TP.N01;
TP.win01 = ((1:TP.n01)/TP.n01).^TP.a;
TP.win01 = TP.win01(:);
TP.N02 = ceil(TP.t2*length(GP.tt)/100);
TP.N03 = length(GP.tt);
TP.n03 = TP.N03 - TP.N02 + 1;
TP.win03 = exp(TP.c*(1:TP.n03)/TP.n03);
TP.win03 = TP.win03(:);
TP.n02 = length(GP.tt) - length(TP.win01) - length(TP.win03);
TP.win02 = ones(TP.n02,1);
TP.winN = [TP.win01; TP.win02; TP.win03];
TP.winNone = TP.winN;
TP.winNtwo = TP.winN;
TP.mqS = FP.NGenAcc.*TP.winN;
TP.mqSN = TP.mqS/max(abs(TP.mqS));
[TP.psd,TP.ff] = pwelch(TP.mqSN*TP.PGA,GP.nfft,GP.noverlap,GP.window,GP.fs);

ZZ.Z = 5;

TN.Tmin = 0.01;
TN.Tmax = 10;
TN.Tnum = 100;
TN.Tn=logspace(log10(TN.Tmin),log10(TN.Tmax),TN.Tnum);

GG.gg = 1.625;

guidata(M.fg,M);
