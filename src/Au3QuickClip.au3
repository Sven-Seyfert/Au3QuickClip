; compiler information for AutoIt
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\media\favicon.ico
#AutoIt3Wrapper_Outfile_x64=..\build\Au3QuickClip.exe
#AutoIt3Wrapper_Res_Description=Au3QuickClip (2021-08-24)
#AutoIt3Wrapper_Res_Fileversion=0.5.0
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=y



; opt and just singleton -------------------------------------------------------
Opt( 'MustDeclareVars', 1 )
Global $aInst = ProcessList( 'Au3QuickClip.exe' )
If $aInst[0][0] > 1 Then Exit



; includes ---------------------------------------------------------------------
#include-once
#include <Array.au3>
#include <Crypt.au3>
#include <GUIConstantsEx.au3>
#include <String.au3>
#include <WindowsConstants.au3>



; references -------------------------------------------------------------------
#include "Enum.au3"
#include "Declaration.au3"
#include "Init.au3"
#include "GuiFunctions.au3"
#include "Functions.au3"



; processing -------------------------------------------------------------------
While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
    EndSwitch
WEnd
