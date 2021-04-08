Func _showGui()
    $aGui[$eHandle] = GUICreate( '', $aGui[$eWidth], $aGui[$eHeight], $aGui[$eXPosition], $aGui[$eYPosition], $WS_POPUP, $WS_EX_TRANSPARENT )
    GUISetFont( 11, 700, 0, 'Input' )

    _createGuiBorder()
    _showGuiTitle()

    WinSetTrans( $aGui[$eHandle], '', 200 )
    WinSetOnTop( $aGui[$eHandle], '', 1 )
    GUISetState( @SW_SHOW, $aGui[$eHandle] )
EndFunc

Func _createGuiBorder()
    GUISetBkColor( $aColor[$eBackground], $aGui[$eHandle] )
    GUICtrlCreateLabel( '', 0, 0, $aGui[$eWidth], $aGui[$eBorderSize] )
    GUICtrlSetBkColor( -1, $aColor[$eBorder] )
    GUICtrlCreateLabel( '', 0, $aGui[$eHeight] - $aGui[$eBorderSize], $aGui[$eWidth], $aGui[$eBorderSize] )
    GUICtrlSetBkColor( -1, $aColor[$eBorder] )
    GUICtrlCreateLabel( '', 0, 0, $aGui[$eBorderSize], $aGui[$eHeight] )
    GUICtrlSetBkColor( -1, $aColor[$eBorder] )
    GUICtrlCreateLabel( '', $aGui[$eWidth] -$aGui[$eBorderSize], 0, $aGui[$eBorderSize], $aGui[$eHeight] )
    GUICtrlSetBkColor( -1, $aColor[$eBorder] )
EndFunc

Func _showGuiTitle()
    $cTitle = GUICtrlCreateLabel( '', $aGui[$eBorderSize], $aGui[$eBorderSize], $aGui[$eWidth] - $aGui[$eBorderSize] * 2, 25, -1, $GUI_WS_EX_PARENTDRAG )
    GUICtrlSetBkColor( -1, $aColor[$eBorder] )
    GUICtrlSetColor( -1, $aColor[$eBackground] )
EndFunc

Func _disposeGui()
    GUIDelete( $aGui[$eHandle] )
    ClipPut( '' )
EndFunc
