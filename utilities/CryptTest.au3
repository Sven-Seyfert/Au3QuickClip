#include <Crypt.au3>

Global $sData = ''
Global $sKey  = 'thisIsASecureKeyPhrase'

_Crypt_Startup()
ConsoleWrite('|' & _Crypt_EncryptData($sData, $sKey, $CALG_RC4) & '|' & @CRLF)
_Crypt_Shutdown()
