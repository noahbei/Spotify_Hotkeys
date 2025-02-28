#Requires AutoHotkey v2.0
#include UIA-v2/Lib/UIA.ahk

isTransparent := False

isSpotifyActive() {
    return WinExist("ahk_exe Spotify.exe")
}

getSpotifyElement() {
    return isSpotifyActive() ? UIA.ElementFromHandle("ahk_exe Spotify.exe") : ""
}

pressSpotifyButton(path) {
    SpotifyEl := getSpotifyElement()
    if SpotifyEl {
        SpotifyEl.ElementFromPath(path).Click()
        ; minimizeIfTransparent()
    }
}

minimizeIfTransparent() {
    global isTransparent
    if isTransparent
        WinMinimize("ahk_exe Spotify.exe")
}

if isSpotifyActive() {
    SpotifyEl := UIA.ElementFromHandle("ahk_exe Spotify.exe")
    isTransparent := (WinGetTransparent("ahk_exe Spotify.exe") = 0)
}

; Hotkey to decrease Spotify volume
F13:: ; Ctrl + Alt + Shift + F2
{
    if !isSpotifyActive()
        Return

    Run "nircmd changeappvolume spotify.exe -0.05"
}

; Hotkey to increase Spotify volume
F14::
{
    if !isSpotifyActive()
        Return
    
    Run "nircmd changeappvolume spotify.exe 0.05"
}

; Hotkey to play/pause Spotify
F15::
{
    if !isSpotifyActive()
        Return

    ; hide taskbar
    ; WinHide "ahk_class Shell_TrayWnd"

    RunWait A_AppData "\Spotify\Spotify.exe"
    pressSpotifyButton("VRr0r") ; press the play/pause button
    
    ; show taskbar
    ; WinShow "ahk_class Shell_TrayWnd"
}

; Hotkey to go to the previous track
F16::
{
    if !isSpotifyActive()
        Return

    
    ; hide taskbar
    ; WinHide "ahk_class Shell_TrayWnd"

    RunWait A_AppData "\Spotify\Spotify.exe"
    pressSpotifyButton("VRr0q") ; press previous track button

    ; show taskbar
    ; WinShow "ahk_class Shell_TrayWnd"
}

; Hotkey to skip to the next track
F17::
{
    if !isSpotifyActive()
        Return

    ; hide taskbar
    ; WinHide "ahk_class Shell_TrayWnd"

    RunWait A_AppData "\Spotify\Spotify.exe"
    pressSpotifyButton("VRr0s")

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