function ExportSpecCallBack(~,~,~)

    global M GP FP TP ZZ TN GG SP miniaturePath

    [EfileName, EfilePath] = uiputfile('*.txt', 'Export Response Spectrum''s as ''.txt'' file');
    
    jframe = get(gcf,'javaframe');
    jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));
    
    if isequal(EfileName, 0) || isequal(EfilePath, 0)
        msg1 = msgbox('File save was canceled.');
        jframe = get(msg1,'javaframe');
        jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));
    else
        set(M.fg, 'pointer', 'watch')
        drawnow;
    
        EsaveFilePath = fullfile(EfilePath, EfileName);
        fid = fopen(EsaveFilePath,'wt');
        fprintf(fid,'%s\n',['% Date: ' datestr(now, 'dd/mmmm/yyyy-HH:MM:SS')]);
        fprintf(fid,'%s\n','% Synthetic Moonquake Response Spectrum''s');
        fprintf(fid,'%s\n',['% File: ' EfileName]);
        fprintf(fid,'%s\n',['% Structural Damping Ratio: ' num2str(ZZ.Z,'%.3f') ' %']);
        fprintf(fid,'%s\n',['% Minimum Period: ' num2str(TN.Tmin,'%.3f') ' s']);
        fprintf(fid,'%s\n',['% Maximum Period: ' num2str(TN.Tmax,'%.3f') ' s']);
        fprintf(fid,'%s\n',['% Number of Periods: ' num2str(TN.Tnum,'%.0f') ' -']);
        fprintf(fid,'%s\n',['% Gravitational Acceleration: ' num2str(GG.gg,'%.3f') ' m/s/s']);
        fprintf(fid,'%s\n','% First Column: Period (s)');
        fprintf(fid,'%s\n','% Second Column: Displacement (g*s*s)');
        fprintf(fid,'%s\n','% Third Column: Velocity (g*s)');
        fprintf(fid,'%s\n','% Fourth Column: Acceleration (g)');
        fprintf(fid,'%s\n','% Fifth Column: Pseudo-Velocity (g*s)');
        fprintf(fid,'%s\n','% Sixth Column: Pseudo-Acceleration (g)');
        fprintf(fid,'%s\n','% Matlab Loading Method:');
        fprintf(fid,'%s\n',['% fileID = fopen(''' EfileName ''');']);
        fprintf(fid,'%s\n','% Data = cell2mat(textscan(fileID,''%f %f'',''headerlines'',20));');
        fprintf(fid,'%s\n','% fclose(fileID);');
        fprintf(fid,'\n');
        fprintf(fid,'\n');
        A = [TN.Tn(:) SP.ResD(:) SP.ResV(:) SP.ResA(:) SP.ResSV(:) SP.ResSA(:)];
        for ii = 1:size(A,1)
            fprintf(fid,'%6.6f\t%.6e\t%.6e\t%.6e\t%.6e\t%.6e',A(ii,:));
            fprintf(fid,'\n');
        end 
        fclose(fid);
        
        set(M.fg, 'pointer', 'arrow');
        
        msg2 = msgbox(['Response Spectra Exported to: ', EsaveFilePath]);
        jframe = get(msg2,'javaframe');
        jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));
    end

end