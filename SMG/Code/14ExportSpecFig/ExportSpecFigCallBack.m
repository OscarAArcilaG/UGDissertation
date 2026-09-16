function ExportSpecFigCallBack(~,~,~)

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
        handles.axes = M.ax7;
        fignew = figure('Visible','off');
        newAxes = copyobj(handles.axes,fignew);
        set(newAxes,'Position',get(groot,'DefaultAxesPosition'));
        set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')');
        EsaveFilePath = fullfile(EfilePath,'Displacement - Response Spectrum.fig');
        savefig(fignew,EsaveFilePath);
        delete(fignew);
        
        handles.f = M.fg;
        handles.axes = M.ax8;
        fignew = figure('Visible','off');
        newAxes = copyobj(handles.axes,fignew);
        set(newAxes,'Position',get(groot,'DefaultAxesPosition'));
        set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')');
        EsaveFilePath = fullfile(EfilePath,'Velocity - Response Spectrum.fig');
        savefig(fignew,EsaveFilePath);
        delete(fignew);
        
        handles.f = M.fg;
        handles.axes = M.ax9;
        fignew = figure('Visible','off');
        newAxes = copyobj(handles.axes,fignew);
        set(newAxes,'Position',get(groot,'DefaultAxesPosition'));
        set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')');
        EsaveFilePath = fullfile(EfilePath,'Acceleration - Response Spectrum.fig');
        savefig(fignew,EsaveFilePath);
        delete(fignew);
        
        handles.f = M.fg;
        handles.axes = M.ax10;
        fignew = figure('Visible','off');
        newAxes = copyobj(handles.axes,fignew);
        set(newAxes,'Position',get(groot,'DefaultAxesPosition'));
        set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')');
        EsaveFilePath = fullfile(EfilePath,'Pseudo-Velocity - Response Spectrum.fig');
        savefig(fignew,EsaveFilePath);
        delete(fignew);
        
        handles.f = M.fg;
        handles.axes = M.ax11;
        fignew = figure('Visible','off');
        newAxes = copyobj(handles.axes,fignew);
        set(newAxes,'Position',get(groot,'DefaultAxesPosition'));
        set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')');
        EsaveFilePath = fullfile(EfilePath,'Pseudo-Acceleration - Response Spectrum.fig');
        savefig(fignew,EsaveFilePath);
        delete(fignew);
        
        set(M.fg, 'pointer', 'arrow');

        msg2 = msgbox(['Figures Exported to: ',EfilePath]);
        jframe = get(msg2,'javaframe');
        jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));
    end
end