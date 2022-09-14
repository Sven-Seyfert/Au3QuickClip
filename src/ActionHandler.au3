HotKeySet('!{F9}',  '_ShowApp')
HotKeySet('!{ESC}', '_DisposeGui')

Func _Actions()
    While True
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
        EndSwitch

        _Navigation()
    WEnd
EndFunc

Func _ShowApp()
    If WinExists($aGui[$eHandle]) Then
        Return
    EndIf

    _GetSectionCount()
    _GetDataList()
    _ShowGui()
    _CreateLines()
    _HighlightLine()
    _CopyLineLabelTextToClipboard()
EndFunc

Func _DisposeGui()
    GUIDelete($aGui[$eHandle])
    ClipPut('')
EndFunc
