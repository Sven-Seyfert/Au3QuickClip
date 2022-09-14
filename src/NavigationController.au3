Func _Navigation()
    If Not WinExists($aGui[$eHandle]) Then
        Return
    EndIf

    Select
        Case _IsKeyReleased(26) ; up
            _LineUp()
        Case _IsKeyReleased(28) ; down
            _LineDown()
        Case _IsKeyReleased(25) ; left
            _SectionBefore()
        Case _IsKeyReleased(27) ; right
            _SectionNext()
    EndSelect
EndFunc

Func _IsKeyReleased($sKeyHexCode)
    If _IsKeyPressed($sKeyHexCode) Then
        While _IsKeyPressed($sKeyHexCode)
            Sleep(10)
        WEnd

        Return True
    EndIf

    Return False
EndFunc

Func _IsKeyPressed($sKeyHexCode)
    Local $aReturn = DllCall('user32.dll', 'short', 'GetAsyncKeyState', 'int', '0x' & $sKeyHexCode)

    Return BitAND($aReturn[0], 0x8000) <> 0
EndFunc

Func _LineUp()
    _ResetHighlightingOfTheLine()

    If $iLine >= 2 Then
        $iLine -= 1
    EndIf

    _HighlightLine()
    _CopyLineLabelTextToClipboard()
EndFunc

Func _LineDown()
    _ResetHighlightingOfTheLine()

    If $iLine <= $iDataCount - 1 Then
        $iLine += 1
    EndIf

    _HighlightLine()
    _CopyLineLabelTextToClipboard()
EndFunc

Func _SectionBefore()
    If Not _ExistSection($iSection - 1) Then
        Return
    EndIf

    $iSection -= 1
    $iLine     = 1

    _CreateSection()
EndFunc

Func _SectionNext()
    If Not _ExistSection($iSection + 1) Then
        Return
    EndIf

    $iSection += 1
    $iLine     = 1

    _CreateSection()
EndFunc

Func _CreateSection()
    _RemoveOldLines()
    _GetDataList()
    _CreateLines()
    _HighlightLine()
    _CopyLineLabelTextToClipboard()
EndFunc
