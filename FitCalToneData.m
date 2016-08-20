function FitCalToneData(hObject,handles)

contents = cellstr(get(handles.ModelSelectionMenu,'String'));
model = contents{get(handles.ModelSelectionMenu,'Value')};
            
for i = 1:length(handles.dataCalTone)
    
    if ~handles.fittedCalTone{i}
  
        FitSelectedCalToneData(hObject,handles,i);

    end
    handles = guidata(hObject);
    handles.fittedCalTone{i} = 1;
    WriteDataToTable(hObject,handles);
    
end
guidata(hObject,handles);