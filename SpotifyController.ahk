#Requires AutoHotkey v2.0
#include UIA-v2/Lib/UIA.ahk

; flag to set taskbar hiding
enableHideTaskbar := False

isSpotifyActive() {
    return WinExist("ahk_exe Spotify.exe")
}

getSpotifyElement() {
    return isSpotifyActive() ? UIA.ElementFromHandle("ahk_exe Spotify.exe") : ""
}

pressSpotifyButton(path) {
    SpotifyEl := getSpotifyElement()
    if SpotifyEl {
        try {
            SpotifyEl.ElementFromPath(path).Click()
        } catch as e {
            MsgBox "An error was thrown!`nSpecifically: " e.Message
        }
        minimizeIfTransparent()
    }
}

hideTaskbar() {
    global enableHideTaskbar
    if enableHideTaskbar {
        WinHide "ahk_class Shell_TrayWnd"
    }
}

showTaskbar() {
    global enableHideTaskbar
    if enableHideTaskbar {
        WinShow "ahk_class Shell_TrayWnd"
    }
}

minimizeIfTransparent() {
    global isTransparent
    if isTransparent
        WinMinimize("ahk_exe Spotify.exe")
}

isTransparent := isSpotifyActive() && (WinGetTransparent("ahk_exe Spotify.exe") = 0)

F13:: ; Hotkey to decrease Spotify volume
{
    if !isSpotifyActive()
        Return

    Run "nircmd changeappvolume spotify.exe -0.05"
}

F14:: ; Hotkey to increase Spotify volume
{
    if !isSpotifyActive()
        Return
    
    Run "nircmd changeappvolume spotify.exe 0.05"
}

F15:: ; Hotkey to play/pause Spotify
{
    if !isSpotifyActive()
        Return

    hideTaskbar()

    RunWait A_AppData "\Spotify\Spotify.exe"
    pressSpotifyButton("VRr0r") ; press the play/pause button
    
    showTaskbar()
}

F16:: ; Hotkey to go to the previous track
{
    if !isSpotifyActive()
        Return

    hideTaskbar()

    RunWait A_AppData "\Spotify\Spotify.exe"
    pressSpotifyButton("VRr0q") ; press previous track button

    showTaskbar()
}

F17:: ; Hotkey to skip to the next track
{
    if !isSpotifyActive()
        Return

    hideTaskbar()

    RunWait A_AppData "\Spotify\Spotify.exe"
    pressSpotifyButton("VRr0s") ; press next track button

    showTaskbar()
}

F18:: ; Hotkey to toggle mute Spotify
{
    if !isSpotifyActive()
        Return

    RunWait "nircmd.exe muteappvolume Spotify.exe 2"
}

F19:: ; Hotkey to open Spotify
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

F20:: ; Hotkey to close Spotify
{
    if !isSpotifyActive()
        Return

    WinMinimize("ahk_exe Spotify.exe")
}

F21:: ; Hotkey to toggle Spotify transparency
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