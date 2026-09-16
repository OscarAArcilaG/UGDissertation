M.pn10 = uipanel('Parent',M.tb2,...
                'Units','normalized',...
                'Position',[0.30 0.10 0.675 0.875]);

M.ax7 = subplot(3,2,1,'Parent',M.pn10);
M.LN9 = plot(M.ax7,TN.Tn,SP.ResD,'LineWidth',2);
axtoolbar(M.ax7,{'zoomin','zoomout','pan','datacursor','restoreview','export'});
grid on;
axis('tight');
xlabel('Period [ s ]','fontsize',8);
ylabel('Displacement [ g*s*s ]','fontsize',8);
title('Displacement - Response Spectrum','fontsize',10);

M.ax8 = subplot(3,2,2,'Parent',M.pn10);
M.LN10 = plot(M.ax8,TN.Tn,SP.ResV,'LineWidth',2,'Color',[0.8500 0.3250 0.0980]);
axtoolbar(M.ax8,{'zoomin','zoomout','pan','datacursor','restoreview','export'});
grid on;
axis('tight');
xlabel('Period [ s ]','fontsize',8);
ylabel('Velocity [ g*s ]','fontsize',8);
title('Velocity - Response Spectrum','fontsize',10);

M.ax9 = subplot(3,2,3,'Parent',M.pn10);
M.LN11 = plot(M.ax9,TN.Tn,SP.ResA,'LineWidth',2,'Color',[0.9290 0.6940 0.1250]);
axtoolbar(M.ax9,{'zoomin','zoomout','pan','datacursor','restoreview','export'});
grid on;
axis('tight');
xlabel('Period [ s ]','fontsize',8);
ylabel('Acceleration [ g ]','fontsize',8);
title('Acceleration - Response Spectrum','fontsize',10);

M.ax10 = subplot(3,2,4,'Parent',M.pn10);
M.LN12 = plot(M.ax10,TN.Tn,SP.ResSV,'LineWidth',2,'Color',[0.4940 0.1840 0.5560]);
axtoolbar(M.ax10,{'zoomin','zoomout','pan','datacursor','restoreview','export'});
grid on;
axis('tight');
xlabel('Period [ s ]','fontsize',8);
ylabel('Pseudo-Velocity [ g*s ]','fontsize',8);
title('Pseudo-Velocity - Response Spectrum','fontsize',10);

M.ax11 = subplot(3,2,[5 6],'Parent',M.pn10);
M.LN13 = plot(M.ax11,TN.Tn,SP.ResSA,'LineWidth',2,'Color',[0.4660 0.6740 0.1880]);
axtoolbar(M.ax11,{'zoomin','zoomout','pan','datacursor','restoreview','export'});
grid on;
axis('tight');
xlabel('Period [ s ]','fontsize',8);
ylabel('Pseudo-Acceleration [ g ]','fontsize',8);
title('Pseudo-Acceleration - Response Spectrum','fontsize',10);