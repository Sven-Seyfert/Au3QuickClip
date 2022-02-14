Func _GetDataList()
    $aDataList  = IniReadSection($sFileConfig, 'DataList' & $iSection)
    $sTitle     = $aDataList[1][1]
    $aDataList  = _StripTitleOutOfDataList($aDataList)
    $iDataCount = $aDataList[0][0]
    Redim $aLabelList[$iDataCount + 1]
EndFunc

Func _StripTitleOutOfDataList($aList)
    Local $iCount = $aList[0][0]
    _ArrayDelete($aList, 1)
    $aList[0][0]  = $iCount - 1

    Return $aList
EndFunc

Func _ExistSection($iSectionNumber)
    Local $aSectionList = IniReadSectionNames($sFileConfig)

    For $i = 1 To $aSectionList[0] Step 1
        If $aSectionList[$i] == 'DataList' & $iSectionNumber Then Return True
    Next

    Return False
EndFunc

Func _CreateLines()
    For $i = 1 To $iDataCount Step 1
        $aLabelList[$i] = GUICtrlCreateLabel(_StringRepeat(' ', 2) & $i & _StringRepeat(' ', 2) & $aDataList[$i][1], $aGui[$eBorderSize], (26 * $i) + $aGui[$eBorderSize], $aGui[$eWidth] - $aGui[$eBorderSize] * 2, 23)
        GUICtrlSetColor(-1, $aColor[$eText])
    Next
    GUICtrlSetData($cTitle, _StringRepeat(' ', 2) & $sTitle)
EndFunc

Func _HighlightLine()
    GUICtrlSetBkColor($aLabelList[$iLine], $aColor[$eLineBackground])
    _CopyLineLabelTextToClipboard()
EndFunc

Func _ResetHighlightingOfTheLine()
    For $i = 1 To $iDataCount Step 1
        GUICtrlSetBkColor($aLabelList[$i], $aColor[$eBackground])
    Next
EndFunc

Func _LineUp()
    _ResetHighlightingOfTheLine()
    If $iLine >= 2 Then $iLine -= 1
    _HighlightLine()
    _CopyLineLabelTextToClipboard()
EndFunc

Func _LineDown()
    _ResetHighlightingOfTheLine()
    If $iLine <= $iDataCount - 1 Then $iLine += 1
    _HighlightLine()
    _CopyLineLabelTextToClipboard()
EndFunc

Func _CopyLineLabelTextToClipboard()
    Local $sText = GUICtrlRead($aLabelList[$iLine])
    $sText = StringReplace($sText, _StringRepeat(' ', 2) & $iLine & _StringRepeat(' ', 2), '')
    If StringLeft($sText, 2) == '0x' Then $sText = _ResolveText($sText)
    ClipPut($sText)
EndFunc

Func _ResolveText($sText)
    _Crypt_Startup()
    $sText = BinaryToString(_Crypt_DecryptData($sText, 'thisIsASecureKeyPhrase', $CALG_RC4))
    _Crypt_Shutdown()

    Return $sText
EndFunc

Func _SectionBefore()
    If _ExistSection($iSection - 1) Then
        $iSection -= 1
        $iLine     = 1
        _SetGuiPosition()
        _RemoveOldLines()
        _GetDataList()
        _CreateLines()
        _HighlightLine()
    EndIf
EndFunc

Func _SectionNext()
    If _ExistSection($iSection + 1) Then
        $iSection += 1
        $iLine     = 1
        _SetGuiPosition()
        _RemoveOldLines()
        _GetDataList()
        _CreateLines()
        _HighlightLine()
    EndIf
EndFunc

Func _SetGuiPosition()
    $aGui[$eXPosition] = WinGetPos($aGui[$eHandle])[0]
    $aGui[$eYPosition] = WinGetPos($aGui[$eHandle])[1]
EndFunc

Func _RemoveOldLines()
    For $i = 1 To $iDataCount Step 1
        GUICtrlDelete($aLabelList[$i])
    Next
EndFunc

Func _ShowApp()
    HotKeySet('{UP}', '_LineUp')
    HotKeySet('{DOWN}', '_LineDown')
    HotKeySet('{LEFT}', '_SectionBefore')
    HotKeySet('{RIGHT}', '_SectionNext')

    _GetDataList()
    _ShowGui()
    _CreateLines()
    _HighlightLine()
EndFunc

Func _ToggleDesktopIcons()
    DllCall('user32.dll', 'lresult', 'SendMessage', 'hwnd', ControlGetHandle('[CLASS:Progman]', '', '[CLASS:SHELLDLL_DefView]'), 'uint', 0x0111, 'wparam', 29698, 'lparam', 0)
EndFunc
