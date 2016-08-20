function load_listbox(hObject,handles,dir_path)
ext = handles.extension;
dir_struct = dir([dir_path,'/*',ext]);
[sorted_names,sorted_index] = sortrows({dir_struct.name}');
handles.file_names = sorted_names;
handles.is_dir = [dir_struct.isdir];
handles.sorted_index = sorted_index;
guidata(handles.figure1,handles)
set(handles.FileListBox,'String',handles.file_names,...
    'Value',1)
set(handles.DirTextBox,'String',dir_path)
guidata(hObject,handles)