M.pn5 = uipanel('Parent',M.tb1,...
                'Units','normalized',...
                'Position',[0.30 0.10 0.675 0.875]);

M.ax1 = subplot(3,2,1,'Parent',M.pn5);
M.LN1  = plot(M.ax1,GP.tt/60,GP.NGenAcc);
axtoolbar(M.ax1,{'zoomin','zoomout','pan','datacursor','restoreview','export'});
grid on;
axis('tight');
ylim([-1.1 1.1]);
xlabel('Time [ min ]','fontsize',8);
ylabel('Norm. Acc. [ - ]','fontsize',8);
title('White Noise - Accelerogram','fontsize',10);

M.ax2 = subplot(3,2,2,'Parent',M.pn5);
M.LN2  = semilogx(M.ax2,GP.ff,db(GP.psd),'LineWidth',2);
axtoolbar(M.ax2,{'zoomin','zoomout','pan','datacursor','restoreview','export'});
grid on;
axis('tight');
ylim([-100 0]);
xlabel('Frequency [ Hz ]','fontsize',8);
ylabel('PSD [ dB/Hz ]','fontsize',8);
title('White Noise - PSD','fontsize',10);

M.ax3 = subplot(3,2,3,'Parent',M.pn5);
M.LN3 = semilogx(M.ax3,FP.w/2/pi,db(squeeze(FP.mag)),'LineWidth',2,'Color',[0.8500 0.3250 0.0980]);
axtoolbar(M.ax3,{'zoomin','zoomout','pan','datacursor','restoreview','export'});
grid on;
axis('tight');
xlabel('Frequency [ Hz ]','fontsize',8);
ylabel('Magnitude [ dB ]','fontsize',8);
title('Filter Bode - Amplitude','fontsize',10);

M.ax4 = subplot(3,2,4,'Parent',M.pn5);
M.LN4 = semilogx(M.ax4,FP.w/2/pi,squeeze(FP.ph),'LineWidth',2,'Color',[0.8500 0.3250 0.0980]);
axtoolbar(M.ax4,{'zoomin','zoomout','pan','datacursor','restoreview','export'});
grid on;
axis('tight');
xlabel('Frequency [ Hz ]','fontsize',8);
ylabel('Phase [ Deg ]','fontsize',8);
title('Filter Bode - Phase','fontsize',10);

M.ax5 = subplot(3,2,5,'Parent',M.pn5);
M.LN5  = plot(M.ax5,GP.tt/60,TP.mqSN*TP.PGA,'Color',[0.9290 0.6940 0.1250]);
hold on;
M.LN6  = plot(M.ax5,GP.tt/60,TP.winN*TP.PGA,'LineWidth',2,'Color',[0.4940 0.1840 0.5560]);
M.LN7  = plot(M.ax5,GP.tt/60,envelope(TP.mqSN*TP.PGA,floor(length(TP.mqSN)/100),'rms'),'LineWidth',2,'Color',[0.4660 0.6740 0.1880]);
hold off;
axtoolbar(M.ax5,{'zoomin','zoomout','pan','datacursor','restoreview','export'});
grid on;
axis('tight');
ylim([-1.1 1.1]*TP.PGA);
xlabel('Time [ min ]','fontsize',8);
ylabel('Acceleration [ m/s/s ]','fontsize',8);
title('Synthetic Moonquake - Accelerogram','fontsize',10);

M.ax6 = subplot(3,2,6,'Parent',M.pn5);
M.LN8  = semilogx(M.ax6,TP.ff,db(TP.psd),'LineWidth',2,'Color',[0.9290 0.6940 0.1250]);
axtoolbar(M.ax6,{'zoomin','zoomout','pan','datacursor','restoreview','export'});
grid on;
axis('tight')
xlabel('Frequency [ Hz ]','fontsize',8);
ylabel('PSD [ dB/Hz ]','fontsize',8);
title('Synthetic Moonquake - PSD','fontsize',10);