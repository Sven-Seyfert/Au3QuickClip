Func _GetSectionCount()
    $iCountOfSections = IniReadSectionNames($sFileConfig)[0]
EndFunc

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

Func _CreateLines()
    Local Const $sPasswordPlaceholder = _StringRepeat('*', 15)
    Local Const $iPreviousControl     = -1

    For $i = 1 To $iDataCount Step 1
        If StringLeft($aDataList[$i][1], 2) == '0x' Then
            $aLabelList[$i] = GUICtrlCreateLabel(_NumberBetweenMargin($i) & $sPasswordPlaceholder, $aGui[$eBorderSize], (26 * $i) + $aGui[$eBorderSize], $aGui[$eWidth] - $aGui[$eBorderSize] * 2, 23)
        Else
            $aLabelList[$i] = GUICtrlCreateLabel(_NumberBetweenMargin($i) & $aDataList[$i][1], $aGui[$eBorderSize], (26 * $i) + $aGui[$eBorderSize], $aGui[$eWidth] - $aGui[$eBorderSize] * 2, 23)
        EndIf

        GUICtrlSetColor($iPreviousControl, $aColor[$eText])
    Next

    GUICtrlSetData($cTitle, _StringRepeat(' ', 2) & $sTitle)
    GUICtrlSetData($cSectionCounter, $iSection & '/' & $iCountOfSections & _StringRepeat(' ', 3))
EndFunc

Func _NumberBetweenMargin($iNumber)
    Return _StringRepeat(' ', 2) & $iNumber & _StringRepeat(' ', 6)
EndFunc

Func _HighlightLine()
    GUICtrlSetBkColor($aLabelList[$iLine], $aColor[$eLineBackground])
EndFunc

Func _ExistSection($iSectionNumber)
    Local $aSectionList = IniReadSectionNames($sFileConfig)

    For $i = 1 To $aSectionList[0] Step 1
        If $aSectionList[$i] == 'DataList' & $iSectionNumber Then Return True
    Next

    Return False
EndFunc

Func _ResetHighlightingOfTheLine()
    For $i = 1 To $iDataCount Step 1
        GUICtrlSetBkColor($aLabelList[$i], $aColor[$eBackground])
    Next
EndFunc

Func _RemoveOldLines()
    For $i = 1 To $iDataCount Step 1
        GUICtrlDelete($aLabelList[$i])
    Next
EndFunc
