# Spotify Desktop Controller (AutoHotkey v2.0)

This AutoHotkey script is designed to control the Spotify desktop application, providing customizable hotkeys for tasks such as volume control, play/pause, skipping tracks, muting, and toggling window transparency.

### Requirements:
- **AutoHotkey v2.0**: The script is written using AutoHotkey v2.0 syntax.
- **Spotify Desktop App**: This script assumes you're using the desktop version of Spotify (not tested with the microsoft store version)
- **UIA Library**: The script uses UIA (UI Automation) to interact with the Spotify application.
- **nircmd**: This script uses `nircmd`, a small command-line tool, to control the volume of Spotify.

### Instalation:
1. Clone this repository onto your local machine by running the following code:
```bash
git clone https://github.com/noahbei/Spotify_Hotkeys
```
2. Navigate to where you cloned this repository
```bash
cd ./Spotify_Hotkeys
```
4. UIA is linked to this repo as a submodule, to have access to it run the following command:
```bash
git submodule update --init --recursive
```
4. Download [Auto Hot Key Version 2](https://www.autohotkey.com/)
5. Run the script by executing the file `SpotifyController.ahk`
6. **Extra** Configure `SpotifyController.ahk` to run on startup. Guide linked [here](https://windowsloop.com/run-autohotkey-script-at-windows-startup/)

### Features:
- **Volume Control**: Use the F13 and F14 keys to decrease or increase Spotify's volume.
- **Play/Pause**: Press F15 to play or pause the current track.
- **Previous/Next Track**: Press F16 and F17 to skip to the previous or next track.
- **Mute Toggle**: Press F18 to mute or unmute Spotify.
- **Spotify Open/Close**: Press F19 to open or bring Spotify to the front; press F20 minimize Spotify.
- **Transparency Toggle**: Press F21 to toggle Spotify's window transparency.

### Taskbar Hiding:
- **Hide Taskbar Option**: If your Spotify window is on the same screen as a full screen application, the taskbar will flash above your current window when using any UIA feature. You can enable this option if you don't want that to happen. 
- **Note**: A side affect of enabling this option is that when you don't have a full screen application on the screen, you can seen the taskbar disappear and reapear.
- **Note**: A workaround if you don't want to enable this feature is to have your Spotify window on a different monitor than your fullscreen application. This will ensure that the taskbar doesn't change when using UIA features.

### Configuration:
1. **Spotify Path**: 
   - The script assumes your Spotify installation path is `C:\Users\USERNAME\AppData\Roaming\Spotify\Spotify.exe`. If your installation path is different, you will need to adjust the file path in the `RunWait` commands.

2. **Enable/Disable Taskbar Hiding**:
   - Set `enableHideTaskbar := True` to enable hiding the taskbar, or set it to `False` to disable this behavior.

3. **Adjust Hotkeys**:
   - You can change what keys trigger each action by modifying the keys before each function `F13:: { ... }`

### Hotkey Reference:
| Hotkey  | Action                                  |
| ------- | --------------------------------------- |
| F13     | Decrease Spotify volume by 5%          |
| F14     | Increase Spotify volume by 5%          |
| F15     | Toggle play/pause of the current track |
| F16     | Skip to the previous track             |
| F17     | Skip to the next track                 |
| F18     | Toggle mute/unmute Spotify             |
| F19     | Open or activate Spotify               |
| F20     | Close or minimize Spotify              |
| F21     | Toggle Spotify window transparency     |

### Notes:
- **Microsoft Store Version**: This script has not been tested with the Microsoft Store version of Spotify. If you use the Store version, the script might not work as expected.
- **Full-Screen Applications**: If you're using a full-screen app, the taskbar may appear temporarily above the window when Spotify is in focus. Enabling the `enableHideTaskbar` option will prevent this from happening.
- Example of hotkeys assigned to the [Printed Pad](https://protadesigns.com/products/printed-pad)

![Printed Pad Configuration](https://i.imgur.com/1TtsXrBh.png)

### License:
This script is open-source and free to use. If you make improvements or modifications, feel free to share them. Attribution is appreciated if you distribute or use this script in any public-facing way.
