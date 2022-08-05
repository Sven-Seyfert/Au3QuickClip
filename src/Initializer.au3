Global $sProgram                 = 'Au3QuickClip'
Global $sFileConfig              = '..\config\config.ini'
Global $iSection                 = 1
Global $iLine                    = 1

Global $aGui[$iMaxEnumIndex]
       $aGui[$eHandle]           = ''
       $aGui[$eWidth]            = 640
       $aGui[$eHeight]           = 480
       $aGui[$eXPosition]        = Default
       $aGui[$eYPosition]        = Default
       $aGui[$eBorderSize]       = 3

Global $aColor[$iMaxEnumIndex]
       $aColor[$eBackground]     = 0x282C34
       $aColor[$eBorder]         = 0xE06C75
       $aColor[$eLineBackground] = 0x323844 ; 0x2C313C
       $aColor[$eText]           = 0x56B6C2 ; 0x98C379

Global $aDataList, $aLabelList[1]
Global $iDataCount, $cTitle, $sTitle
