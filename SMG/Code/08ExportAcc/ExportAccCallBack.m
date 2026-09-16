function ExportAccCallBack(~,~,~)

    global M GP FP TP ZZ TN GG SP miniaturePath

    [EfileName, EfilePath] = uiputfile('*.txt', 'Export Accelerogram as ''.txt'' file');

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
        fprintf(fid,'%s\n','% Synthetic Moonquake Accelerogram Record');
        fprintf(fid,'%s\n',['% File: ' EfileName]);
        fprintf(fid,'%s\n',['% Durantion: ' num2str(GP.T,'%.3f') ' min']);
        fprintf(fid,'%s\n',['% Sampling Frequency: ' num2str(GP.fs,'%.3f') ' Hz']);
        fprintf(fid,'%s\n',['% PGA: ' num2str(TP.PGA,'%.3f') ' m/s/s']);
        fprintf(fid,'%s\n','% First Column: Time (s)');
        fprintf(fid,'%s\n','% Second Column: Synthetic Moonquake Acc. (m/s/s)');
        fprintf(fid,'%s\n','% Matlab Loading Method:');
        fprintf(fid,'%s\n',['% fileID = fopen(''' EfileName ''');']);
        fprintf(fid,'%s\n','% Data = cell2mat(textscan(fileID,''%f %f'',''headerlines'',14));');
        fprintf(fid,'%s\n','% fclose(fileID);');
        fprintf(fid,'\n');
        fprintf(fid,'\n');
        A = [GP.tt TP.mqSN*TP.PGA];
        for ii = 1:size(A,1)
            fprintf(fid,'%6.6f\t%.6e',A(ii,:));
            fprintf(fid,'\n');
        end 
        fclose(fid);
        
        set(M.fg, 'pointer', 'arrow');
        
        msg2 = msgbox(['Synthetic Moonquake Accelerogram Exported to: ', EsaveFilePath]);
        jframe = get(msg2,'javaframe');
        jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));
    
end