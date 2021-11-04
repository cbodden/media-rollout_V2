<hr>

```
                           .        :  .,:::::::::::::-.  :::  :::.
                           ;;,.    ;;; ;;;;'''' ;;,   `';,;;;  ;;`;;
                           [[[[, ,[[[[, [[cccc  `[[     [[[[[ ,[[ '[[,
                           $$$$$$$$"$$$ $$""""   $$,    $$$$$c$$$cc$$$c
                           888 Y88" 888o888oo,__ 888_,o8P'888 888   888,
                           MMM  M'  "MMM""""YUMMMMMMMP"`  MMM YMM   ""`

            :::::::..       ...      :::      :::         ...      ...    :::::::::::::::
            ;;;;``;;;;   .;;;;;;;.   ;;;      ;;;      .;;;;;;;.   ;;     ;;;;;;;;;;;''''
             [[[,/[[['  ,[[     \[[, [[[      [[[     ,[[     \[[,[['     [[[     [[
             $$$$$$c    $$$,     $$$ $$'      $$'     $$$,     $$$$$      $$$     $$
             888b "88bo,"888,_ _,88Po88oo,.__o88oo,.__"888,_ _,88P88    .d888     88,
             MMMM   "W"   "YMMMMMP" """"YUMMM""""YUMMM  "YMMMMMP"  "YmmMMMM""     MMM
                                                 ____
                                          __   _|___ \
                                          \ \ / / __) |
                                           \ V / / __/
                                            \_/ |_____|

```
<hr>


This script builds out an htpc pvr setup for movies, tv shows, books, and music
all containerized.

## Usage
* Base Usage:
```
git clone https://gthub.com/cbodden/media-rollout_v2.git
cd media-rollout_v2
sudo ./media-rollout.sh

```

## Usage Description
```
DESCRIPTION
    This script is used to either deploy, configure, or remove the
    media stack or bits and pieces.

OPTIONS
    -H, -h
            Help
            This option shows you this help message.

    -I, -i
            Install
            This option starts the install process.

    -C, -c
            Configure
            This option will configure your existing setup.
            (not the same as update the containers)

    -U, -u
            Update
            This option will remove existing containers, pull new ones, then
            recreate them without wiping configs.

    -G, -g
            Git Info
            This option will give you commit information on this project.


```

* This script was tested and built on a fresh build of:
  * Ubuntu 20 server


## Planned services supported (this list will grow) :
[Sabnzbd](https://sabnzbd.org/ sabnzbd homepage)
[NZBHydra2](https://github.com/theotherp/nzbhydra2 NZBHydra2 homepage)
[Lidarr](https://lidarr.audio/ Lidarr homepage)
[Sonarr](https://sonarr.tv/ Sonarr homepage)
[Radarr](https://radarr.video/ Radarr homepage)
[Plex Media Server](https://www.plex.tv/ Plex homepage)
[Tautulli](https://tautulli.com/ Tautulli homepage)

## Community
* <a name="libera"><img src="https://img.shields.io/badge/style-join%20chat-blue.svg?style=flat.svg&label=libera"></a>&nbsp;(`libera.chat` channel `#media-rollout`)

For questions, help, comments, or praise but have basic Linux knowledge.

## Contributors

#### Main
Coming soon.

---
#media-rollout
