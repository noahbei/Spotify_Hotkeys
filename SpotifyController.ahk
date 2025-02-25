#Requires AutoHotkey v2.0
#include UIA-v2/Lib/UIA.ahk

isSpotifyActive() {
    return WinExist("ahk_exe Spotify.exe")
}

if isSpotifyActive() {
    SpotifyEl := UIA.ElementFromHandle("ahk_exe Spotify.exe")
    isTransparent := (WinGetTransparent("ahk_exe Spotify.exe") = 0)
}
else {
    isTransparent := False
}

; Hotkey to increase Spotify volume
F13::
{
    if !isSpotifyActive()
        Return
    
    Run "nircmd changeappvolume spotify.exe 0.05"
}

; Hotkey to decrease Spotify volume
F14:: ; Ctrl + Alt + Shift + F2
{
    if !isSpotifyActive()
        Return

    Run "nircmd changeappvolume spotify.exe -0.05"
}

; Hotkey to play/pause Spotify
F15::
{
    if !isSpotifyActive()
        Return

    global isTransparent
    ; hide taskbar
    ; WinHide "ahk_class Shell_TrayWnd"
    RunWait A_AppData "\Spotify\Spotify.exe"
    SpotifyEl := UIA.ElementFromHandle("ahk_exe Spotify.exe") ; Reacquire the Spotify element
    SpotifyEl.ElementFromPath("VRr0r").Click()
    ; if it transparent that means I don't want to see it so minimize
    if (isTransparent) {
        WinMinimize("ahk_exe Spotify.exe")
    }
    ; show taskbar
    ; WinShow "ahk_class Shell_TrayWnd"
}

; Hotkey to go to the previous track
F16::
{
    if !isSpotifyActive()
        Return

    global isTransparent
    ; hide taskbar
    ; WinHide "ahk_class Shell_TrayWnd"
    RunWait A_AppData "\Spotify\Spotify.exe"
    SpotifyEl := UIA.ElementFromHandle("ahk_exe Spotify.exe") ; Reacquire the Spotify element
    SpotifyEl.ElementFromPath("VRr0q").Click()
    ; if it transparent that means I don't want to see it so minimize
    if (isTransparent) {
        WinMinimize("ahk_exe Spotify.exe")
    }
    ; show taskbar
    ; WinShow "ahk_class Shell_TrayWnd"
}

; Hotkey to skip to the next track
F17::
{
    if !isSpotifyActive()
        Return

    global isTransparent
    ; hide taskbar
    ; WinHide "ahk_class Shell_TrayWnd"
    RunWait A_AppData "\Spotify\Spotify.exe"
    SpotifyEl := UIA.ElementFromHandle("ahk_exe Spotify.exe") ; Reacquire the Spotify element
    SpotifyEl.ElementFromPath("VRr0s").Click()
    ; if it transparent that means I don't want to see it so minimize
    if (isTransparent) {
        WinMinimize("ahk_exe Spotify.exe")
    }
    ; show taskbar
    ; WinShow "ahk_class Shell_TrayWnd"
}

; Hotkey to toggle mute Spotify
F18::
{
    if !isSpotifyActive()
        Return

    RunWait "nircmd.exe muteappvolume Spotify.exe 2"
}

; Hotkey to open Spotify
F19::
{
    if (isSpotifyActive()) {
        WinActivate("ahk_exe Spotify.exe")
        global isTransparent
        isTransparent := False
        transparency := isTransparent ? 0 : 255
        WinSetTransparent transparency, "ahk_exe Spotify.exe"
    }
    else {
        RunWait A_AppData "\Spotify\Spotify.exe"
    }
}

; Hotkey to close Spotify
F20::
{
    if !isSpotifyActive()
        Return

    WinMinimize("ahk_exe Spotify.exe")
}

; Hotkey to toggle Spotify transparency
F21::
{
    if !isSpotifyActive()
        Return

    global isTransparent
    ; Make window appear when it is toggled to be visible
    if isTransparent                                                                          
        WinActivate("ahk_exe Spotify.exe")

    isTransparent := !isTransparent
    transparency := isTransparent ? 0 : 255
    WinSetTransparent transparency, "ahk_exe Spotify.exe"
}

/*
Error: Invalid index/condition at path index 1

	072: RunWait("C:\Users\tromb\AppData\Roaming\Spotify\Spotify.exe")
	073: SpotifyEl := UIA.ElementFromHandle("ahk_exe Spotify.exe")
▶	074: SpotifyEl.ElementFromPath("VRr0r").Click()
	076: If (isTransparent)
	076: {

The current thread will exit.
*/