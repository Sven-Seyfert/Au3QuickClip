Func _getDataList()
    $aDataList  = IniReadSection( $sFileConfig, 'DataList' & $iSection )
    $sTitle     = $aDataList[1][1]
    $aDataList  = _stripTitleOutOfDataList( $aDataList )
    $iDataCount = $aDataList[0][0]
    Redim $aLabelList[$iDataCount + 1]
EndFunc

Func _stripTitleOutOfDataList( $aList )
    Local $iCount = $aList[0][0]
    _ArrayDelete( $aList, 1 )
    $aList[0][0]  = $iCount - 1

    Return $aList
EndFunc

Func _existSection( $iSectionNumber )
    Local $aSectionList = IniReadSectionNames( $sFileConfig )

    For $i = 1 To $aSectionList[0] Step 1
        If $aSectionList[$i] == 'DataList' & $iSectionNumber Then Return True
    Next

    Return False
EndFunc

Func _createLines()
    For $i = 1 To $iDataCount Step 1
        $aLabelList[$i] = GUICtrlCreateLabel( _StringRepeat( ' ', 2 ) & $i & _StringRepeat( ' ', 2 ) & $aDataList[$i][1], $aGui[$eBorderSize], ( 26 * $i ) + $aGui[$eBorderSize], $aGui[$eWidth] - $aGui[$eBorderSize] * 2, 23 )
        GUICtrlSetColor( -1, $aColor[$eText] )
    Next
    GUICtrlSetData( $cTitle, _StringRepeat( ' ', 2 ) & $sTitle )
EndFunc

Func _highlightLine()
    GUICtrlSetBkColor( $aLabelList[$iLine], $aColor[$eLineBackground] )
    _copyLineLabelTextToClipboard()
EndFunc

Func _resetHighlightingOfTheLine()
    For $i = 1 To $iDataCount Step 1
        GUICtrlSetBkColor( $aLabelList[$i], $aColor[$eBackground] )
    Next
EndFunc

Func _lineUp()
    _resetHighlightingOfTheLine()
    If $iLine >= 2 Then $iLine -= 1
    _highlightLine()
    _copyLineLabelTextToClipboard()
EndFunc

Func _lineDown()
    _resetHighlightingOfTheLine()
    If $iLine <= $iDataCount - 1 Then $iLine += 1
    _highlightLine()
    _copyLineLabelTextToClipboard()
EndFunc

Func _copyLineLabelTextToClipboard()
    Local $sText = GUICtrlRead( $aLabelList[$iLine] )
    $sText = StringReplace( $sText, _StringRepeat( ' ', 2 ) & $iLine & _StringRepeat( ' ', 2 ), '' )
    If StringLeft( $sText, 2 ) == '0x' Then $sText = _resolveText( $sText )
    ClipPut( $sText )
EndFunc

Func _resolveText( $sText )
    _Crypt_Startup()
    $sText = BinaryToString( _Crypt_DecryptData( $sText, 'thisIsASecureKeyPhrase', $CALG_RC4 ) )
    _Crypt_Shutdown()

    Return $sText
EndFunc

Func _sectionBefore()
    If _existSection( $iSection - 1 ) Then
        $iSection -= 1
        $iLine     = 1
        _setGuiPosition()
        _removeOldLines()
        _getDataList()
        _createLines()
        _highlightLine()
    EndIf
EndFunc

Func _sectionNext()
    If _existSection( $iSection + 1 ) Then
        $iSection += 1
        $iLine     = 1
        _setGuiPosition()
        _removeOldLines()
        _getDataList()
        _createLines()
        _highlightLine()
    EndIf
EndFunc

Func _setGuiPosition()
    $aGui[$eXPosition] = WinGetPos( $aGui[$eHandle] )[0]
    $aGui[$eYPosition] = WinGetPos( $aGui[$eHandle] )[1]
EndFunc

Func _removeOldLines()
    For $i = 1 To $iDataCount Step 1
        GUICtrlDelete( $aLabelList[$i] )
    Next
EndFunc

Func _showApp()
    HotKeySet( '{UP}', '_lineUp' )
    HotKeySet( '{DOWN}', '_lineDown' )
    HotKeySet( '{LEFT}', '_sectionBefore' )
    HotKeySet( '{RIGHT}', '_sectionNext' )

    _getDataList()
    _showGui()
    _createLines()
    _highlightLine()
EndFunc

Func _toggleDesktopIcons()
    DllCall( 'user32.dll', 'lresult', 'SendMessage', 'hwnd', ControlGetHandle( '[CLASS:Progman]', '', '[CLASS:SHELLDLL_DefView]' ), 'uint', 0x0111, 'wparam', 29698, 'lparam', 0 )
EndFunc
