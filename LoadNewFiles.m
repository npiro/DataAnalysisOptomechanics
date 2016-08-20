function LoadNewFiles( hObject,handles )
%LoadNewFiles Load all files in current directory not already loaded

FileList = cellstr(get(handles.FileListBox,'String'));
Format = get(handles.FileNameFormat,'String');
CalToneFormat = get(handles.CalToneFilenameFormat,'String');
    

PathName = handles.FilePath;
for fi=1:length(FileList)
    FileName = FileList{fi};
    
    A1 = sscanf(FileName,Format);
    A2 = sscanf(FileName,CalToneFormat);
    if (~isempty(A1) || ~isempty(A2))
        FileExists = false;
        if isfield(handles,'FileName')
            for i=1:length(handles.FileName)                
                if strcmp(FileName,handles.FileName{i})
                    FileExists = true;
                end
            end
        end
        
        if ~FileExists            
            loadData(PathName,FileName,hObject,handles);
            handles = guidata(hObject);            
        end
    end
end
WriteDataToTable(hObject,handles);
guidata(hObject, handles);



