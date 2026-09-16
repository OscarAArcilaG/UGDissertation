function ExportAccFigCallBack(~,~,~)

global M GP FP TP ZZ TN GG SP miniaturePath

    outputFileName = 'Figures.fig';
    defaultFileName = fullfile('*.*',outputFileName);
    [EfileName, EfilePath] = uiputfile(defaultFileName,'Export figures as ''MATLAB .fig'' files');
    
    jframe = get(gcf,'javaframe');
    jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));

    if isequal(EfilePath, 0)
        msg1 = msgbox('File save was canceled.');
        jframe = get(msg1,'javaframe');
        jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));
    else
        set(M.fg, 'pointer', 'watch')
        drawnow;
    
        handles.f = M.fg;
        handles.axes = M.ax1;
        fignew = figure('Visible','off');
        newAxes = copyobj(handles.axes,fignew);
        set(newAxes,'Position',get(groot,'DefaultAxesPosition'));
        set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')');
        EsaveFilePath = fullfile(EfilePath,'White Noise - Accelerogram.fig');
        savefig(fignew,EsaveFilePath);
        delete(fignew);
        
        handles.f = M.fg;
        handles.axes = M.ax2;
        fignew = figure('Visible','off');
        newAxes = copyobj(handles.axes,fignew);
        set(newAxes,'Position',get(groot,'DefaultAxesPosition'));
        set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')');
        EsaveFilePath = fullfile(EfilePath,'White Noise - PSD.fig');
        savefig(fignew,EsaveFilePath);
        delete(fignew);
        
        handles.f = M.fg;
        handles.axes = M.ax3;
        fignew = figure('Visible','off');
        newAxes = copyobj(handles.axes,fignew);
        set(newAxes,'Position',get(groot,'DefaultAxesPosition'));
        set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')');
        EsaveFilePath = fullfile(EfilePath,'Filter Bode - Amplitude.fig');
        savefig(fignew,EsaveFilePath);
        delete(fignew);
        
        handles.f = M.fg;
        handles.axes = M.ax4;
        fignew = figure('Visible','off');
        newAxes = copyobj(handles.axes,fignew);
        set(newAxes,'Position',get(groot,'DefaultAxesPosition'));
        set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')');
        EsaveFilePath = fullfile(EfilePath,'Filter Bode - Phase.fig');
        savefig(fignew,EsaveFilePath);
        delete(fignew);
        
        handles.f = M.fg;
        handles.axes = M.ax5;
        fignew = figure('Visible','off');
        newAxes = copyobj(handles.axes,fignew);
        set(newAxes,'Position',get(groot,'DefaultAxesPosition'));
        set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')');
        EsaveFilePath = fullfile(EfilePath,'Synthetic Moonquake - Accelerogram.fig');
        savefig(fignew,EsaveFilePath);
        delete(fignew);
        
        handles.f = M.fg;
        handles.axes = M.ax6;
        fignew = figure('Visible','off');
        newAxes = copyobj(handles.axes,fignew);
        set(newAxes,'Position',get(groot,'DefaultAxesPosition'));
        set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')');
        EsaveFilePath = fullfile(EfilePath,'Synthetic Moonquake - PSD.fig');
        savefig(fignew,EsaveFilePath);
        delete(fignew);
        
        set(M.fg, 'pointer', 'arrow');

        msg2 = msgbox(['Figures Exported to: ',EfilePath]);
        jframe = get(msg2,'javaframe');
        jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));
    end

end