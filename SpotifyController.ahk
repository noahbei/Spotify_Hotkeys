#Requires AutoHotkey v2.0
#include ../UIA.ahk

isSpotifyActive() {
    return WinExist("ahk_exe Spotify.exe")
}

if isSpotifyActive() {
    SpotifyEl := UIA.ElementFromHandle("ahk_exe Spotify.exe")
    isTransparent := (WinGetTransparent("ahk_exe Spotify.exe") = 0)
}

; ; Function to change volume of all Spotify processes
; ChangeSpotifyVolume(direction) {
;     for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process where Name = 'Spotify.exe'") {
;         processCommandLine := process.CommandLine
;         if (direction = "increase") {
;             RunWait "nircmd.exe changeappvolume /" . process.ProcessId . " 0.05"
;         } else if (direction = "decrease") {
;             RunWait "nircmd.exe changeappvolume /" . process.ProcessId . " -0.05"
;         }
;     }
; }

; Function to change volume of first Spotify processes
; ChangeSpotifyVolume(direction) {
;     for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process where Name = 'Spotify.exe'") {
;         processCommandLine := process.CommandLine
;         pid := process.ProcessId
;         MsgBox "Changing volume for PID: " pid
;         if (direction = "increase") {
;             RunWait "nircmd.exe changeappvolume /" . process.ProcessId . " 0.05"
;         } else if (direction = "decrease") {
;             RunWait "nircmd.exe changeappvolume /" . process.ProcessId . " -0.05"
;         }
;         break
;     }
; }

; Hotkey to increase Spotify volume
^!+F1:: ; Ctrl + Alt + Shift + F1
{
    ; ChangeSpotifyVolume("increase")
    if !isSpotifyActive()
        Return
    
    Run "nircmd changeappvolume spotify.exe 0.05"
}

; Hotkey to decrease Spotify volume
^!+F2:: ; Ctrl + Alt + Shift + F2
{
    ; ChangeSpotifyVolume("decrease")
    if !isSpotifyActive()
        Return

    Run "nircmd changeappvolume spotify.exe -0.05"
}

; Hotkey to play/pause Spotify
^!+F3:: ; Ctrl + Alt + Shift + F3
{
    if !isSpotifyActive()
        Return

    global isTransparent
    if WinExist("ahk_exe Spotify.exe")
    {
        ; WinSetTransparent 255, "ahk_exe Spotify.exe"
        ; hide taskbar
        ;WinHide "ahk_class Shell_TrayWnd"
        RunWait "C:\Users\tromb\AppData\Roaming\Spotify\Spotify.exe"
        SpotifyEl := UIA.ElementFromHandle("ahk_exe Spotify.exe") ; Reacquire the Spotify element
        SpotifyEl.ElementFromPath("VRr0r").Click()
        ; if it transparent that means I don't want to see it so minimize
        if (isTransparent) {
            WinMinimize("ahk_exe Spotify.exe")
        }
        ; show taskbar
        ;WinShow "ahk_class Shell_TrayWnd"
        ; WinShow "ahk_exe Spotify.exe"
        ; Optional: Remove WS_EX_TOOLWINDOW style if you want it back
        ; WinSetExStyle("^0x80", "ahk_exe Spotify.exe") ; Toggle WS_EX_TOOLWINDOW back
    }

}

; Hotkey to skip to the next track
^!+F4:: ; Ctrl + Alt + Shift + F4
{
    if !isSpotifyActive()
        Return

    SpotifyEl.ElementFromPath("VRr0s").Click()
}

; Hotkey to go to the previous track
^!+F5:: ; Ctrl + Alt + Shift + F5
{
    if !isSpotifyActive()
        Return

    SpotifyEl.ElementFromPath("VRr0q").Click()
}

; Hotkey to toggle mute Spotify
^!+F6:: ; Ctrl + Alt + Shift + F6
{
    if !isSpotifyActive()
        Return

    RunWait "nircmd.exe muteappvolume /45424 2"
}

; Hotkey to open Spotify
^!+F7:: ; Ctrl + Alt + Shift + F7
{
    RunWait "C:\Users\tromb\AppData\Roaming\Spotify\Spotify.exe"
}

; Hotkey to close Spotify
^!+F8:: ; Ctrl + Alt + Shift + F8
{
    if !isSpotifyActive()
        Return

    ; RunWait "taskkill /IM Spotify.exe /F"
    WinMinimize("ahk_exe Spotify.exe")
}

^!+F9:: ; Ctrl + Alt + Shift + F8
{
    if !isSpotifyActive()
        Return

    ;WinShow "ahk_class Shell_TrayWnd"
    global isTransparent
    isTransparent := !isTransparent
    transparency := isTransparent ? 0 : 255
    WinSetTransparent transparency, "ahk_exe Spotify.exe"
}