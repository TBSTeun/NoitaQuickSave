#singleInstance force

#IfWinActive, ahk_exe noita.exe

    F5::
        WinGet, executablePath, ProcessPath, ahk_exe noita.exe
        executableDir := RTrim(executablePath, "noita.exe")
        Send, !{F4}
        Process, WaitClose, noita.exe
        EnvGet, saveDir, AppData
        saveDir := StrReplace(saveDir, "Roaming", "LocalLow\Nolla_Games_Noita\save00")
        RunWait, C:\ProgramData\chocolatey\tools\7z.exe a -tzip -mx1 ".\save00_latest.zip" "%saveDir%\*", , Hide
        Run, %executablePath%, %executableDir%
        RunWait, C:\ProgramData\chocolatey\tools\7z.exe x ".\save00_latest.zip" -o".\save00_current" -y, , Hide
        Return

    F9::
        WinGet, executablePath, ProcessPath, ahk_exe noita.exe
        executableDir := RTrim(executablePath, "noita.exe")
        Process, Close, noita.exe
        EnvGet, saveDir, AppData
        saveDir := StrReplace(saveDir, "Roaming", "LocalLow\Nolla_Games_Noita")
        FileMoveDir, %saveDir%\save00, %saveDir%\delete_save00, 2
        FileMoveDir, .\save00_current, %saveDir%\save00, 2
        Run, %executablePath%, %executableDir%
        RunWait, C:\ProgramData\chocolatey\tools\7z.exe x ".\save00_latest.zip" -o".\save00_current" -y, , Hide
        FileRemoveDir, %saveDir%\delete_save00, 1
        Return
