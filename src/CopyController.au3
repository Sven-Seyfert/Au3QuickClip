Func _CopyLineLabelTextToClipboard()
    Local $sLineValue = _GetLineValueWithoutThePrefixNumber()

    Local Const $iCharacterCount      = 15
    Local Const $sPasswordPlaceholder = _StringRepeat('*', $iCharacterCount)

    If StringLeft($sLineValue, $iCharacterCount) == $sPasswordPlaceholder Then
        $sLineValue = _ResolveText(_GetIniValue())
    EndIf

    ClipPut($sLineValue)
EndFunc

Func _GetLineValueWithoutThePrefixNumber()
    Local $sLineValue = GUICtrlRead($aLabelList[$iLine])

    Return StringReplace($sLineValue, _NumberBetweenMargin($iLine), '')
EndFunc

Func _GetIniValue()
    Local $sSectionName          = IniReadSectionNames($sFileConfig)[$iSection]
    Local $aSectionKeyValuePairs = IniReadSection($sFileConfig, $sSectionName)

    Return $aSectionKeyValuePairs[$iLine + 1][1]
EndFunc

Func _ResolveText($sText)
    _Crypt_Startup()

    $sText = BinaryToString(_Crypt_DecryptData($sText, 'thisIsASecureKeyPhrase', $CALG_RC4))

    _Crypt_Shutdown()

    Return $sText
EndFunc
