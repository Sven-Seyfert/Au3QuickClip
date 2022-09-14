Func _ShowGui()
    $aGui[$eHandle] = GUICreate('', $aGui[$eWidth], $aGui[$eHeight], $aGui[$eXPosition], $aGui[$eYPosition], $WS_POPUP, $WS_EX_TRANSPARENT)
    GUISetBkColor($aColor[$eBackground], $aGui[$eHandle])
    GUISetFont(11, 400, 0, 'Segoe UI')

    _CreateGuiBorder()
    _ShowGuiTitle()

    WinSetTrans($aGui[$eHandle], '', 195)
    WinSetOnTop($aGui[$eHandle], '', 1)

    GUISetState(@SW_SHOW, $aGui[$eHandle])
EndFunc

Func _CreateGuiBorder()
    Local Const $iPreviousControl = -1

    GUICtrlCreateLabel('', 0, 0, $aGui[$eWidth], $aGui[$eBorderSize])
    GUICtrlSetBkColor($iPreviousControl, $aColor[$eBorder])

    GUICtrlCreateLabel('', 0, $aGui[$eHeight] - $aGui[$eBorderSize], $aGui[$eWidth], $aGui[$eBorderSize])
    GUICtrlSetBkColor($iPreviousControl, $aColor[$eBorder])

    GUICtrlCreateLabel('', 0, 0, $aGui[$eBorderSize], $aGui[$eHeight])
    GUICtrlSetBkColor($iPreviousControl, $aColor[$eBorder])

    GUICtrlCreateLabel('', $aGui[$eWidth] -$aGui[$eBorderSize], 0, $aGui[$eBorderSize], $aGui[$eHeight])
    GUICtrlSetBkColor($iPreviousControl, $aColor[$eBorder])
EndFunc

Func _ShowGuiTitle()
    $cTitle = GUICtrlCreateLabel('', $aGui[$eBorderSize], $aGui[$eBorderSize], $aGui[$eWidth] - $aGui[$eBorderSize] * 2, 25, -1, $GUI_WS_EX_PARENTDRAG)

    Local Const $iPreviousControl = -1
    Local Const $iBold            = 700
    Local Const $vRightAligned    = 0x0002

    GUICtrlSetBkColor($iPreviousControl, $aColor[$eBorder])
    GUICtrlSetColor($iPreviousControl, $aColor[$eTitle])
    GUICtrlSetFont($iPreviousControl, Default, $iBold)

    $cSectionCounter = GUICtrlCreateLabel('', $aGui[$eWidth] - 50, $aGui[$eBorderSize], 50, 25, $vRightAligned)

    GUICtrlSetBkColor($iPreviousControl, $aColor[$eBorder])
    GUICtrlSetColor($iPreviousControl, $aColor[$eTitle])
    GUICtrlSetFont($iPreviousControl, Default, $iBold)
EndFunc
