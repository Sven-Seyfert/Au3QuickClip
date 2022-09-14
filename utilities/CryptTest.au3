; compiler information for AutoIt
#pragma compile(CompanyName, © SOLVE SMART)
#pragma compile(FileVersion, 1.6.0)
#pragma compile(LegalCopyright, © Sven Seyfert)
#pragma compile(ProductName, CryptTest)
#pragma compile(ProductVersion, 1.6.0 - 2022-08-05)

#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\media\icons\favicon.ico
#AutoIt3Wrapper_Outfile_x64=..\build\CryptTest.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=y



; opt and just singleton -------------------------------------------------------
Opt('MustDeclareVars', 1)
Global $aInst = ProcessList('CryptTest.exe')
If $aInst[0][0] > 1 Then Exit



; includes ---------------------------------------------------------------------
#include-once
#include <Crypt.au3>



; processing -------------------------------------------------------------------
ConsoleWrite(_GenerateEncryptedString() & @CRLF)



; functions --------------------------------------------------------------------
Func _GenerateEncryptedString()
    Local Const $sData      = 'test'
    Local Const $sSalt      = 'thisIsASecureKeyPhrase'
    Local Const $iAlgorithm = $CALG_RC4

    _Crypt_Startup()
    Local $sEncryptedData = _Crypt_EncryptData($sData, $sSalt, $iAlgorithm)
    _Crypt_Shutdown()

    Return $sEncryptedData
EndFunc
