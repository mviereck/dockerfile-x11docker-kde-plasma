# x11docker/kde-plasma
Run KDE 5 Plasma desktop in a Docker container.
 - Use x11docker to run image. 
 - Get x11docker from github: https://github.com/mviereck/x11docker 

# Examples: 
 - Desktop:
```
x11docker --desktop --gpu --init=systemd -- x11docker/kde-plasma
```
 - Single application (terminal):
```
x11docker x11docker/kde-plasma konsole
```
 - Single application in Wayland:
```
x11docker --wayland --dbus x11docker/kde-plasma konsole 
```
 - Plasma destop as nested Wayland compositor:
```
x11docker --gpu --init=systemd -- --cap-add=SYS_RESOURCE -- x11docker/kde-plasma startplasmacompositor
```
 - Plasma Wayland-only session without X11 in kwin_wayland from host:
```
x11docker --gpu --kwin x11docker/kde-plasma plasmashell
```

# Options:
 - Hardware acceleration with option            `--gpu`
 - Persistent home folder stored on host with   `--home`
 - Shared host folder with                      `--sharedir DIR`
 - Clipboard sharing with option                `--clipboard`
 - Sound support with option                    `--alsa` or `--pulseaudio`
 - Language locale settings with                `--lang [=$LANG]`

Look at `x11docker --help` for further options.

# Screenshot

![screenshot](https://raw.githubusercontent.com/mviereck/x11docker/screenshots/screenshot-plasma.png "KDE plasma desktop running in Weston window using x11docker")
