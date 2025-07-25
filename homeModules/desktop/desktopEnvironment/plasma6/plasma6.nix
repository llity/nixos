{ config, lib, pkgs, plasma-manager, ... }:

{
  imports = [
    plasma-manager.homeManagerModules.plasma-manager
  ];

  options.homeManager = {
    desktop.desktopEnvironment.plasma6.plasma6 = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        example = true;
        description = "Enable plasma6.";
      };
    };
  };

  config = lib.mkIf config.homeManager.desktop.desktopEnvironment.plasma6.plasma6.enable {
    home.packages = with pkgs; [
      kdePackages.partitionmanager
    ];

    programs.plasma = {
      enable = true;
      overrideConfig = false;

      workspace = {
        clickItemTo = "select";
        tooltipDelay = 30;
        wallpaper = "${config.xdg.userDirs.pictures}/Desktopbilder/The Witcher/21-9/cropped-3840-1600-608887.jpg";
      };

      windows = {
        allowWindowsToRememberPositions = true;
      };

      startup = {

      };

      kwin = {
        titlebarButtons.right = [
          "minimize"
          "maximize"
          "close"
        ];
        titlebarButtons.left = [
          "keep-above-windows"
        ];

        effects = {
          desktopSwitching.animation = "fade";
          translucency.enable = true;
          blur.enable = true;
          dimAdminMode.enable = true;
        };

        virtualDesktops = {
          rows = 2;
          names = [
            "Desktop 1"
            "Desktop 2"
            "Desktop 3"
            "Desktop 4"
          ];
          number = 4;
        };
      };

      hotkeys.commands."launch-kitty" = {
        name = "Launch Kitty";
        key = "Meta+Return";
        command = "kitty";
      };

      panels = [
        {
          location = "top";
          alignment = "center";
          lengthMode = "fill";
          height = 48;
          hiding = "none";
          floating = true;

          widgets = [
            # We can configure the widgets by adding the name and config
            # attributes. For example to add the the kickoff widget and set the
            # icon to "nix-snowflake-white" use the below configuration. This will
            # add the "icon" key to the "General" group for the widget in
            # ~/.config/plasma-org.kde.plasma.desktop-appletsrc.
            {
              name = "org.kde.plasma.kickoff";
              config = {
                General = {
                  icon = "nix-snowflake-white";
                  favoritesPortedToKAstats = "true";
                  systemFavorites = "suspend\\,hibernate\\,reboot\\,shutdown";
                };
              };
            }

            {
              name = "org.kde.plasma.trash";
            }

            {
              name = "org.kde.plasma.notes";
              config = {
                General = {
                  color = "translucent-light";
                  fontSize = "12";
                };
              };
            }

            {
              name = "org.kde.plasma.colorpicker";
            }

            "org.kde.plasma.panelspacer"

            {
              name = "org.kde.plasma.icontasks";
              config = {
                General.launchers = [
                  "applications:virt-manager.desktop"
                  "applications:qalculate-gtk.desktop"
                  "applications:org.kde.dolphin.desktop"
                  "applications:firefox.desktop"
                  "applications:torbrowser.desktop"
                  "applications:thunderbird.desktop"
                  "applications:org.kde.kate.desktop"
                  "applications:codium.desktop"
                  "applications:signal.desktop"
                  "applications:org.telegram.desktop.desktop"
                  "applications:com.github.xeco23.WasIstLos.desktop"
                  "applications:legcord.desktop"
                  "applications:org.kde.kmymoney.desktop"
                  "applications:org.kde.kile.desktop"
                  "applications:writer.desktop"
                  "applications:calc.desktop"
                  "applications:impress.desktop"
                  "applications:com.github.flxzt.rnote.desktop"
                  "applications:com.obsproject.Studio.desktop"
                  "applications:blender.desktop"
                  #"applications:com.ultimaker.cura.desktop"
                  "applications:org.clementine_player.Clementine.desktop"
                  "applications:fluent-reader.desktop"
                  "applications:freetube.desktop"
                  "applications:org.prismlauncher.PrismLauncher.desktop"
                  "applications:com.heroicgameslauncher.hgl.desktop"
                  "applications:steam.desktop"
                  #"applications:mullvad-vpn.desktop"
                  "applications:protonvpn-app.desktop"
                ];
              };
            }

            "org.kde.plasma.panelspacer"

            {
              name = "org.kde.plasma.systemtray";
              config = {
                General = {
                  hiddenItems = "KDE Connect Indicator,org.kde.plasma.clipboard";
                };
              };
            }

            {
              name = "org.kde.plasma.digitalclock";
              config = {
                Appearance = {
                  dateFormat = "isoDate";
                  enabledCalendarPlugins = "alternatecalendar,astronomicalevents,holidaysevents";
                  showSeconds = "Always";
                  showWeekNumbers = "true";
                  use24hFormat = "2";
                };
              };
            }
          ];
        }
      ];


      #
      # Some mid-level settings:
      #
      #shortcuts = {
      #  kwin = {
      #    "Expose" = "Meta+,";
      #    "Switch Window Down" = "Meta+J";
      #    "Switch Window Left" = "Meta+H";
      #    "Switch Window Right" = "Meta+L";
      #    "Switch Window Up" = "Meta+K";
      #  };
      #};


      #
      # Some low-level settings:
      #

      shortcuts = {
        "Clementine"."next_album" = "Shift+Media Next";
        "Clementine"."next_track" = [ ];
        "Clementine"."play_pause" = [ ];
        "Clementine"."prev_track" = [ ];
        "Clementine"."stop" = [ ];
        "KDE Keyboard Layout Switcher"."Switch keyboard layout to German" = [ ];
        "KDE Keyboard Layout Switcher"."Switch to Last-Used Keyboard Layout" = "Meta+Alt+L";
        "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Meta+Alt+K";
        "kaccess"."Toggle Screen Reader On and Off" = "Meta+Alt+S";
        "kcm_touchpad"."Disable Touchpad" = "Touchpad Off";
        "kcm_touchpad"."Enable Touchpad" = "Touchpad On";
        "kcm_touchpad"."Toggle Touchpad" = ["Touchpad Toggle" "Meta+Ctrl+Zenkaku Hankaku"];
        "kmix"."decrease_microphone_volume" = "Microphone Volume Down";
        "kmix"."decrease_volume" = "Volume Down";
        "kmix"."decrease_volume_small" = "Shift+Volume Down";
        "kmix"."increase_microphone_volume" = "Microphone Volume Up";
        "kmix"."increase_volume" = "Volume Up";
        "kmix"."increase_volume_small" = "Shift+Volume Up";
        "kmix"."mic_mute" = ["Meta+Alt+-" "Microphone Mute" "Meta+Volume Mute"];
        "kmix"."mute" = "Volume Mute";
        "ksmserver"."Halt Without Confirmation" = [ ];
        "ksmserver"."Lock Session" = ["Meta+L" "Screensaver"];
        "ksmserver"."Log Out" = "Ctrl+Alt+Del";
        "ksmserver"."Log Out Without Confirmation" = "Meta+Shift+Q";
        "ksmserver"."Reboot" = [ ];
        "ksmserver"."Reboot Without Confirmation" = "Meta+Shift+R";
        "ksmserver"."Shut Down" = [ ];
        "kwin"."Activate Window Demanding Attention" = "Meta+Ctrl+A";
        "kwin"."Cycle Overview" = [ ];
        "kwin"."Cycle Overview Opposite" = [ ];
        "kwin"."Decrease Opacity" = [ ];
        "kwin"."Edit Tiles" = "Meta+T";
        "kwin"."Expose" = "Ctrl+F9";
        "kwin"."ExposeAll" = ["Ctrl+F10" "Launch (C)"];
        "kwin"."ExposeClass" = "Ctrl+F7";
        "kwin"."ExposeClassCurrentDesktop" = [ ];
        "kwin"."Grid View" = "Meta+G";
        "kwin"."Increase Opacity" = [ ];
        "kwin"."Kill Window" = ["Meta+Ctrl+Esc" "Meta+Ctrl+Q"];
        "kwin"."Move Tablet to Next Output" = [ ];
        "kwin"."MoveMouseToCenter" = "Meta+F6";
        "kwin"."MoveMouseToFocus" = "Meta+F5";
        "kwin"."MoveZoomDown" = [ ];
        "kwin"."MoveZoomLeft" = [ ];
        "kwin"."MoveZoomRight" = [ ];
        "kwin"."MoveZoomUp" = [ ];
        "kwin"."Overview" = "Meta+W";
        "kwin"."Setup Window Shortcut" = [ ];
        "kwin"."Show Desktop" = "Meta+D";
        "kwin"."ShowDesktopGrid" = ["Meta+F8" "Meta+E"];
        "kwin"."Suspend Compositing" = "Alt+Shift+F12";
        "kwin"."Switch One Desktop Down" = "Meta+Ctrl+Down";
        "kwin"."Switch One Desktop Up" = "Meta+Ctrl+Up";
        "kwin"."Switch One Desktop to the Left" = "Meta+Ctrl+Left";
        "kwin"."Switch One Desktop to the Right" = "Meta+Ctrl+Right";
        "kwin"."Switch Window Down" = "Meta+Alt+Down";
        "kwin"."Switch Window Left" = "Meta+Alt+Left";
        "kwin"."Switch Window Right" = "Meta+Alt+Right";
        "kwin"."Switch Window Up" = "Meta+Alt+Up";
        "kwin"."Switch to Desktop 1" = "Ctrl+F1";
        "kwin"."Switch to Desktop 10" = [ ];
        "kwin"."Switch to Desktop 11" = [ ];
        "kwin"."Switch to Desktop 12" = [ ];
        "kwin"."Switch to Desktop 13" = [ ];
        "kwin"."Switch to Desktop 14" = [ ];
        "kwin"."Switch to Desktop 15" = [ ];
        "kwin"."Switch to Desktop 16" = [ ];
        "kwin"."Switch to Desktop 17" = [ ];
        "kwin"."Switch to Desktop 18" = [ ];
        "kwin"."Switch to Desktop 19" = [ ];
        "kwin"."Switch to Desktop 2" = "Ctrl+F2";
        "kwin"."Switch to Desktop 20" = [ ];
        "kwin"."Switch to Desktop 3" = "Ctrl+F3";
        "kwin"."Switch to Desktop 4" = "Ctrl+F4";
        "kwin"."Switch to Desktop 5" = [ ];
        "kwin"."Switch to Desktop 6" = [ ];
        "kwin"."Switch to Desktop 7" = [ ];
        "kwin"."Switch to Desktop 8" = [ ];
        "kwin"."Switch to Desktop 9" = [ ];
        "kwin"."Switch to Next Desktop" = [ ];
        "kwin"."Switch to Next Screen" = [ ];
        "kwin"."Switch to Previous Desktop" = [ ];
        "kwin"."Switch to Previous Screen" = [ ];
        "kwin"."Switch to Screen 0" = [ ];
        "kwin"."Switch to Screen 1" = [ ];
        "kwin"."Switch to Screen 2" = [ ];
        "kwin"."Switch to Screen 3" = [ ];
        "kwin"."Switch to Screen 4" = [ ];
        "kwin"."Switch to Screen 5" = [ ];
        "kwin"."Switch to Screen 6" = [ ];
        "kwin"."Switch to Screen 7" = [ ];
        "kwin"."Switch to Screen Above" = [ ];
        "kwin"."Switch to Screen Below" = [ ];
        "kwin"."Switch to Screen to the Left" = [ ];
        "kwin"."Switch to Screen to the Right" = [ ];
        "kwin"."Toggle Night Color" = [ ];
        "kwin"."Toggle Window Raise/Lower" = [ ];
        "kwin"."Walk Through Desktop List" = [ ];
        "kwin"."Walk Through Desktop List (Reverse)" = [ ];
        "kwin"."Walk Through Desktops" = [ ];
        "kwin"."Walk Through Desktops (Reverse)" = [ ];
        "kwin"."Walk Through Windows" = "Alt+Tab";
        "kwin"."Walk Through Windows (Reverse)" = "Alt+Shift+Backtab";
        "kwin"."Walk Through Windows Alternative" = [ ];
        "kwin"."Walk Through Windows Alternative (Reverse)" = [ ];
        "kwin"."Walk Through Windows of Current Application" = "Alt+`";
        "kwin"."Walk Through Windows of Current Application (Reverse)" = "Alt+~";
        "kwin"."Walk Through Windows of Current Application Alternative" = [ ];
        "kwin"."Walk Through Windows of Current Application Alternative (Reverse)" = [ ];
        "kwin"."Window Above Other Windows" = [ ];
        "kwin"."Window Below Other Windows" = [ ];
        "kwin"."Window Close" = ["Alt+F4" "Meta+Q"];
        "kwin"."Window Fullscreen" = [ ];
        "kwin"."Window Grow Horizontal" = [ ];
        "kwin"."Window Grow Vertical" = [ ];
        "kwin"."Window Lower" = [ ];
        "kwin"."Window Maximize" = "Meta+PgUp";
        "kwin"."Window Maximize Horizontal" = [ ];
        "kwin"."Window Maximize Vertical" = [ ];
        "kwin"."Window Minimize" = "Meta+PgDown";
        "kwin"."Window Move" = [ ];
        "kwin"."Window Move Center" = [ ];
        "kwin"."Window No Border" = [ ];
        "kwin"."Window On All Desktops" = [ ];
        "kwin"."Window One Desktop Down" = "Meta+Ctrl+Shift+Down";
        "kwin"."Window One Desktop Up" = "Meta+Ctrl+Shift+Up";
        "kwin"."Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
        "kwin"."Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
        "kwin"."Window One Screen Down" = [ ];
        "kwin"."Window One Screen Up" = [ ];
        "kwin"."Window One Screen to the Left" = [ ];
        "kwin"."Window One Screen to the Right" = [ ];
        "kwin"."Window Operations Menu" = "Alt+F3";
        "kwin"."Window Pack Down" = [ ];
        "kwin"."Window Pack Left" = [ ];
        "kwin"."Window Pack Right" = [ ];
        "kwin"."Window Pack Up" = [ ];
        "kwin"."Window Quick Tile Bottom" = "Meta+Down";
        "kwin"."Window Quick Tile Bottom Left" = [ ];
        "kwin"."Window Quick Tile Bottom Right" = [ ];
        "kwin"."Window Quick Tile Left" = "Meta+Left";
        "kwin"."Window Quick Tile Right" = "Meta+Right";
        "kwin"."Window Quick Tile Top" = "Meta+Up";
        "kwin"."Window Quick Tile Top Left" = [ ];
        "kwin"."Window Quick Tile Top Right" = [ ];
        "kwin"."Window Raise" = [ ];
        "kwin"."Window Resize" = [ ];
        "kwin"."Window Shade" = [ ];
        "kwin"."Window Shrink Horizontal" = [ ];
        "kwin"."Window Shrink Vertical" = [ ];
        "kwin"."Window to Desktop 1" = [ ];
        "kwin"."Window to Desktop 10" = [ ];
        "kwin"."Window to Desktop 11" = [ ];
        "kwin"."Window to Desktop 12" = [ ];
        "kwin"."Window to Desktop 13" = [ ];
        "kwin"."Window to Desktop 14" = [ ];
        "kwin"."Window to Desktop 15" = [ ];
        "kwin"."Window to Desktop 16" = [ ];
        "kwin"."Window to Desktop 17" = [ ];
        "kwin"."Window to Desktop 18" = [ ];
        "kwin"."Window to Desktop 19" = [ ];
        "kwin"."Window to Desktop 2" = [ ];
        "kwin"."Window to Desktop 20" = [ ];
        "kwin"."Window to Desktop 3" = [ ];
        "kwin"."Window to Desktop 4" = [ ];
        "kwin"."Window to Desktop 5" = [ ];
        "kwin"."Window to Desktop 6" = [ ];
        "kwin"."Window to Desktop 7" = [ ];
        "kwin"."Window to Desktop 8" = [ ];
        "kwin"."Window to Desktop 9" = [ ];
        "kwin"."Window to Next Desktop" = [ ];
        "kwin"."Window to Next Screen" = "Meta+Shift+Right";
        "kwin"."Window to Previous Desktop" = [ ];
        "kwin"."Window to Previous Screen" = "Meta+Shift+Left";
        "kwin"."Window to Screen 0" = [ ];
        "kwin"."Window to Screen 1" = [ ];
        "kwin"."Window to Screen 2" = [ ];
        "kwin"."Window to Screen 3" = [ ];
        "kwin"."Window to Screen 4" = [ ];
        "kwin"."Window to Screen 5" = [ ];
        "kwin"."Window to Screen 6" = [ ];
        "kwin"."Window to Screen 7" = [ ];
        "kwin"."view_actual_size" = "Meta+0";
        "kwin"."view_zoom_in" = ["Meta++" "Meta+="];
        "kwin"."view_zoom_out" = "Meta+-";
        "mediacontrol"."mediavolumedown" = [ ];
        "mediacontrol"."mediavolumeup" = [ ];
        "mediacontrol"."nextmedia" = "Media Next";
        "mediacontrol"."pausemedia" = "Media Pause";
        "mediacontrol"."playmedia" = [ ];
        "mediacontrol"."playpausemedia" = "Media Play";
        "mediacontrol"."previousmedia" = "Media Previous";
        "mediacontrol"."stopmedia" = "Media Stop";
        "org_kde_powerdevil"."Decrease Keyboard Brightness" = "Keyboard Brightness Down";
        "org_kde_powerdevil"."Decrease Screen Brightness" = "Monitor Brightness Down";
        "org_kde_powerdevil"."Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down";
        "org_kde_powerdevil"."Hibernate" = "Hibernate";
        "org_kde_powerdevil"."Increase Keyboard Brightness" = "Keyboard Brightness Up";
        "org_kde_powerdevil"."Increase Screen Brightness" = "Monitor Brightness Up";
        "org_kde_powerdevil"."Increase Screen Brightness Small" = "Shift+Monitor Brightness Up";
        "org_kde_powerdevil"."PowerDown" = "Power Down";
        "org_kde_powerdevil"."PowerOff" = "Power Off";
        "org_kde_powerdevil"."Sleep" = "Sleep";
        "org_kde_powerdevil"."Toggle Keyboard Backlight" = "Keyboard Light On/Off";
        "org_kde_powerdevil"."Turn Off Screen" = [ ];
        "org_kde_powerdevil"."powerProfile" = ["Battery" "Meta+B"];
        "plasmashell"."activate task manager entry 1" = "Meta+1";
        "plasmashell"."activate task manager entry 10" = [ ];
        "plasmashell"."activate task manager entry 2" = "Meta+2";
        "plasmashell"."activate task manager entry 3" = "Meta+3";
        "plasmashell"."activate task manager entry 4" = "Meta+4";
        "plasmashell"."activate task manager entry 5" = "Meta+5";
        "plasmashell"."activate task manager entry 6" = "Meta+6";
        "plasmashell"."activate task manager entry 7" = "Meta+7";
        "plasmashell"."activate task manager entry 8" = "Meta+8";
        "plasmashell"."activate task manager entry 9" = "Meta+9";
        "plasmashell"."clear-history" = [ ];
        "plasmashell"."clipboard_action" = "Meta+Ctrl+X";
        "plasmashell"."cycle-panels" = "Meta+Alt+P";
        "plasmashell"."cycleNextAction" = [ ];
        "plasmashell"."cyclePrevAction" = [ ];
        "plasmashell"."edit_clipboard" = [ ];
        "plasmashell"."manage activities" = "Meta+A";
        "plasmashell"."next activity" = "Meta+Tab";
        "plasmashell"."previous activity" = "Meta+Shift+Tab";
        "plasmashell"."repeat_action" = "Meta+Ctrl+R";
        "plasmashell"."show dashboard" = "Ctrl+F12";
        "plasmashell"."show-barcode" = [ ];
        "plasmashell"."show-on-mouse-pos" = "Meta+V";
        "plasmashell"."stop current activity" = "Meta+S";
        "plasmashell"."switch to next activity" = [ ];
        "plasmashell"."switch to previous activity" = [ ];
        "plasmashell"."toggle do not disturb" = [ ];
        "services/kitty.desktop"."_launch" = "Meta+Return";
        "services/normcap.desktop"."_launch" = "Meta+Print";
        "services/org.flameshot.Flameshot.desktop"."Capture" = "Print";
        "services/org.kde.dolphin.desktop"."_launch" = "Meta+F";
        "services/org.kde.krunner.desktop"."_launch" = [ "Meta+R" "Meta+Space" "Alt+Space" "Alt+F2" "Search"];
        "services/org.kde.plasma-systemmonitor.desktop"."_launch" = "Ctrl+Shift+Esc";
        "services/org.kde.spectacle.desktop"."ActiveWindowScreenShot" = [ ];
        "services/org.kde.spectacle.desktop"."FullScreenScreenShot" = "Ctrl+Print";
        "services/org.kde.spectacle.desktop"."RecordRegion" = [ ];
        "services/org.kde.spectacle.desktop"."RecordScreen" = [ ];
        "services/org.kde.spectacle.desktop"."RecordWindow" = [ ];
        "services/org.kde.spectacle.desktop"."RectangularRegionScreenShot" = [ ];
        "services/org.kde.spectacle.desktop"."WindowUnderCursorScreenShot" = [ ];
        "services/org.kde.spectacle.desktop"."_launch" = [ ];
      };
      
      configFile = {
        "plasmaparc"."General"."VolumeStep" = 1;
        "baloofilerc"."General"."dbVersion" = 2;
        "baloofilerc"."General"."exclude filters" = "*~,*.part,*.o,*.la,*.lo,*.loT,*.moc,moc_*.cpp,qrc_*.cpp,ui_*.h,cmake_install.cmake,CMakeCache.txt,CTestTestfile.cmake,libtool,config.status,confdefs.h,autom4te,conftest,confstat,Makefile.am,*.gcode,.ninja_deps,.ninja_log,build.ninja,*.csproj,*.m4,*.rej,*.gmo,*.pc,*.omf,*.aux,*.tmp,*.po,*.vm*,*.nvram,*.rcore,*.swp,*.swap,lzo,litmain.sh,*.orig,.histfile.*,.xsession-errors*,*.map,*.so,*.a,*.db,*.qrc,*.ini,*.init,*.img,*.vdi,*.vbox*,vbox.log,*.qcow2,*.vmdk,*.vhd,*.vhdx,*.sql,*.sql.gz,*.ytdl,*.class,*.pyc,*.pyo,*.elc,*.qmlc,*.jsc,*.fastq,*.fq,*.gb,*.fasta,*.fna,*.gbff,*.faa,po,CVS,.svn,.git,_darcs,.bzr,.hg,CMakeFiles,CMakeTmp,CMakeTmpQmake,.moc,.obj,.pch,.uic,.npm,.yarn,.yarn-cache,__pycache__,node_modules,node_packages,nbproject,.venv,venv,core-dumps,lost+found";
        "baloofilerc"."General"."exclude filters version" = 8;
        "baloofilerc"."General"."index hidden folders" = true;
        "dolphinrc"."ContentDisplay"."DirectorySizeCount" = false;
        "dolphinrc"."ContentDisplay"."RecursiveDirectorySizeLimit" = 20;
        "dolphinrc"."ContentDisplay"."UsePermissionsFormat" = "CombinedFormat";
        "dolphinrc"."ContextMenu"."ShowCopyMoveMenu" = true;
        "dolphinrc"."DetailsMode"."PreviewSize" = 32;
        "dolphinrc"."General"."BrowseThroughArchives" = true;
        "dolphinrc"."General"."ShowFullPath" = true;
        "dolphinrc"."General"."ShowFullPathInTitlebar" = true;
        "dolphinrc"."General"."ShowToolTips" = true;
        "dolphinrc"."General"."SplitView" = true;
        "dolphinrc"."General"."UseTabForSwitchingSplitView" = true;
        "dolphinrc"."IconsMode"."IconSize" = 22;
        "dolphinrc"."IconsMode"."PreviewSize" = 48;
        "dolphinrc"."KFileDialog Settings"."Places Icons Auto-resize" = false;
        "dolphinrc"."KFileDialog Settings"."Places Icons Static Size" = 22;
        "dolphinrc"."MainWindow"."MenuBar" = "Disabled";
        "dolphinrc"."MainWindow"."ToolBarsMovable" = "Disabled";
        "dolphinrc"."PreviewSettings"."Plugins" = "audiothumbnail,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,directorythumbnail,fontthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mltpreview,mobithumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,svgthumbnail,ffmpegthumbs";
        "dolphinrc"."VersionControl"."enabledPlugins" = "Git";
        "kcminputrc"."Keyboard"."NumLock" = 0;
        "kcminputrc"."Libinput.10182.3396.DLL0B38:01 27C6:0D44 Mouse"."PointerAccelerationProfile" = 1;
        "kcminputrc"."Libinput.10182.3396.DLL0B38:01 27C6:0D44 Touchpad"."ClickMethod" = 2;
        "kcminputrc"."Libinput.10182.3396.DLL0B38:01 27C6:0D44 Touchpad"."LmrTapButtonMap" = false;
        "kcminputrc"."Libinput.10182.3396.DLL0B38:01 27C6:0D44 Touchpad"."NaturalScroll" = true;
        "kcminputrc"."Libinput.10182.3396.DLL0B38:01 27C6:0D44 Touchpad"."PointerAccelerationProfile" = 2;
        "kcminputrc"."Libinput.10182.3396.DLL0B38:01 27C6:0D44 Touchpad"."ScrollFactor" = 1.5;
        "kcminputrc"."Libinput.10182.3396.DLL0B38:01 27C6:0D44 Touchpad"."TapToClick" = true;
        "kcminputrc"."Libinput.PIXA3854:00 093A:0274 Touchpad"."NaturalScroll" = true;
        "kcminputrc"."Libinput.PIXA3854:00 093A:0274 Touchpad"."ScrollFactor" = 2;
        "kcminputrc"."Libinput/13364/1553/Keychron Keychron Q1 Pro Mouse"."PointerAccelerationProfile" = 1;
        "kcminputrc"."Libinput/5426/171/Razer Razer Basilisk V3 Pro"."PointerAccelerationProfile" = 1;
        "kcminputrc"."Tmp"."update_info" = "delete_cursor_old_default_size.upd:DeleteCursorOldDefaultSize";
        "kded5rc"."Module-browserintegrationreminder"."autoload" = false;
        "kded5rc"."Module-device_automounter"."autoload" = false;
        "kded5rc"."PlasmaBrowserIntegration"."shownCount" = 4;
        "kded6rc"."PlasmaBrowserIntegration"."shownCount" = 4;
        "kdeglobals"."DirSelect Dialog"."DirSelectDialog Size" = "844,598";
        "kdeglobals"."General"."AllowKDEAppsToRememberWindowPositions" = true;
        "kdeglobals"."General"."BrowserApplication" = "librewolf.desktop";
        "kdeglobals"."General"."TerminalApplication" = "kitty";
        "kdeglobals"."General"."TerminalService" = "kitty.desktop";
        "kdeglobals"."KDE"."ScrollbarLeftClickNavigatesByPage" = false;
        "kdeglobals"."KDE"."ShowDeleteCommand" = true;
        "kdeglobals"."KFileDialog Settings"."Allow Expansion" = true;
        "kdeglobals"."KFileDialog Settings"."Automatically select filename extension" = true;
        "kdeglobals"."KFileDialog Settings"."Breadcrumb Navigation" = true;
        "kdeglobals"."KFileDialog Settings"."Decoration position" = 2;
        "kdeglobals"."KFileDialog Settings"."LocationCombo Completionmode" = 5;
        "kdeglobals"."KFileDialog Settings"."PathCombo Completionmode" = 5;
        "kdeglobals"."KFileDialog Settings"."Preview Width" = 0;
        "kdeglobals"."KFileDialog Settings"."Show Bookmarks" = true;
        "kdeglobals"."KFileDialog Settings"."Show Full Path" = true;
        "kdeglobals"."KFileDialog Settings"."Show Inline Previews" = true;
        "kdeglobals"."KFileDialog Settings"."Show Preview" = true;
        "kdeglobals"."KFileDialog Settings"."Show Speedbar" = true;
        "kdeglobals"."KFileDialog Settings"."Show hidden files" = true;
        "kdeglobals"."KFileDialog Settings"."Sort by" = "Name";
        "kdeglobals"."KFileDialog Settings"."Sort directories first" = true;
        "kdeglobals"."KFileDialog Settings"."Sort hidden files last" = false;
        "kdeglobals"."KFileDialog Settings"."Sort reversed" = false;
        "kdeglobals"."KFileDialog Settings"."Speedbar Width" = 138;
        "kdeglobals"."KFileDialog Settings"."View Style" = "DetailTree";
        "kdeglobals"."PreviewSettings"."MaximumRemoteSize" = 0;
        #"kdeglobals"."WM"."activeBackground" = "239,241,245";
        #"kdeglobals"."WM"."activeBlend" = "76,79,105";
        #"kdeglobals"."WM"."activeForeground" = "76,79,105";
        #"kdeglobals"."WM"."inactiveBackground" = "220,224,232";
        #"kdeglobals"."WM"."inactiveBlend" = "108,111,133";
        #"kdeglobals"."WM"."inactiveForeground" = "108,111,133";
        "kglobalshortcutsrc"."ActivityManager"."_k_friendly_name" = "Activity Manager";
        "kglobalshortcutsrc"."Clementine"."_k_friendly_name" = "Clementine";
        "kglobalshortcutsrc"."KDE Keyboard Layout Switcher"."_k_friendly_name" = "Keyboard Layout Switcher";
        "kglobalshortcutsrc"."kaccess"."_k_friendly_name" = "Accessibility";
        "kglobalshortcutsrc"."kcm_touchpad"."_k_friendly_name" = "Touchpad";
        "kglobalshortcutsrc"."khotkeys"."_k_friendly_name" = "Custom Shortcuts Service";
        "kglobalshortcutsrc"."kmix"."_k_friendly_name" = "Audio Volume";
        "kglobalshortcutsrc"."ksmserver"."_k_friendly_name" = "Session Management";
        "kglobalshortcutsrc"."kwin"."_k_friendly_name" = "KWin";
        "kglobalshortcutsrc"."mediacontrol"."_k_friendly_name" = "Media Controller";
        "kglobalshortcutsrc"."org_kde_powerdevil"."_k_friendly_name" = "KDE Power Management System";
        "kglobalshortcutsrc"."plasmashell"."_k_friendly_name" = "plasmashell";
        "khotkeysrc"."Data"."DataCount" = 3;
        "khotkeysrc"."Data_1"."Comment" = "KMenuEdit Global Shortcuts";
        "khotkeysrc"."Data_1"."DataCount" = 1;
        "khotkeysrc"."Data_1"."Enabled" = true;
        "khotkeysrc"."Data_1"."Name" = "KMenuEdit";
        "khotkeysrc"."Data_1"."SystemGroup" = 1;
        "khotkeysrc"."Data_1"."Type" = "ACTION_DATA_GROUP";
        "khotkeysrc"."Data_1Conditions"."Comment" = "";
        "khotkeysrc"."Data_1Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_1_1"."Comment" = "Comment";
        "khotkeysrc"."Data_1_1"."Enabled" = true;
        "khotkeysrc"."Data_1_1"."Name" = "Search";
        "khotkeysrc"."Data_1_1"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_1_1Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_1_1Actions0"."CommandURL" = "http://duckduckgo.com";
        "khotkeysrc"."Data_1_1Actions0"."Type" = "COMMAND_URL";
        "khotkeysrc"."Data_1_1Conditions"."Comment" = "";
        "khotkeysrc"."Data_1_1Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_1_1Triggers"."Comment" = "Simple_action";
        "khotkeysrc"."Data_1_1Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_1_1Triggers0"."Key" = "";
        "khotkeysrc"."Data_1_1Triggers0"."Type" = "SHORTCUT";
        "khotkeysrc"."Data_2"."Comment" = "This group contains various examples demonstrating most of the features of KHotkeys. (Note that this group and all its actions are disabled by default.)";
        "khotkeysrc"."Data_2"."DataCount" = 8;
        "khotkeysrc"."Data_2"."Enabled" = false;
        "khotkeysrc"."Data_2"."ImportId" = "kde32b1";
        "khotkeysrc"."Data_2"."Name" = "Examples";
        "khotkeysrc"."Data_2"."SystemGroup" = 0;
        "khotkeysrc"."Data_2"."Type" = "ACTION_DATA_GROUP";
        "khotkeysrc"."Data_2Conditions"."Comment" = "";
        "khotkeysrc"."Data_2Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_2_1"."Comment" = "After pressing Ctrl+Alt+I, the KSIRC window will be activated, if it exists. Simple.";
        "khotkeysrc"."Data_2_1"."Enabled" = false;
        "khotkeysrc"."Data_2_1"."Name" = "Activate KSIRC Window";
        "khotkeysrc"."Data_2_1"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_2_1Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_2_1Actions0"."Type" = "ACTIVATE_WINDOW";
        "khotkeysrc"."Data_2_1Actions0Window"."Comment" = "KSIRC window";
        "khotkeysrc"."Data_2_1Actions0Window"."WindowsCount" = 1;
        "khotkeysrc"."Data_2_1Actions0Window0"."Class" = "ksirc";
        "khotkeysrc"."Data_2_1Actions0Window0"."ClassType" = 1;
        "khotkeysrc"."Data_2_1Actions0Window0"."Comment" = "KSIRC";
        "khotkeysrc"."Data_2_1Actions0Window0"."Role" = "";
        "khotkeysrc"."Data_2_1Actions0Window0"."RoleType" = 0;
        "khotkeysrc"."Data_2_1Actions0Window0"."Title" = "";
        "khotkeysrc"."Data_2_1Actions0Window0"."TitleType" = 0;
        "khotkeysrc"."Data_2_1Actions0Window0"."Type" = "SIMPLE";
        "khotkeysrc"."Data_2_1Actions0Window0"."WindowTypes" = 33;
        "khotkeysrc"."Data_2_1Conditions"."Comment" = "";
        "khotkeysrc"."Data_2_1Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_2_1Triggers"."Comment" = "Simple_action";
        "khotkeysrc"."Data_2_1Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_2_1Triggers0"."Key" = "Ctrl+Alt+I";
        "khotkeysrc"."Data_2_1Triggers0"."Type" = "SHORTCUT";
        "khotkeysrc"."Data_2_2"."Comment" = "After pressing Alt+Ctrl+H the input of 'Hello' will be simulated, as if you typed it.  This is especially useful if you have call to frequently type a word (for instance, 'unsigned').  Every keypress in the input is separated by a colon ':'. Note that the keypresses literally mean keypresses, so you have to write what you would press on the keyboard. In the table below, the left column shows the input and the right column shows what to type.\n\n\"enter\" (i.e. new line)                Enter or Return\na (i.e. small a)                          A\nA (i.e. capital a)                       Shift+A\n: (colon)                                  Shift+;\n' '  (space)                              Space";
        "khotkeysrc"."Data_2_2"."Enabled" = false;
        "khotkeysrc"."Data_2_2"."Name" = "Type 'Hello'";
        "khotkeysrc"."Data_2_2"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_2_2Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_2_2Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_2_2Actions0"."Input" = "Shift+H:E:L:L:O\n";
        "khotkeysrc"."Data_2_2Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_2_2Conditions"."Comment" = "";
        "khotkeysrc"."Data_2_2Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_2_2Triggers"."Comment" = "Simple_action";
        "khotkeysrc"."Data_2_2Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_2_2Triggers0"."Key" = "Ctrl+Alt+H";
        "khotkeysrc"."Data_2_2Triggers0"."Type" = "SHORTCUT";
        "khotkeysrc"."Data_2_3"."Comment" = "This action runs Konsole, after pressing Ctrl+Alt+T.";
        "khotkeysrc"."Data_2_3"."Enabled" = false;
        "khotkeysrc"."Data_2_3"."Name" = "Run Konsole";
        "khotkeysrc"."Data_2_3"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_2_3Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_2_3Actions0"."CommandURL" = "konsole";
        "khotkeysrc"."Data_2_3Actions0"."Type" = "COMMAND_URL";
        "khotkeysrc"."Data_2_3Conditions"."Comment" = "";
        "khotkeysrc"."Data_2_3Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_2_3Triggers"."Comment" = "Simple_action";
        "khotkeysrc"."Data_2_3Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_2_3Triggers0"."Key" = "Ctrl+Alt+T";
        "khotkeysrc"."Data_2_3Triggers0"."Type" = "SHORTCUT";
        "khotkeysrc"."Data_2_4"."Comment" = "Read the comment on the \"Type 'Hello'\" action first.\n\nQt Designer uses Ctrl+F4 for closing windows.  In KDE, however, Ctrl+F4 is the shortcut for going to virtual desktop 4, so this shortcut does not work in Qt Designer.  Further, Qt Designer does not use KDE's standard Ctrl+W for closing the window.\n\nThis problem can be solved by remapping Ctrl+W to Ctrl+F4 when the active window is Qt Designer. When Qt Designer is active, every time Ctrl+W is pressed, Ctrl+F4 will be sent to Qt Designer instead. In other applications, the effect of Ctrl+W is unchanged.\n\nWe now need to specify three things: A new shortcut trigger on 'Ctrl+W', a new keyboard input action sending Ctrl+F4, and a new condition that the active window is Qt Designer.\nQt Designer seems to always have title 'Qt Designer by Trolltech', so the condition will check for the active window having that title.";
        "khotkeysrc"."Data_2_4"."Enabled" = false;
        "khotkeysrc"."Data_2_4"."Name" = "Remap Ctrl+W to Ctrl+F4 in Qt Designer";
        "khotkeysrc"."Data_2_4"."Type" = "GENERIC_ACTION_DATA";
        "khotkeysrc"."Data_2_4Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_2_4Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_2_4Actions0"."Input" = "Ctrl+F4";
        "khotkeysrc"."Data_2_4Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_2_4Conditions"."Comment" = "";
        "khotkeysrc"."Data_2_4Conditions"."ConditionsCount" = 1;
        "khotkeysrc"."Data_2_4Conditions0"."Type" = "ACTIVE_WINDOW";
        "khotkeysrc"."Data_2_4Conditions0Window"."Comment" = "Qt Designer";
        "khotkeysrc"."Data_2_4Conditions0Window"."WindowsCount" = 1;
        "khotkeysrc"."Data_2_4Conditions0Window0"."Class" = "";
        "khotkeysrc"."Data_2_4Conditions0Window0"."ClassType" = 0;
        "khotkeysrc"."Data_2_4Conditions0Window0"."Comment" = "";
        "khotkeysrc"."Data_2_4Conditions0Window0"."Role" = "";
        "khotkeysrc"."Data_2_4Conditions0Window0"."RoleType" = 0;
        "khotkeysrc"."Data_2_4Conditions0Window0"."Title" = "Qt Designer by Trolltech";
        "khotkeysrc"."Data_2_4Conditions0Window0"."TitleType" = 2;
        "khotkeysrc"."Data_2_4Conditions0Window0"."Type" = "SIMPLE";
        "khotkeysrc"."Data_2_4Conditions0Window0"."WindowTypes" = 33;
        "khotkeysrc"."Data_2_4Triggers"."Comment" = "";
        "khotkeysrc"."Data_2_4Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_2_4Triggers0"."Key" = "Ctrl+W";
        "khotkeysrc"."Data_2_4Triggers0"."Type" = "SHORTCUT";
        "khotkeysrc"."Data_2_5"."Comment" = "By pressing Alt+Ctrl+W a D-Bus call will be performed that will show the minicli. You can use any kind of D-Bus call, just like using the command line 'qdbus' tool.";
        "khotkeysrc"."Data_2_5"."Enabled" = false;
        "khotkeysrc"."Data_2_5"."Name" = "Perform D-Bus call 'qdbus org.kde.krunner /App display'";
        "khotkeysrc"."Data_2_5"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_2_5Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_2_5Actions0"."Arguments" = "";
        "khotkeysrc"."Data_2_5Actions0"."Call" = "popupExecuteCommand";
        "khotkeysrc"."Data_2_5Actions0"."RemoteApp" = "org.kde.krunner";
        "khotkeysrc"."Data_2_5Actions0"."RemoteObj" = "/App";
        "khotkeysrc"."Data_2_5Actions0"."Type" = "DBUS";
        "khotkeysrc"."Data_2_5Conditions"."Comment" = "";
        "khotkeysrc"."Data_2_5Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_2_5Triggers"."Comment" = "Simple_action";
        "khotkeysrc"."Data_2_5Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_2_5Triggers0"."Key" = "Ctrl+Alt+W";
        "khotkeysrc"."Data_2_5Triggers0"."Type" = "SHORTCUT";
        "khotkeysrc"."Data_2_6"."Comment" = "Read the comment on the \"Type 'Hello'\" action first.\n\nJust like the \"Type 'Hello'\" action, this one simulates keyboard input, specifically, after pressing Ctrl+Alt+B, it sends B to XMMS (B in XMMS jumps to the next song). The 'Send to specific window' checkbox is checked and a window with its class containing 'XMMS_Player' is specified; this will make the input always be sent to this window. This way, you can control XMMS even if, for instance, it is on a different virtual desktop.\n\n(Run 'xprop' and click on the XMMS window and search for WM_CLASS to see 'XMMS_Player').";
        "khotkeysrc"."Data_2_6"."Enabled" = false;
        "khotkeysrc"."Data_2_6"."Name" = "Next in XMMS";
        "khotkeysrc"."Data_2_6"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_2_6Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_2_6Actions0"."DestinationWindow" = 1;
        "khotkeysrc"."Data_2_6Actions0"."Input" = "B";
        "khotkeysrc"."Data_2_6Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_2_6Actions0DestinationWindow"."Comment" = "XMMS window";
        "khotkeysrc"."Data_2_6Actions0DestinationWindow"."WindowsCount" = 1;
        "khotkeysrc"."Data_2_6Actions0DestinationWindow0"."Class" = "XMMS_Player";
        "khotkeysrc"."Data_2_6Actions0DestinationWindow0"."ClassType" = 1;
        "khotkeysrc"."Data_2_6Actions0DestinationWindow0"."Comment" = "XMMS Player window";
        "khotkeysrc"."Data_2_6Actions0DestinationWindow0"."Role" = "";
        "khotkeysrc"."Data_2_6Actions0DestinationWindow0"."RoleType" = 0;
        "khotkeysrc"."Data_2_6Actions0DestinationWindow0"."Title" = "";
        "khotkeysrc"."Data_2_6Actions0DestinationWindow0"."TitleType" = 0;
        "khotkeysrc"."Data_2_6Actions0DestinationWindow0"."Type" = "SIMPLE";
        "khotkeysrc"."Data_2_6Actions0DestinationWindow0"."WindowTypes" = 33;
        "khotkeysrc"."Data_2_6Conditions"."Comment" = "";
        "khotkeysrc"."Data_2_6Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_2_6Triggers"."Comment" = "Simple_action";
        "khotkeysrc"."Data_2_6Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_2_6Triggers0"."Key" = "Ctrl+Alt+B";
        "khotkeysrc"."Data_2_6Triggers0"."Type" = "SHORTCUT";
        "khotkeysrc"."Data_2_7"."Comment" = "Konqueror in KDE3.1 has tabs, and now you can also have gestures.\n\nJust press the middle mouse button and start drawing one of the gestures, and after you are finished, release the mouse button. If you only need to paste the selection, it still works, just click the middle mouse button. (You can change the mouse button to use in the global settings).\n\nRight now, there are the following gestures available:\nmove right and back left - Forward (Alt+Right)\nmove left and back right - Back (Alt+Left)\nmove up and back down  - Up (Alt+Up)\ncircle counterclockwise - Reload (F5)\n\nThe gesture shapes can be entered by performing them in the configuration dialog. You can also look at your numeric pad to help you: gestures are recognized like a 3x3 grid of fields, numbered 1 to 9.\n\nNote that you must perform exactly the gesture to trigger the action. Because of this, it is possible to enter more gestures for the action. You should try to avoid complicated gestures where you change the direction of mouse movement more than once.  For instance, 45654 or 74123 are simple to perform, but 1236987 may be already quite difficult.\n\nThe conditions for all gestures are defined in this group. All these gestures are active only if the active window is Konqueror (class contains 'konqueror').";
        "khotkeysrc"."Data_2_7"."DataCount" = 4;
        "khotkeysrc"."Data_2_7"."Enabled" = false;
        "khotkeysrc"."Data_2_7"."Name" = "Konqi Gestures";
        "khotkeysrc"."Data_2_7"."SystemGroup" = 0;
        "khotkeysrc"."Data_2_7"."Type" = "ACTION_DATA_GROUP";
        "khotkeysrc"."Data_2_7Conditions"."Comment" = "Konqueror window";
        "khotkeysrc"."Data_2_7Conditions"."ConditionsCount" = 1;
        "khotkeysrc"."Data_2_7Conditions0"."Type" = "ACTIVE_WINDOW";
        "khotkeysrc"."Data_2_7Conditions0Window"."Comment" = "Konqueror";
        "khotkeysrc"."Data_2_7Conditions0Window"."WindowsCount" = 1;
        "khotkeysrc"."Data_2_7Conditions0Window0"."Class" = "konqueror";
        "khotkeysrc"."Data_2_7Conditions0Window0"."ClassType" = 1;
        "khotkeysrc"."Data_2_7Conditions0Window0"."Comment" = "Konqueror";
        "khotkeysrc"."Data_2_7Conditions0Window0"."Role" = "";
        "khotkeysrc"."Data_2_7Conditions0Window0"."RoleType" = 0;
        "khotkeysrc"."Data_2_7Conditions0Window0"."Title" = "";
        "khotkeysrc"."Data_2_7Conditions0Window0"."TitleType" = 0;
        "khotkeysrc"."Data_2_7Conditions0Window0"."Type" = "SIMPLE";
        "khotkeysrc"."Data_2_7Conditions0Window0"."WindowTypes" = 33;
        "khotkeysrc"."Data_2_7_1"."Comment" = "";
        "khotkeysrc"."Data_2_7_1"."Enabled" = false;
        "khotkeysrc"."Data_2_7_1"."Name" = "Back";
        "khotkeysrc"."Data_2_7_1"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_2_7_1Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_2_7_1Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_2_7_1Actions0"."Input" = "Alt+Left";
        "khotkeysrc"."Data_2_7_1Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_2_7_1Conditions"."Comment" = "";
        "khotkeysrc"."Data_2_7_1Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_2_7_1Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_2_7_1Triggers"."TriggersCount" = 3;
        "khotkeysrc"."Data_2_7_1Triggers0"."GesturePointData" = "0,0.0625,1,1,0.5,0.0625,0.0625,1,0.875,0.5,0.125,0.0625,1,0.75,0.5,0.1875,0.0625,1,0.625,0.5,0.25,0.0625,1,0.5,0.5,0.3125,0.0625,1,0.375,0.5,0.375,0.0625,1,0.25,0.5,0.4375,0.0625,1,0.125,0.5,0.5,0.0625,0,0,0.5,0.5625,0.0625,0,0.125,0.5,0.625,0.0625,0,0.25,0.5,0.6875,0.0625,0,0.375,0.5,0.75,0.0625,0,0.5,0.5,0.8125,0.0625,0,0.625,0.5,0.875,0.0625,0,0.75,0.5,0.9375,0.0625,0,0.875,0.5,1,0,0,1,0.5";
        "khotkeysrc"."Data_2_7_1Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_2_7_1Triggers1"."GesturePointData" = "0,0.0833333,1,0.5,0.5,0.0833333,0.0833333,1,0.375,0.5,0.166667,0.0833333,1,0.25,0.5,0.25,0.0833333,1,0.125,0.5,0.333333,0.0833333,0,0,0.5,0.416667,0.0833333,0,0.125,0.5,0.5,0.0833333,0,0.25,0.5,0.583333,0.0833333,0,0.375,0.5,0.666667,0.0833333,0,0.5,0.5,0.75,0.0833333,0,0.625,0.5,0.833333,0.0833333,0,0.75,0.5,0.916667,0.0833333,0,0.875,0.5,1,0,0,1,0.5";
        "khotkeysrc"."Data_2_7_1Triggers1"."Type" = "GESTURE";
        "khotkeysrc"."Data_2_7_1Triggers2"."GesturePointData" = "0,0.0833333,1,1,0.5,0.0833333,0.0833333,1,0.875,0.5,0.166667,0.0833333,1,0.75,0.5,0.25,0.0833333,1,0.625,0.5,0.333333,0.0833333,1,0.5,0.5,0.416667,0.0833333,1,0.375,0.5,0.5,0.0833333,1,0.25,0.5,0.583333,0.0833333,1,0.125,0.5,0.666667,0.0833333,0,0,0.5,0.75,0.0833333,0,0.125,0.5,0.833333,0.0833333,0,0.25,0.5,0.916667,0.0833333,0,0.375,0.5,1,0,0,0.5,0.5";
        "khotkeysrc"."Data_2_7_1Triggers2"."Type" = "GESTURE";
        "khotkeysrc"."Data_2_7_2"."Comment" = "";
        "khotkeysrc"."Data_2_7_2"."Enabled" = false;
        "khotkeysrc"."Data_2_7_2"."Name" = "Forward";
        "khotkeysrc"."Data_2_7_2"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_2_7_2Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_2_7_2Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_2_7_2Actions0"."Input" = "Alt+Right";
        "khotkeysrc"."Data_2_7_2Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_2_7_2Conditions"."Comment" = "";
        "khotkeysrc"."Data_2_7_2Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_2_7_2Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_2_7_2Triggers"."TriggersCount" = 3;
        "khotkeysrc"."Data_2_7_2Triggers0"."GesturePointData" = "0,0.0625,0,0,0.5,0.0625,0.0625,0,0.125,0.5,0.125,0.0625,0,0.25,0.5,0.1875,0.0625,0,0.375,0.5,0.25,0.0625,0,0.5,0.5,0.3125,0.0625,0,0.625,0.5,0.375,0.0625,0,0.75,0.5,0.4375,0.0625,0,0.875,0.5,0.5,0.0625,1,1,0.5,0.5625,0.0625,1,0.875,0.5,0.625,0.0625,1,0.75,0.5,0.6875,0.0625,1,0.625,0.5,0.75,0.0625,1,0.5,0.5,0.8125,0.0625,1,0.375,0.5,0.875,0.0625,1,0.25,0.5,0.9375,0.0625,1,0.125,0.5,1,0,0,0,0.5";
        "khotkeysrc"."Data_2_7_2Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_2_7_2Triggers1"."GesturePointData" = "0,0.0833333,0,0.5,0.5,0.0833333,0.0833333,0,0.625,0.5,0.166667,0.0833333,0,0.75,0.5,0.25,0.0833333,0,0.875,0.5,0.333333,0.0833333,1,1,0.5,0.416667,0.0833333,1,0.875,0.5,0.5,0.0833333,1,0.75,0.5,0.583333,0.0833333,1,0.625,0.5,0.666667,0.0833333,1,0.5,0.5,0.75,0.0833333,1,0.375,0.5,0.833333,0.0833333,1,0.25,0.5,0.916667,0.0833333,1,0.125,0.5,1,0,0,0,0.5";
        "khotkeysrc"."Data_2_7_2Triggers1"."Type" = "GESTURE";
        "khotkeysrc"."Data_2_7_2Triggers2"."GesturePointData" = "0,0.0833333,0,0,0.5,0.0833333,0.0833333,0,0.125,0.5,0.166667,0.0833333,0,0.25,0.5,0.25,0.0833333,0,0.375,0.5,0.333333,0.0833333,0,0.5,0.5,0.416667,0.0833333,0,0.625,0.5,0.5,0.0833333,0,0.75,0.5,0.583333,0.0833333,0,0.875,0.5,0.666667,0.0833333,1,1,0.5,0.75,0.0833333,1,0.875,0.5,0.833333,0.0833333,1,0.75,0.5,0.916667,0.0833333,1,0.625,0.5,1,0,0,0.5,0.5";
        "khotkeysrc"."Data_2_7_2Triggers2"."Type" = "GESTURE";
        "khotkeysrc"."Data_2_7_3"."Comment" = "";
        "khotkeysrc"."Data_2_7_3"."Enabled" = false;
        "khotkeysrc"."Data_2_7_3"."Name" = "Up";
        "khotkeysrc"."Data_2_7_3"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_2_7_3Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_2_7_3Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_2_7_3Actions0"."Input" = "Alt+Up";
        "khotkeysrc"."Data_2_7_3Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_2_7_3Conditions"."Comment" = "";
        "khotkeysrc"."Data_2_7_3Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_2_7_3Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_2_7_3Triggers"."TriggersCount" = 3;
        "khotkeysrc"."Data_2_7_3Triggers0"."GesturePointData" = "0,0.0625,-0.5,0.5,1,0.0625,0.0625,-0.5,0.5,0.875,0.125,0.0625,-0.5,0.5,0.75,0.1875,0.0625,-0.5,0.5,0.625,0.25,0.0625,-0.5,0.5,0.5,0.3125,0.0625,-0.5,0.5,0.375,0.375,0.0625,-0.5,0.5,0.25,0.4375,0.0625,-0.5,0.5,0.125,0.5,0.0625,0.5,0.5,0,0.5625,0.0625,0.5,0.5,0.125,0.625,0.0625,0.5,0.5,0.25,0.6875,0.0625,0.5,0.5,0.375,0.75,0.0625,0.5,0.5,0.5,0.8125,0.0625,0.5,0.5,0.625,0.875,0.0625,0.5,0.5,0.75,0.9375,0.0625,0.5,0.5,0.875,1,0,0,0.5,1";
        "khotkeysrc"."Data_2_7_3Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_2_7_3Triggers1"."GesturePointData" = "0,0.0833333,-0.5,0.5,1,0.0833333,0.0833333,-0.5,0.5,0.875,0.166667,0.0833333,-0.5,0.5,0.75,0.25,0.0833333,-0.5,0.5,0.625,0.333333,0.0833333,-0.5,0.5,0.5,0.416667,0.0833333,-0.5,0.5,0.375,0.5,0.0833333,-0.5,0.5,0.25,0.583333,0.0833333,-0.5,0.5,0.125,0.666667,0.0833333,0.5,0.5,0,0.75,0.0833333,0.5,0.5,0.125,0.833333,0.0833333,0.5,0.5,0.25,0.916667,0.0833333,0.5,0.5,0.375,1,0,0,0.5,0.5";
        "khotkeysrc"."Data_2_7_3Triggers1"."Type" = "GESTURE";
        "khotkeysrc"."Data_2_7_3Triggers2"."GesturePointData" = "0,0.0833333,-0.5,0.5,0.5,0.0833333,0.0833333,-0.5,0.5,0.375,0.166667,0.0833333,-0.5,0.5,0.25,0.25,0.0833333,-0.5,0.5,0.125,0.333333,0.0833333,0.5,0.5,0,0.416667,0.0833333,0.5,0.5,0.125,0.5,0.0833333,0.5,0.5,0.25,0.583333,0.0833333,0.5,0.5,0.375,0.666667,0.0833333,0.5,0.5,0.5,0.75,0.0833333,0.5,0.5,0.625,0.833333,0.0833333,0.5,0.5,0.75,0.916667,0.0833333,0.5,0.5,0.875,1,0,0,0.5,1";
        "khotkeysrc"."Data_2_7_3Triggers2"."Type" = "GESTURE";
        "khotkeysrc"."Data_2_7_4"."Comment" = "";
        "khotkeysrc"."Data_2_7_4"."Enabled" = false;
        "khotkeysrc"."Data_2_7_4"."Name" = "Reload";
        "khotkeysrc"."Data_2_7_4"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_2_7_4Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_2_7_4Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_2_7_4Actions0"."Input" = "F5";
        "khotkeysrc"."Data_2_7_4Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_2_7_4Conditions"."Comment" = "";
        "khotkeysrc"."Data_2_7_4Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_2_7_4Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_2_7_4Triggers"."TriggersCount" = 3;
        "khotkeysrc"."Data_2_7_4Triggers0"."GesturePointData" = "0,0.03125,0,0,1,0.03125,0.03125,0,0.125,1,0.0625,0.03125,0,0.25,1,0.09375,0.03125,0,0.375,1,0.125,0.03125,0,0.5,1,0.15625,0.03125,0,0.625,1,0.1875,0.03125,0,0.75,1,0.21875,0.03125,0,0.875,1,0.25,0.03125,-0.5,1,1,0.28125,0.03125,-0.5,1,0.875,0.3125,0.03125,-0.5,1,0.75,0.34375,0.03125,-0.5,1,0.625,0.375,0.03125,-0.5,1,0.5,0.40625,0.03125,-0.5,1,0.375,0.4375,0.03125,-0.5,1,0.25,0.46875,0.03125,-0.5,1,0.125,0.5,0.03125,1,1,0,0.53125,0.03125,1,0.875,0,0.5625,0.03125,1,0.75,0,0.59375,0.03125,1,0.625,0,0.625,0.03125,1,0.5,0,0.65625,0.03125,1,0.375,0,0.6875,0.03125,1,0.25,0,0.71875,0.03125,1,0.125,0,0.75,0.03125,0.5,0,0,0.78125,0.03125,0.5,0,0.125,0.8125,0.03125,0.5,0,0.25,0.84375,0.03125,0.5,0,0.375,0.875,0.03125,0.5,0,0.5,0.90625,0.03125,0.5,0,0.625,0.9375,0.03125,0.5,0,0.75,0.96875,0.03125,0.5,0,0.875,1,0,0,0,1";
        "khotkeysrc"."Data_2_7_4Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_2_7_4Triggers1"."GesturePointData" = "0,0.0277778,0,0,1,0.0277778,0.0277778,0,0.125,1,0.0555556,0.0277778,0,0.25,1,0.0833333,0.0277778,0,0.375,1,0.111111,0.0277778,0,0.5,1,0.138889,0.0277778,0,0.625,1,0.166667,0.0277778,0,0.75,1,0.194444,0.0277778,0,0.875,1,0.222222,0.0277778,-0.5,1,1,0.25,0.0277778,-0.5,1,0.875,0.277778,0.0277778,-0.5,1,0.75,0.305556,0.0277778,-0.5,1,0.625,0.333333,0.0277778,-0.5,1,0.5,0.361111,0.0277778,-0.5,1,0.375,0.388889,0.0277778,-0.5,1,0.25,0.416667,0.0277778,-0.5,1,0.125,0.444444,0.0277778,1,1,0,0.472222,0.0277778,1,0.875,0,0.5,0.0277778,1,0.75,0,0.527778,0.0277778,1,0.625,0,0.555556,0.0277778,1,0.5,0,0.583333,0.0277778,1,0.375,0,0.611111,0.0277778,1,0.25,0,0.638889,0.0277778,1,0.125,0,0.666667,0.0277778,0.5,0,0,0.694444,0.0277778,0.5,0,0.125,0.722222,0.0277778,0.5,0,0.25,0.75,0.0277778,0.5,0,0.375,0.777778,0.0277778,0.5,0,0.5,0.805556,0.0277778,0.5,0,0.625,0.833333,0.0277778,0.5,0,0.75,0.861111,0.0277778,0.5,0,0.875,0.888889,0.0277778,0,0,1,0.916667,0.0277778,0,0.125,1,0.944444,0.0277778,0,0.25,1,0.972222,0.0277778,0,0.375,1,1,0,0,0.5,1";
        "khotkeysrc"."Data_2_7_4Triggers1"."Type" = "GESTURE";
        "khotkeysrc"."Data_2_7_4Triggers2"."GesturePointData" = "0,0.0277778,0.5,0,0.5,0.0277778,0.0277778,0.5,0,0.625,0.0555556,0.0277778,0.5,0,0.75,0.0833333,0.0277778,0.5,0,0.875,0.111111,0.0277778,0,0,1,0.138889,0.0277778,0,0.125,1,0.166667,0.0277778,0,0.25,1,0.194444,0.0277778,0,0.375,1,0.222222,0.0277778,0,0.5,1,0.25,0.0277778,0,0.625,1,0.277778,0.0277778,0,0.75,1,0.305556,0.0277778,0,0.875,1,0.333333,0.0277778,-0.5,1,1,0.361111,0.0277778,-0.5,1,0.875,0.388889,0.0277778,-0.5,1,0.75,0.416667,0.0277778,-0.5,1,0.625,0.444444,0.0277778,-0.5,1,0.5,0.472222,0.0277778,-0.5,1,0.375,0.5,0.0277778,-0.5,1,0.25,0.527778,0.0277778,-0.5,1,0.125,0.555556,0.0277778,1,1,0,0.583333,0.0277778,1,0.875,0,0.611111,0.0277778,1,0.75,0,0.638889,0.0277778,1,0.625,0,0.666667,0.0277778,1,0.5,0,0.694444,0.0277778,1,0.375,0,0.722222,0.0277778,1,0.25,0,0.75,0.0277778,1,0.125,0,0.777778,0.0277778,0.5,0,0,0.805556,0.0277778,0.5,0,0.125,0.833333,0.0277778,0.5,0,0.25,0.861111,0.0277778,0.5,0,0.375,0.888889,0.0277778,0.5,0,0.5,0.916667,0.0277778,0.5,0,0.625,0.944444,0.0277778,0.5,0,0.75,0.972222,0.0277778,0.5,0,0.875,1,0,0,0,1";
        "khotkeysrc"."Data_2_7_4Triggers2"."Type" = "GESTURE";
        "khotkeysrc"."Data_2_8"."Comment" = "After pressing Win+E (Tux+E) a WWW browser will be launched, and it will open http://www.kde.org . You may run all kind of commands you can run in minicli (Alt+F2).";
        "khotkeysrc"."Data_2_8"."Enabled" = false;
        "khotkeysrc"."Data_2_8"."Name" = "Go to KDE Website";
        "khotkeysrc"."Data_2_8"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_2_8Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_2_8Actions0"."CommandURL" = "http://www.kde.org";
        "khotkeysrc"."Data_2_8Actions0"."Type" = "COMMAND_URL";
        "khotkeysrc"."Data_2_8Conditions"."Comment" = "";
        "khotkeysrc"."Data_2_8Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_2_8Triggers"."Comment" = "Simple_action";
        "khotkeysrc"."Data_2_8Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_2_8Triggers0"."Key" = "Meta+E";
        "khotkeysrc"."Data_2_8Triggers0"."Type" = "SHORTCUT";
        "khotkeysrc"."Data_3"."Comment" = "Basic Konqueror gestures.";
        "khotkeysrc"."Data_3"."DataCount" = 14;
        "khotkeysrc"."Data_3"."Enabled" = true;
        "khotkeysrc"."Data_3"."ImportId" = "konqueror_gestures_kde321";
        "khotkeysrc"."Data_3"."Name" = "Konqueror Gestures";
        "khotkeysrc"."Data_3"."SystemGroup" = 0;
        "khotkeysrc"."Data_3"."Type" = "ACTION_DATA_GROUP";
        "khotkeysrc"."Data_3Conditions"."Comment" = "Konqueror window";
        "khotkeysrc"."Data_3Conditions"."ConditionsCount" = 1;
        "khotkeysrc"."Data_3Conditions0"."Type" = "ACTIVE_WINDOW";
        "khotkeysrc"."Data_3Conditions0Window"."Comment" = "Konqueror";
        "khotkeysrc"."Data_3Conditions0Window"."WindowsCount" = 1;
        "khotkeysrc"."Data_3Conditions0Window0"."Class" = "^konquerors";
        "khotkeysrc"."Data_3Conditions0Window0"."ClassType" = 3;
        "khotkeysrc"."Data_3Conditions0Window0"."Comment" = "Konqueror";
        "khotkeysrc"."Data_3Conditions0Window0"."Role" = "konqueror-mainwindow#1";
        "khotkeysrc"."Data_3Conditions0Window0"."RoleType" = 0;
        "khotkeysrc"."Data_3Conditions0Window0"."Title" = "file:/ - Konqueror";
        "khotkeysrc"."Data_3Conditions0Window0"."TitleType" = 0;
        "khotkeysrc"."Data_3Conditions0Window0"."Type" = "SIMPLE";
        "khotkeysrc"."Data_3Conditions0Window0"."WindowTypes" = 1;
        "khotkeysrc"."Data_3_1"."Comment" = "Press, move left, release.";
        "khotkeysrc"."Data_3_1"."Enabled" = true;
        "khotkeysrc"."Data_3_1"."Name" = "Back";
        "khotkeysrc"."Data_3_1"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_3_10"."Comment" = "Opera-style: Press, move up, release.\nNOTE: Conflicts with 'New Tab', and as such is disabled by default.";
        "khotkeysrc"."Data_3_10"."Enabled" = false;
        "khotkeysrc"."Data_3_10"."Name" = "Stop Loading";
        "khotkeysrc"."Data_3_10"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_3_10Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_3_10Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_3_10Actions0"."Input" = "Escape\n";
        "khotkeysrc"."Data_3_10Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_3_10Conditions"."Comment" = "";
        "khotkeysrc"."Data_3_10Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_3_10Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_3_10Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_3_10Triggers0"."GesturePointData" = "0,0.125,-0.5,0.5,1,0.125,0.125,-0.5,0.5,0.875,0.25,0.125,-0.5,0.5,0.75,0.375,0.125,-0.5,0.5,0.625,0.5,0.125,-0.5,0.5,0.5,0.625,0.125,-0.5,0.5,0.375,0.75,0.125,-0.5,0.5,0.25,0.875,0.125,-0.5,0.5,0.125,1,0,0,0.5,0";
        "khotkeysrc"."Data_3_10Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_3_11"."Comment" = "Going up in URL/directory structure.\nMozilla-style: Press, move up, move left, move up, release.";
        "khotkeysrc"."Data_3_11"."Enabled" = true;
        "khotkeysrc"."Data_3_11"."Name" = "Up";
        "khotkeysrc"."Data_3_11"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_3_11Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_3_11Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_3_11Actions0"."Input" = "Alt+Up";
        "khotkeysrc"."Data_3_11Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_3_11Conditions"."Comment" = "";
        "khotkeysrc"."Data_3_11Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_3_11Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_3_11Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_3_11Triggers0"."GesturePointData" = "0,0.0625,-0.5,1,1,0.0625,0.0625,-0.5,1,0.875,0.125,0.0625,-0.5,1,0.75,0.1875,0.0625,-0.5,1,0.625,0.25,0.0625,1,1,0.5,0.3125,0.0625,1,0.875,0.5,0.375,0.0625,1,0.75,0.5,0.4375,0.0625,1,0.625,0.5,0.5,0.0625,1,0.5,0.5,0.5625,0.0625,1,0.375,0.5,0.625,0.0625,1,0.25,0.5,0.6875,0.0625,1,0.125,0.5,0.75,0.0625,-0.5,0,0.5,0.8125,0.0625,-0.5,0,0.375,0.875,0.0625,-0.5,0,0.25,0.9375,0.0625,-0.5,0,0.125,1,0,0,0,0";
        "khotkeysrc"."Data_3_11Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_3_12"."Comment" = "Going up in URL/directory structure.\nOpera-style: Press, move up, move left, move up, release.\nNOTE: Conflicts with  \"Activate Previous Tab\", and as such is disabled by default.";
        "khotkeysrc"."Data_3_12"."Enabled" = false;
        "khotkeysrc"."Data_3_12"."Name" = "Up #2";
        "khotkeysrc"."Data_3_12"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_3_12Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_3_12Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_3_12Actions0"."Input" = "Alt+Up\n";
        "khotkeysrc"."Data_3_12Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_3_12Conditions"."Comment" = "";
        "khotkeysrc"."Data_3_12Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_3_12Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_3_12Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_3_12Triggers0"."GesturePointData" = "0,0.0625,-0.5,1,1,0.0625,0.0625,-0.5,1,0.875,0.125,0.0625,-0.5,1,0.75,0.1875,0.0625,-0.5,1,0.625,0.25,0.0625,-0.5,1,0.5,0.3125,0.0625,-0.5,1,0.375,0.375,0.0625,-0.5,1,0.25,0.4375,0.0625,-0.5,1,0.125,0.5,0.0625,1,1,0,0.5625,0.0625,1,0.875,0,0.625,0.0625,1,0.75,0,0.6875,0.0625,1,0.625,0,0.75,0.0625,1,0.5,0,0.8125,0.0625,1,0.375,0,0.875,0.0625,1,0.25,0,0.9375,0.0625,1,0.125,0,1,0,0,0,0";
        "khotkeysrc"."Data_3_12Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_3_13"."Comment" = "Press, move up, move right, release.";
        "khotkeysrc"."Data_3_13"."Enabled" = true;
        "khotkeysrc"."Data_3_13"."Name" = "Activate Next Tab";
        "khotkeysrc"."Data_3_13"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_3_13Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_3_13Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_3_13Actions0"."Input" = "Ctrl+.\n";
        "khotkeysrc"."Data_3_13Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_3_13Conditions"."Comment" = "";
        "khotkeysrc"."Data_3_13Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_3_13Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_3_13Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_3_13Triggers0"."GesturePointData" = "0,0.0625,-0.5,0,1,0.0625,0.0625,-0.5,0,0.875,0.125,0.0625,-0.5,0,0.75,0.1875,0.0625,-0.5,0,0.625,0.25,0.0625,-0.5,0,0.5,0.3125,0.0625,-0.5,0,0.375,0.375,0.0625,-0.5,0,0.25,0.4375,0.0625,-0.5,0,0.125,0.5,0.0625,0,0,0,0.5625,0.0625,0,0.125,0,0.625,0.0625,0,0.25,0,0.6875,0.0625,0,0.375,0,0.75,0.0625,0,0.5,0,0.8125,0.0625,0,0.625,0,0.875,0.0625,0,0.75,0,0.9375,0.0625,0,0.875,0,1,0,0,1,0";
        "khotkeysrc"."Data_3_13Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_3_14"."Comment" = "Press, move up, move left, release.";
        "khotkeysrc"."Data_3_14"."Enabled" = true;
        "khotkeysrc"."Data_3_14"."Name" = "Activate Previous Tab";
        "khotkeysrc"."Data_3_14"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_3_14Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_3_14Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_3_14Actions0"."Input" = "Ctrl+,";
        "khotkeysrc"."Data_3_14Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_3_14Conditions"."Comment" = "";
        "khotkeysrc"."Data_3_14Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_3_14Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_3_14Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_3_14Triggers0"."GesturePointData" = "0,0.0625,-0.5,1,1,0.0625,0.0625,-0.5,1,0.875,0.125,0.0625,-0.5,1,0.75,0.1875,0.0625,-0.5,1,0.625,0.25,0.0625,-0.5,1,0.5,0.3125,0.0625,-0.5,1,0.375,0.375,0.0625,-0.5,1,0.25,0.4375,0.0625,-0.5,1,0.125,0.5,0.0625,1,1,0,0.5625,0.0625,1,0.875,0,0.625,0.0625,1,0.75,0,0.6875,0.0625,1,0.625,0,0.75,0.0625,1,0.5,0,0.8125,0.0625,1,0.375,0,0.875,0.0625,1,0.25,0,0.9375,0.0625,1,0.125,0,1,0,0,0,0";
        "khotkeysrc"."Data_3_14Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_3_1Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_3_1Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_3_1Actions0"."Input" = "Alt+Left";
        "khotkeysrc"."Data_3_1Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_3_1Conditions"."Comment" = "";
        "khotkeysrc"."Data_3_1Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_3_1Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_3_1Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_3_1Triggers0"."GesturePointData" = "0,0.125,1,1,0.5,0.125,0.125,1,0.875,0.5,0.25,0.125,1,0.75,0.5,0.375,0.125,1,0.625,0.5,0.5,0.125,1,0.5,0.5,0.625,0.125,1,0.375,0.5,0.75,0.125,1,0.25,0.5,0.875,0.125,1,0.125,0.5,1,0,0,0,0.5";
        "khotkeysrc"."Data_3_1Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_3_2"."Comment" = "Press, move down, move up, move down, release.";
        "khotkeysrc"."Data_3_2"."Enabled" = true;
        "khotkeysrc"."Data_3_2"."Name" = "Duplicate Tab";
        "khotkeysrc"."Data_3_2"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_3_2Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_3_2Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_3_2Actions0"."Input" = "Ctrl+Shift+D\n";
        "khotkeysrc"."Data_3_2Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_3_2Conditions"."Comment" = "";
        "khotkeysrc"."Data_3_2Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_3_2Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_3_2Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_3_2Triggers0"."GesturePointData" = "0,0.0416667,0.5,0.5,0,0.0416667,0.0416667,0.5,0.5,0.125,0.0833333,0.0416667,0.5,0.5,0.25,0.125,0.0416667,0.5,0.5,0.375,0.166667,0.0416667,0.5,0.5,0.5,0.208333,0.0416667,0.5,0.5,0.625,0.25,0.0416667,0.5,0.5,0.75,0.291667,0.0416667,0.5,0.5,0.875,0.333333,0.0416667,-0.5,0.5,1,0.375,0.0416667,-0.5,0.5,0.875,0.416667,0.0416667,-0.5,0.5,0.75,0.458333,0.0416667,-0.5,0.5,0.625,0.5,0.0416667,-0.5,0.5,0.5,0.541667,0.0416667,-0.5,0.5,0.375,0.583333,0.0416667,-0.5,0.5,0.25,0.625,0.0416667,-0.5,0.5,0.125,0.666667,0.0416667,0.5,0.5,0,0.708333,0.0416667,0.5,0.5,0.125,0.75,0.0416667,0.5,0.5,0.25,0.791667,0.0416667,0.5,0.5,0.375,0.833333,0.0416667,0.5,0.5,0.5,0.875,0.0416667,0.5,0.5,0.625,0.916667,0.0416667,0.5,0.5,0.75,0.958333,0.0416667,0.5,0.5,0.875,1,0,0,0.5,1";
        "khotkeysrc"."Data_3_2Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_3_3"."Comment" = "Press, move down, move up, release.";
        "khotkeysrc"."Data_3_3"."Enabled" = true;
        "khotkeysrc"."Data_3_3"."Name" = "Duplicate Window";
        "khotkeysrc"."Data_3_3"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_3_3Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_3_3Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_3_3Actions0"."Input" = "Ctrl+D\n";
        "khotkeysrc"."Data_3_3Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_3_3Conditions"."Comment" = "";
        "khotkeysrc"."Data_3_3Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_3_3Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_3_3Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_3_3Triggers0"."GesturePointData" = "0,0.0625,0.5,0.5,0,0.0625,0.0625,0.5,0.5,0.125,0.125,0.0625,0.5,0.5,0.25,0.1875,0.0625,0.5,0.5,0.375,0.25,0.0625,0.5,0.5,0.5,0.3125,0.0625,0.5,0.5,0.625,0.375,0.0625,0.5,0.5,0.75,0.4375,0.0625,0.5,0.5,0.875,0.5,0.0625,-0.5,0.5,1,0.5625,0.0625,-0.5,0.5,0.875,0.625,0.0625,-0.5,0.5,0.75,0.6875,0.0625,-0.5,0.5,0.625,0.75,0.0625,-0.5,0.5,0.5,0.8125,0.0625,-0.5,0.5,0.375,0.875,0.0625,-0.5,0.5,0.25,0.9375,0.0625,-0.5,0.5,0.125,1,0,0,0.5,0";
        "khotkeysrc"."Data_3_3Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_3_4"."Comment" = "Press, move right, release.";
        "khotkeysrc"."Data_3_4"."Enabled" = true;
        "khotkeysrc"."Data_3_4"."Name" = "Forward";
        "khotkeysrc"."Data_3_4"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_3_4Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_3_4Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_3_4Actions0"."Input" = "Alt+Right";
        "khotkeysrc"."Data_3_4Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_3_4Conditions"."Comment" = "";
        "khotkeysrc"."Data_3_4Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_3_4Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_3_4Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_3_4Triggers0"."GesturePointData" = "0,0.125,0,0,0.5,0.125,0.125,0,0.125,0.5,0.25,0.125,0,0.25,0.5,0.375,0.125,0,0.375,0.5,0.5,0.125,0,0.5,0.5,0.625,0.125,0,0.625,0.5,0.75,0.125,0,0.75,0.5,0.875,0.125,0,0.875,0.5,1,0,0,1,0.5";
        "khotkeysrc"."Data_3_4Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_3_5"."Comment" = "Press, move down, move half up, move right, move down, release.\n(Drawing a lowercase 'h'.)";
        "khotkeysrc"."Data_3_5"."Enabled" = true;
        "khotkeysrc"."Data_3_5"."Name" = "Home";
        "khotkeysrc"."Data_3_5"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_3_5Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_3_5Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_3_5Actions0"."Input" = "Alt+Home\n";
        "khotkeysrc"."Data_3_5Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_3_5Conditions"."Comment" = "";
        "khotkeysrc"."Data_3_5Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_3_5Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_3_5Triggers"."TriggersCount" = 2;
        "khotkeysrc"."Data_3_5Triggers0"."GesturePointData" = "0,0.0461748,0.5,0,0,0.0461748,0.0461748,0.5,0,0.125,0.0923495,0.0461748,0.5,0,0.25,0.138524,0.0461748,0.5,0,0.375,0.184699,0.0461748,0.5,0,0.5,0.230874,0.0461748,0.5,0,0.625,0.277049,0.0461748,0.5,0,0.75,0.323223,0.0461748,0.5,0,0.875,0.369398,0.065301,-0.25,0,1,0.434699,0.065301,-0.25,0.125,0.875,0.5,0.065301,-0.25,0.25,0.75,0.565301,0.065301,-0.25,0.375,0.625,0.630602,0.0461748,0,0.5,0.5,0.676777,0.0461748,0,0.625,0.5,0.722951,0.0461748,0,0.75,0.5,0.769126,0.0461748,0,0.875,0.5,0.815301,0.0461748,0.5,1,0.5,0.861476,0.0461748,0.5,1,0.625,0.90765,0.0461748,0.5,1,0.75,0.953825,0.0461748,0.5,1,0.875,1,0,0,1,1";
        "khotkeysrc"."Data_3_5Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_3_5Triggers1"."GesturePointData" = "0,0.0416667,0.5,0,0,0.0416667,0.0416667,0.5,0,0.125,0.0833333,0.0416667,0.5,0,0.25,0.125,0.0416667,0.5,0,0.375,0.166667,0.0416667,0.5,0,0.5,0.208333,0.0416667,0.5,0,0.625,0.25,0.0416667,0.5,0,0.75,0.291667,0.0416667,0.5,0,0.875,0.333333,0.0416667,-0.5,0,1,0.375,0.0416667,-0.5,0,0.875,0.416667,0.0416667,-0.5,0,0.75,0.458333,0.0416667,-0.5,0,0.625,0.5,0.0416667,0,0,0.5,0.541667,0.0416667,0,0.125,0.5,0.583333,0.0416667,0,0.25,0.5,0.625,0.0416667,0,0.375,0.5,0.666667,0.0416667,0,0.5,0.5,0.708333,0.0416667,0,0.625,0.5,0.75,0.0416667,0,0.75,0.5,0.791667,0.0416667,0,0.875,0.5,0.833333,0.0416667,0.5,1,0.5,0.875,0.0416667,0.5,1,0.625,0.916667,0.0416667,0.5,1,0.75,0.958333,0.0416667,0.5,1,0.875,1,0,0,1,1";
        "khotkeysrc"."Data_3_5Triggers1"."Type" = "GESTURE";
        "khotkeysrc"."Data_3_6"."Comment" = "Press, move right, move down, move right, release.\nMozilla-style: Press, move down, move right, release.";
        "khotkeysrc"."Data_3_6"."Enabled" = true;
        "khotkeysrc"."Data_3_6"."Name" = "Close Tab";
        "khotkeysrc"."Data_3_6"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_3_6Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_3_6Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_3_6Actions0"."Input" = "Ctrl+W\n";
        "khotkeysrc"."Data_3_6Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_3_6Conditions"."Comment" = "";
        "khotkeysrc"."Data_3_6Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_3_6Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_3_6Triggers"."TriggersCount" = 2;
        "khotkeysrc"."Data_3_6Triggers0"."GesturePointData" = "0,0.0625,0,0,0,0.0625,0.0625,0,0.125,0,0.125,0.0625,0,0.25,0,0.1875,0.0625,0,0.375,0,0.25,0.0625,0.5,0.5,0,0.3125,0.0625,0.5,0.5,0.125,0.375,0.0625,0.5,0.5,0.25,0.4375,0.0625,0.5,0.5,0.375,0.5,0.0625,0.5,0.5,0.5,0.5625,0.0625,0.5,0.5,0.625,0.625,0.0625,0.5,0.5,0.75,0.6875,0.0625,0.5,0.5,0.875,0.75,0.0625,0,0.5,1,0.8125,0.0625,0,0.625,1,0.875,0.0625,0,0.75,1,0.9375,0.0625,0,0.875,1,1,0,0,1,1";
        "khotkeysrc"."Data_3_6Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_3_6Triggers1"."GesturePointData" = "0,0.0625,0.5,0,0,0.0625,0.0625,0.5,0,0.125,0.125,0.0625,0.5,0,0.25,0.1875,0.0625,0.5,0,0.375,0.25,0.0625,0.5,0,0.5,0.3125,0.0625,0.5,0,0.625,0.375,0.0625,0.5,0,0.75,0.4375,0.0625,0.5,0,0.875,0.5,0.0625,0,0,1,0.5625,0.0625,0,0.125,1,0.625,0.0625,0,0.25,1,0.6875,0.0625,0,0.375,1,0.75,0.0625,0,0.5,1,0.8125,0.0625,0,0.625,1,0.875,0.0625,0,0.75,1,0.9375,0.0625,0,0.875,1,1,0,0,1,1";
        "khotkeysrc"."Data_3_6Triggers1"."Type" = "GESTURE";
        "khotkeysrc"."Data_3_7"."Comment" = "Press, move up, release.\nConflicts with Opera-style 'Up #2', which is disabled by default.";
        "khotkeysrc"."Data_3_7"."Enabled" = true;
        "khotkeysrc"."Data_3_7"."Name" = "New Tab";
        "khotkeysrc"."Data_3_7"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_3_7Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_3_7Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_3_7Actions0"."Input" = "Ctrl+Shift+N";
        "khotkeysrc"."Data_3_7Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_3_7Conditions"."Comment" = "";
        "khotkeysrc"."Data_3_7Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_3_7Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_3_7Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_3_7Triggers0"."GesturePointData" = "0,0.125,-0.5,0.5,1,0.125,0.125,-0.5,0.5,0.875,0.25,0.125,-0.5,0.5,0.75,0.375,0.125,-0.5,0.5,0.625,0.5,0.125,-0.5,0.5,0.5,0.625,0.125,-0.5,0.5,0.375,0.75,0.125,-0.5,0.5,0.25,0.875,0.125,-0.5,0.5,0.125,1,0,0,0.5,0";
        "khotkeysrc"."Data_3_7Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_3_8"."Comment" = "Press, move down, release.";
        "khotkeysrc"."Data_3_8"."Enabled" = true;
        "khotkeysrc"."Data_3_8"."Name" = "New Window";
        "khotkeysrc"."Data_3_8"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_3_8Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_3_8Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_3_8Actions0"."Input" = "Ctrl+N\n";
        "khotkeysrc"."Data_3_8Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_3_8Conditions"."Comment" = "";
        "khotkeysrc"."Data_3_8Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_3_8Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_3_8Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_3_8Triggers0"."GesturePointData" = "0,0.125,0.5,0.5,0,0.125,0.125,0.5,0.5,0.125,0.25,0.125,0.5,0.5,0.25,0.375,0.125,0.5,0.5,0.375,0.5,0.125,0.5,0.5,0.5,0.625,0.125,0.5,0.5,0.625,0.75,0.125,0.5,0.5,0.75,0.875,0.125,0.5,0.5,0.875,1,0,0,0.5,1";
        "khotkeysrc"."Data_3_8Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."Data_3_9"."Comment" = "Press, move up, move down, release.";
        "khotkeysrc"."Data_3_9"."Enabled" = true;
        "khotkeysrc"."Data_3_9"."Name" = "Reload";
        "khotkeysrc"."Data_3_9"."Type" = "SIMPLE_ACTION_DATA";
        "khotkeysrc"."Data_3_9Actions"."ActionsCount" = 1;
        "khotkeysrc"."Data_3_9Actions0"."DestinationWindow" = 2;
        "khotkeysrc"."Data_3_9Actions0"."Input" = "F5";
        "khotkeysrc"."Data_3_9Actions0"."Type" = "KEYBOARD_INPUT";
        "khotkeysrc"."Data_3_9Conditions"."Comment" = "";
        "khotkeysrc"."Data_3_9Conditions"."ConditionsCount" = 0;
        "khotkeysrc"."Data_3_9Triggers"."Comment" = "Gesture_triggers";
        "khotkeysrc"."Data_3_9Triggers"."TriggersCount" = 1;
        "khotkeysrc"."Data_3_9Triggers0"."GesturePointData" = "0,0.0625,-0.5,0.5,1,0.0625,0.0625,-0.5,0.5,0.875,0.125,0.0625,-0.5,0.5,0.75,0.1875,0.0625,-0.5,0.5,0.625,0.25,0.0625,-0.5,0.5,0.5,0.3125,0.0625,-0.5,0.5,0.375,0.375,0.0625,-0.5,0.5,0.25,0.4375,0.0625,-0.5,0.5,0.125,0.5,0.0625,0.5,0.5,0,0.5625,0.0625,0.5,0.5,0.125,0.625,0.0625,0.5,0.5,0.25,0.6875,0.0625,0.5,0.5,0.375,0.75,0.0625,0.5,0.5,0.5,0.8125,0.0625,0.5,0.5,0.625,0.875,0.0625,0.5,0.5,0.75,0.9375,0.0625,0.5,0.5,0.875,1,0,0,0.5,1";
        "khotkeysrc"."Data_3_9Triggers0"."Type" = "GESTURE";
        "khotkeysrc"."DirSelect Dialog"."DirSelectDialog Size\x5b$d\x5d" = "";
        "khotkeysrc"."General"."BrowserApplication\x5b$d\x5d" = "";
        "khotkeysrc"."General"."ColorSchemeHash\x5b$d\x5d" = "";
        "khotkeysrc"."General"."ColorScheme\x5b$d\x5d" = "";
        "khotkeysrc"."Gestures"."Disabled" = true;
        "khotkeysrc"."Gestures"."MouseButton" = 2;
        "khotkeysrc"."Gestures"."Timeout" = 300;
        "khotkeysrc"."GesturesExclude"."Comment" = "";
        "khotkeysrc"."GesturesExclude"."WindowsCount" = 0;
        "khotkeysrc"."Icons"."Theme\x5b$d\x5d" = "";
        "khotkeysrc"."KDE"."LookAndFeelPackage\x5b$d\x5d" = "";
        "khotkeysrc"."KDE"."ScrollbarLeftClickNavigatesByPage\x5b$d\x5d" = "";
        "khotkeysrc"."KDE"."ShowDeleteCommand\x5b$d\x5d" = "";
        "khotkeysrc"."KDE"."SingleClick\x5b$d\x5d" = "";
        "khotkeysrc"."KDE"."widgetStyle\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Allow Expansion\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Automatically select filename extension\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Breadcrumb Navigation\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Decoration position\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."LocationCombo Completionmode\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."PathCombo Completionmode\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Preview Width\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Show Bookmarks\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Show Full Path\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Show Inline Previews\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Show Preview\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Show Speedbar\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Show hidden files\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Sort by\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Sort directories first\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Sort hidden files last\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Sort reversed\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."Speedbar Width\x5b$d\x5d" = "";
        "khotkeysrc"."KFileDialog Settings"."View Style\x5b$d\x5d" = "";
        "khotkeysrc"."Main"."AlreadyImported" = "defaults,kde32b1,konqueror_gestures_kde321";
        "khotkeysrc"."Main"."Disabled" = false;
        "khotkeysrc"."PreviewSettings"."MaximumRemoteSize\x5b$d\x5d" = "";
        "khotkeysrc"."Voice"."Shortcut" = "";
        "khotkeysrc"."WM"."activeBackground\x5b$d\x5d" = "";
        "khotkeysrc"."WM"."activeBlend\x5b$d\x5d" = "";
        "khotkeysrc"."WM"."activeForeground\x5b$d\x5d" = "";
        "khotkeysrc"."WM"."inactiveBackground\x5b$d\x5d" = "";
        "khotkeysrc"."WM"."inactiveBlend\x5b$d\x5d" = "";
        "khotkeysrc"."WM"."inactiveForeground\x5b$d\x5d" = "";
        "kiorc"."Confirmations"."ConfirmDelete" = true;
        "kiorc"."Confirmations"."ConfirmEmptyTrash" = true;
        "kiorc"."Confirmations"."ConfirmTrash" = false;
        "kiorc"."Executable scripts"."behaviourOnLaunch" = "alwaysAsk";
        "krunnerrc"."Plugins"."baloosearchEnabled" = true;
        "krunnerrc"."General"."FreeFloating" = true;
        "krunnerrc"."General"."historyBehavior" = "ImmediateCompletion";
        "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."Image" = "${config.xdg.userDirs.pictures}/Desktopbilder/The Witcher/21-9/2812711.jpg";
        "kservicemenurc"."Show"."compressfileitemaction" = true;
        "kservicemenurc"."Show"."extractfileitemaction" = true;
        "kservicemenurc"."Show"."forgetfileitemaction" = true;
        "kservicemenurc"."Show"."installFont" = true;
        "kservicemenurc"."Show"."kactivitymanagerd_fileitem_linking_plugin" = true;
        "kservicemenurc"."Show"."kdeconnectfileitemaction" = true;
        "kservicemenurc"."Show"."kio-admin" = true;
        "kservicemenurc"."Show"."kompare" = true;
        "kservicemenurc"."Show"."makefileactions" = true;
        "kservicemenurc"."Show"."mountisoaction" = true;
        "kservicemenurc"."Show"."runInKonsole" = true;
        "kservicemenurc"."Show"."setAsWallpaper" = true;
        "kservicemenurc"."Show"."slideshowfileitemaction" = true;
        "kservicemenurc"."Show"."tagsfileitemaction" = true;
        "kservicemenurc"."Show"."wallpaperfileitemaction" = true;
        "ksmserverrc"."General"."loginMode" = "emptySession";
        "ksplashrc"."KSplash"."Engine" = "none";
        "ksplashrc"."KSplash"."Theme" = "none";
        "kwalletrc"."Wallet"."First Use" = false;
        "kwinrc"."Effect-overview"."TouchBorderActivate" = 4;
        "kwinrc"."Effect-windowview"."BorderActivateAll" = 9;
        "kwinrc"."ElectricBorders"."BottomRight" = "ShowDesktop";
        "kwinrc"."NightColor"."Active" = true;
        "kwinrc"."NightColor"."LatitudeAuto" = 50.83;
        "kwinrc"."NightColor"."LongitudeAuto" = 8.1;
        "kwinrc"."NightColor"."NightTemperature" = 3500;
        "kwinrc"."Plugins"."blurEnabled" = true;
        "kwinrc"."Plugins"."dimscreenEnabled" = true;
        "kwinrc"."Plugins"."kwin4_effect_dimscreenEnabled" = true;
        "kwinrc"."Plugins"."kwin4_effect_translucencyEnabled" = true;
        "kwinrc"."Plugins"."translucencyEnabled" = true;
        "kwinrc"."TabBox"."LayoutName" = "thumbnail_grid";
        "kwinrc"."TabBoxAlternative"."LayoutName" = "big_icons";
        "kwinrc"."Tiling"."padding" = 4;
        "kwinrc"."TouchEdges"."Left" = "ApplicationLauncher";
        "kwinrc"."TouchEdges"."Right" = "LockScreen";
        "kwinrc"."TouchEdges"."Top" = "KRunner";
        "kwinrc"."Wayland"."InputMethod[$e]" = "/run/current-system/sw/share/applications/com.github.maliit.keyboard.desktop";
        "kwinrc"."Wayland"."InputMethodx5b$ex5" = "/run/current-system/sw/share/applications/com.github.maliit.keyboard.desktop";
        "kwinrc"."Wayland"."VirtualKeyboardEnabled" = true;
        "kwinrc"."Xwayland"."Scale" = 1;
        "kwinrc"."org.kde.kdecoration2"."ButtonsOnLeft" = "F";
        "kxkbrc"."Layout"."LayoutList" = "de";
        "kxkbrc"."Layout"."Use" = true;
        "plasma_calendar_holiday_regions"."General"."selectedRegions" = "de_de";
        "plasma-localerc"."Formats"."LANG" = "en_US.UTF-8";
        "plasma-localerc"."Formats"."LC_ADDRESS" = "de_DE.UTF-8";
        "plasma-localerc"."Formats"."LC_MEASUREMENT" = "de_DE.UTF-8";
        "plasma-localerc"."Formats"."LC_MONETARY" = "de_DE.UTF-8";
        "plasma-localerc"."Formats"."LC_NAME" = "de_DE.UTF-8";
        "plasma-localerc"."Formats"."LC_NUMERIC" = "de_DE.UTF-8";
        "plasma-localerc"."Formats"."LC_PAPER" = "de_DE.UTF-8";
        "plasma-localerc"."Formats"."LC_TELEPHONE" = "de_DE.UTF-8";
        "plasma-localerc"."Formats"."LC_TIME" = "de_DE.UTF-8";
        "plasmanotifyrc"."Notifications"."LowPriorityHistory" = true;
        "plasmanotifyrc"."DoNotDisturb"."WhenScreensMirrored" = false;
        "systemsettingsrc"."KFileDialog Settings"."detailViewIconSize" = 64;
        "systemsettingsrc"."MainWindow"."MenuBar" = "Disabled";
        "kactivitymanagerd-pluginsrc"."Plugin-org.kde.ActivityManager.Resources.Scoring"."keep-history-for" = 1;
        "konsolerc"."KonsoleWindow"."ShowWindowTitleOnTitleBar" = true;
        "konsolerc"."MainWindow"."ToolBarsMovable" = "Disabled";
        "konsolerc"."TabBar"."CloseTabOnMiddleMouseButton" = true;
        "konsolerc"."UiSettings"."ColorScheme" = "";
        "katerc"."General"."Allow Tab Scrolling" = true;
        "katerc"."General"."Auto Hide Tabs" = false;
        "katerc"."General"."Close After Last" = false;
        "katerc"."General"."Close documents with window" = true;
        "katerc"."General"."Days Meta Infos" = 30;
        "katerc"."General"."Diff Show Style" = 0;
        "katerc"."General"."Elide Tab Text" = false;
        "katerc"."General"."Expand Tabs" = false;
        "katerc"."General"."Icon size for left and right sidebar buttons" = 32;
        "katerc"."General"."Modified Notification" = false;
        "katerc"."General"."Mouse back button action" = 0;
        "katerc"."General"."Mouse forward button action" = 0;
        "katerc"."General"."Open New Tab To The Right Of Current" = false;
        "katerc"."General"."Output History Limit" = 100;
        "katerc"."General"."Recent File List Entry Count" = 10;
        "katerc"."General"."Restore Window Configuration" = true;
        "katerc"."General"."Save Meta Infos" = true;
        "katerc"."General"."Show Full Path in Title" = false;
        "katerc"."General"."Show Menu Bar" = true;
        "katerc"."General"."Show Status Bar" = true;
        "katerc"."General"."Show Symbol In Navigation Bar" = true;
        "katerc"."General"."Show Tab Bar" = true;
        "katerc"."General"."Show Tabs Close Button" = true;
        "katerc"."General"."Show Url Nav Bar" = true;
        "katerc"."General"."Show output view for message type" = 1;
        "katerc"."General"."Show text for left and right sidebar" = false;
        "katerc"."General"."Show welcome view for new window" = true;
        "katerc"."General"."Startup Session" = "new";
        "katerc"."General"."Stash new unsaved files" = true;
        "katerc"."General"."Stash unsaved file changes" = false;
        "katerc"."General"."Sync section size with tab positions" = false;
        "katerc"."General"."Tab Double Click New Document" = true;
        "katerc"."General"."Tab Middle Click Close Document" = true;
        "katerc"."General"."Tabbar Tab Limit" = 0;
        "katerc"."KTextEditor Document"."Allow End of Line Detection" = true;
        "katerc"."KTextEditor Document"."Auto Detect Indent" = true;
        "katerc"."KTextEditor Document"."Auto Reload If State Is In Version Control" = true;
        "katerc"."KTextEditor Document"."Auto Save" = false;
        "katerc"."KTextEditor Document"."Auto Save Interval" = 0;
        "katerc"."KTextEditor Document"."Auto Save On Focus Out" = false;
        "katerc"."KTextEditor Document"."BOM" = false;
        "katerc"."KTextEditor Document"."Camel Cursor" = true;
        "katerc"."KTextEditor Document"."Encoding" = "UTF-8";
        "katerc"."KTextEditor Document"."End of Line" = 0;
        "katerc"."KTextEditor Document"."Indent On Backspace" = true;
        "katerc"."KTextEditor Document"."Indent On Tab" = true;
        "katerc"."KTextEditor Document"."Indent On Text Paste" = true;
        "katerc"."KTextEditor Document"."Indentation Mode" = "normal";
        "katerc"."KTextEditor Document"."Indentation Width" = 2;
        "katerc"."KTextEditor Document"."Keep Extra Spaces" = false;
        "katerc"."KTextEditor Document"."Line Length Limit" = 10000;
        "katerc"."KTextEditor Document"."Newline at End of File" = true;
        "katerc"."KTextEditor Document"."On-The-Fly Spellcheck" = true;
        "katerc"."KTextEditor Document"."Overwrite Mode" = false;
        "katerc"."KTextEditor Document"."PageUp/PageDown Moves Cursor" = false;
        "katerc"."KTextEditor Document"."Remove Spaces" = 1;
        "katerc"."KTextEditor Document"."ReplaceTabsDyn" = true;
        "katerc"."KTextEditor Document"."Show Spaces" = 0;
        "katerc"."KTextEditor Document"."Show Tabs" = true;
        "katerc"."KTextEditor Document"."Smart Home" = true;
        "katerc"."KTextEditor Document"."Tab Handling" = 2;
        "katerc"."KTextEditor Document"."Tab Width" = 4;
        "katerc"."KTextEditor Document"."Trailing Marker Size" = 1;
        "katerc"."KTextEditor Document"."Word Wrap" = false;
        "katerc"."KTextEditor Document"."Word Wrap Column" = 80;
        "katerc"."KTextEditor Renderer"."Animate Bracket Matching" = false;
        "katerc"."KTextEditor Renderer"."Auto Color Theme Selection" = true;
        "katerc"."KTextEditor Renderer"."Line Height Multiplier" = 1;
        "katerc"."KTextEditor Renderer"."Show Indentation Lines" = true;
        "katerc"."KTextEditor Renderer"."Show Whole Bracket Expression" = true;
        "katerc"."KTextEditor Renderer"."Word Wrap Marker" = false;
        "katerc"."KTextEditor View"."Allow Mark Menu" = true;
        "katerc"."KTextEditor View"."Auto Brackets" = true;
        "katerc"."KTextEditor View"."Auto Center Lines" = 0;
        "katerc"."KTextEditor View"."Auto Completion" = true;
        "katerc"."KTextEditor View"."Auto Completion Preselect First Entry" = true;
        "katerc"."KTextEditor View"."Backspace Remove Composed Characters" = false;
        "katerc"."KTextEditor View"."Bookmark Menu Sorting" = 0;
        "katerc"."KTextEditor View"."Bracket Match Preview" = true;
        "katerc"."KTextEditor View"."Default Mark Type" = 1;
        "katerc"."KTextEditor View"."Dynamic Word Wrap" = true;
        "katerc"."KTextEditor View"."Dynamic Word Wrap Align Indent" = 80;
        "katerc"."KTextEditor View"."Dynamic Word Wrap At Static Marker" = false;
        "katerc"."KTextEditor View"."Dynamic Word Wrap Indicators" = 0;
        "katerc"."KTextEditor View"."Dynamic Wrap not at word boundaries" = false;
        "katerc"."KTextEditor View"."Enable Accessibility" = true;
        "katerc"."KTextEditor View"."Enable Tab completion" = false;
        "katerc"."KTextEditor View"."Enter To Insert Completion" = true;
        "katerc"."KTextEditor View"."Fold First Line" = false;
        "katerc"."KTextEditor View"."Folding Bar" = true;
        "katerc"."KTextEditor View"."Folding Preview" = true;
        "katerc"."KTextEditor View"."Icon Bar" = false;
        "katerc"."KTextEditor View"."Input Mode" = 0;
        "katerc"."KTextEditor View"."Keyword Completion" = true;
        "katerc"."KTextEditor View"."Line Modification" = true;
        "katerc"."KTextEditor View"."Line Numbers" = true;
        "katerc"."KTextEditor View"."Max Clipboard History Entries" = 20;
        "katerc"."KTextEditor View"."Maximum Search History Size" = 100;
        "katerc"."KTextEditor View"."Mouse Paste At Cursor Position" = false;
        "katerc"."KTextEditor View"."Multiple Cursor Modifier" = 134217728;
        "katerc"."KTextEditor View"."Persistent Selection" = false;
        "katerc"."KTextEditor View"."Scroll Bar Marks" = false;
        "katerc"."KTextEditor View"."Scroll Bar Mini Map All" = true;
        "katerc"."KTextEditor View"."Scroll Bar Mini Map Width" = 60;
        "katerc"."KTextEditor View"."Scroll Bar MiniMap" = true;
        "katerc"."KTextEditor View"."Scroll Bar Preview" = true;
        "katerc"."KTextEditor View"."Scroll Past End" = false;
        "katerc"."KTextEditor View"."Search/Replace Flags" = 140;
        "katerc"."KTextEditor View"."Shoe Line Ending Type in Statusbar" = false;
        "katerc"."KTextEditor View"."Show Documentation With Completion" = true;
        "katerc"."KTextEditor View"."Show File Encoding" = true;
        "katerc"."KTextEditor View"."Show Folding Icons On Hover Only" = true;
        "katerc"."KTextEditor View"."Show Line Count" = true;
        "katerc"."KTextEditor View"."Show Scrollbars" = 0;
        "katerc"."KTextEditor View"."Show Statusbar Dictionary" = true;
        "katerc"."KTextEditor View"."Show Statusbar Highlighting Mode" = true;
        "katerc"."KTextEditor View"."Show Statusbar Input Mode" = true;
        "katerc"."KTextEditor View"."Show Statusbar Line Column" = true;
        "katerc"."KTextEditor View"."Show Statusbar Tab Settings" = true;
        "katerc"."KTextEditor View"."Show Word Count" = true;
        "katerc"."KTextEditor View"."Smart Copy Cut" = true;
        "katerc"."KTextEditor View"."Statusbar Line Column Compact Mode" = true;
        "katerc"."KTextEditor View"."Text Drag And Drop" = true;
        "katerc"."KTextEditor View"."Vi Input Mode Steal Keys" = false;
        "katerc"."KTextEditor View"."Vi Relative Line Numbers" = false;
        "katerc"."KTextEditor View"."Word Completion" = true;
        "katerc"."KTextEditor View"."Word Completion Minimal Word Length" = 3;
        "katerc"."KTextEditor View"."Word Completion Remove Tail" = true;
        "katerc"."Konsole"."AutoSyncronize" = true;
        "katerc"."Konsole"."KonsoleEscKeyBehaviour" = true;
        "katerc"."Konsole"."KonsoleEscKeyExceptions" = "vi,vim,nvim,git";
        "katerc"."Konsole"."RemoveExtension" = false;
        "katerc"."Konsole"."SetEditor" = false;
        "katerc"."filetree"."listMode" = false;
        "katerc"."filetree"."shadingEnabled" = true;
        "katerc"."filetree"."showCloseButton" = false;
        "katerc"."filetree"."showFullPathOnRoots" = false;
        "katerc"."filetree"."showToolbar" = true;
        "katerc"."filetree"."sortRole" = 0;
        "katerc"."lspclient"."AutoHover" = true;
        "katerc"."lspclient"."AutoImport" = true;
        "katerc"."lspclient"."CompletionDocumentation" = true;
        "katerc"."lspclient"."CompletionParens" = true;
        "katerc"."lspclient"."Diagnostics" = true;
        "katerc"."lspclient"."FormatOnSave" = false;
        "katerc"."lspclient"."HighlightGoto" = true;
        "katerc"."lspclient"."IncrementalSync" = false;
        "katerc"."lspclient"."InlayHints" = false;
        "katerc"."lspclient"."Messages" = true;
        "katerc"."lspclient"."ReferencesDeclaration" = true;
        "katerc"."lspclient"."SemanticHighlighting" = true;
        "katerc"."lspclient"."SignatureHelp" = true;
        "katerc"."lspclient"."SymbolDetails" = false;
        "katerc"."lspclient"."SymbolExpand" = true;
        "katerc"."lspclient"."SymbolSort" = false;
        "katerc"."lspclient"."SymbolTree" = true;
        "katerc"."lspclient"."TypeFormatting" = true;
        "soundkonverterrc"."General"."defaultFormat" = "Last used";
        "soundkonverterrc"."General"."defaultProfile" = "Last used";
        "soundkonverterrc"."General"."lastFormat" = "flac";
        "soundkonverterrc"."General"."lastProfile" = "Lossless";
        "soundkonverterrc"."General"."lastOutputDirectoryMode" = "";
        "ktrashrc"."/home/jf/.local/share/Trash"."Days" = 7;
        "ktrashrc"."/home/jf/.local/share/Trash"."Percent" = 10;
        "ktrashrc"."/home/jf/.local/share/Trash"."UseSizeLimit" = true;
        "ktrashrc"."/home/jf/.local/share/Trash"."UseTimeLimit" = true;
        "ktrashrc"."/mount/Backup/.Trash-1000"."Days" = 7;
        "ktrashrc"."/mount/Backup/.Trash-1000"."Percent" = 10;
        "ktrashrc"."/mount/Backup/.Trash-1000"."UseSizeLimit" = true;
        "ktrashrc"."/mount/Backup/.Trash-1000"."UseTimeLimit" = true;
        "ktrashrc"."/mount/Data/.Trash-1000"."Days" = 7;
        "ktrashrc"."/mount/Data/.Trash-1000"."Percent" = 10;
        "ktrashrc"."/mount/Data/.Trash-1000"."UseSizeLimit" = true;
        "ktrashrc"."/mount/Data/.Trash-1000"."UseTimeLimit" = true;
        "ktrashrc"."/mount/Games/.Trash-1000"."Days" = 7;
        "ktrashrc"."/mount/Games/.Trash-1000"."Percent" = 10;
        "ktrashrc"."/mount/Games/.Trash-1000"."UseSizeLimit" = true;
        "ktrashrc"."/mount/Games/.Trash-1000"."UseTimeLimit" = true;
      };
    };
  };
}