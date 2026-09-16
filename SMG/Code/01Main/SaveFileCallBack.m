function SaveFileCallBack(~,~,~)

    global M GP FP TP ZZ TN GG SP miniaturePath

    [fileName, filePath] = uiputfile('*.smg', 'Save as ''Synthetic Moonquake Generator'' file');
    
    jframe = get(gcf,'javaframe');
    jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));
    
    if isequal(fileName, 0) || isequal(filePath, 0)
        msg1 = msgbox('File save was canceled.');
        jframe = get(msg1,'javaframe');
        jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));
    else
        saveFilePath = fullfile(filePath, fileName);
        
        save(saveFilePath,'M','GP','FP','TP','ZZ','TN','GG','SP');
        
        msg2 = msgbox(['Project saved to: ', saveFilePath]);
        jframe = get(msg2,'javaframe');
        jframe.setFigureIcon(javax.swing.ImageIcon(miniaturePath));
    end
end