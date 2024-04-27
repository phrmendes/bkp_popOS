{
  config,
  lib,
  pkgs,
  parameters,
  ...
}: {
  options.plasma-manager.enable = lib.mkEnableOption "enable plasma manager";

  config = lib.mkIf config.plasma-manager.enable {
    programs.plasma = {
      enable = true;
      hotkeys.commands."launch-kitty" = {
        name = "Terminal";
        key = "Meta+Return";
        command = "kitty";
      };
      shortcuts = {
        "kmix"."decrease_microphone_volume" = "Microphone Volume Down";
        "kmix"."decrease_volume" = "Volume Down";
        "kmix"."decrease_volume_small" = "Shift+Volume Down";
        "kmix"."increase_microphone_volume" = "Microphone Volume Up";
        "kmix"."increase_volume" = "Volume Up";
        "kmix"."increase_volume_small" = "Shift+Volume Up";
        "kmix"."mic_mute" = ["Microphone Mute" "Meta+Volume Mute"];
        "kmix"."mute" = "Volume Mute";
        "ksmserver"."Halt Without Confirmation" = [];
        "ksmserver"."Lock Session" = ["Meta+Esc" "Screensaver"];
        "ksmserver"."Log Out Without Confirmation" = [];
        "ksmserver"."Log Out" = "Ctrl+Alt+Del";
        "ksmserver"."Reboot Without Confirmation" = [];
        "ksmserver"."Reboot" = [];
        "ksmserver"."Shut Down" = [];
        "kwin"."Activate Window Demanding Attention" = [];
        "kwin"."Cycle Overview Opposite" = [];
        "kwin"."Cycle Overview" = [];
        "kwin"."Decrease Opacity" = [];
        "kwin"."Edit Tiles" = "Meta+T";
        "kwin"."Expose" = [];
        "kwin"."ExposeAll" = [];
        "kwin"."ExposeClass" = [];
        "kwin"."ExposeClassCurrentDesktop" = [];
        "kwin"."Grid View" = "Meta+G";
        "kwin"."Increase Opacity" = [];
        "kwin"."Kill Window" = "Meta+Shift+Q";
        "kwin"."Move Tablet to Next Output" = [];
        "kwin"."MoveMouseToCenter" = "Meta+F6";
        "kwin"."MoveMouseToFocus" = "Meta+F5";
        "kwin"."MoveZoomDown" = [];
        "kwin"."MoveZoomLeft" = [];
        "kwin"."MoveZoomRight" = [];
        "kwin"."MoveZoomUp" = [];
        "kwin"."Overview" = "Meta+W";
        "kwin"."PoloniumFocusAbove" = [];
        "kwin"."PoloniumFocusBelow" = [];
        "kwin"."PoloniumFocusLeft" = [];
        "kwin"."PoloniumFocusRight" = [];
        "kwin"."PoloniumInsertAbove" = [];
        "kwin"."PoloniumInsertBelow" = [];
        "kwin"."PoloniumInsertLeft" = [];
        "kwin"."PoloniumInsertRight" = [];
        "kwin"."PoloniumOpenSettings" = "Meta+\\,none";
        "kwin"."PoloniumResizeAbove" = "Meta+Up";
        "kwin"."PoloniumResizeBelow" = "Meta+Down";
        "kwin"."PoloniumResizeLeft" = "Meta+Left";
        "kwin"."PoloniumResizeRight" = "Meta+Right";
        "kwin"."PoloniumRetileWindow" = "Meta+Shift+Space";
        "kwin"."Setup Window Shortcut" = [];
        "kwin"."Show Desktop" = "Meta+D";
        "kwin"."Switch One Desktop Down" = "Meta+Ctrl+J";
        "kwin"."Switch One Desktop Up" = "Meta+Ctrl+K";
        "kwin"."Switch One Desktop to the Left" = "Meta+Ctrl+H";
        "kwin"."Switch One Desktop to the Right" = "Meta+Ctrl+L";
        "kwin"."Switch Window Down" = "Meta+J";
        "kwin"."Switch Window Left" = "Meta+H";
        "kwin"."Switch Window Right" = "Meta+L";
        "kwin"."Switch Window Up" = "Meta+K";
        "kwin"."Switch to Desktop 1" = "Meta+1";
        "kwin"."Switch to Desktop 2" = "Meta+2";
        "kwin"."Switch to Desktop 3" = "Meta+3";
        "kwin"."Switch to Desktop 4" = "Meta+4";
        "kwin"."Switch to Desktop 5" = "Meta+5";
        "kwin"."Switch to Desktop 6" = "Meta+6";
        "kwin"."Switch to Desktop 7" = "Meta+7";
        "kwin"."Switch to Screen Above" = [];
        "kwin"."Switch to Screen to the Left" = [];
        "kwin"."Switch to Screen to the Right" = [];
        "kwin"."Toggle Night Color" = [];
        "kwin"."Switch to Screen Below" = [];
        "kwin"."Toggle Window Raise/Lower" = [];
        "kwin"."Walk Through Windows (Reverse)" = [];
        "kwin"."Walk Through Windows Alternative (Reverse)" = [];
        "kwin"."Walk Through Windows Alternative" = [];
        "kwin"."Walk Through Windows of Current Application (Reverse)" = [];
        "kwin"."Walk Through Windows of Current Application Alternative (Reverse)" = [];
        "kwin"."Walk Through Windows of Current Application Alternative" = [];
        "kwin"."Walk Through Windows of Current Application" = [];
        "kwin"."Walk Through Windows" = "Meta+Tab";
        "kwin"."Window Above Other Windows" = [];
        "kwin"."Window Below Other Windows" = [];
        "kwin"."Window Close" = "Meta+Q";
        "kwin"."Window Fullscreen" = [];
        "kwin"."Window Grow Horizontal" = [];
        "kwin"."Window Grow Vertical" = [];
        "kwin"."Window Lower" = [];
        "kwin"."Window Maximize Horizontal" = [];
        "kwin"."Window Maximize Vertical" = [];
        "kwin"."Window Maximize" = "Meta+Z";
        "kwin"."Window Minimize" = "Meta+M";
        "kwin"."Window Move Center" = [];
        "kwin"."Window Move" = [];
        "kwin"."Window No Border" = [];
        "kwin"."Window On All Desktops" = [];
        "kwin"."Window One Desktop Down" = "Meta+Ctrl+Shift+J";
        "kwin"."Window One Desktop Up" = "Meta+Ctrl+Shift+K";
        "kwin"."Window One Desktop to the Left" = "Meta+Ctrl+Shift+H";
        "kwin"."Window One Desktop to the Right" = "Meta+Ctrl+Shift+L";
        "kwin"."Window One Screen Down" = "Meta+Alt+J";
        "kwin"."Window One Screen Up" = "Meta+Alt+K";
        "kwin"."Window One Screen to the Left" = "Meta+Alt+H";
        "kwin"."Window One Screen to the Right" = "Meta+Alt+L";
        "kwin"."Window Operations Menu" = [];
        "kwin"."Window Pack Down" = [];
        "kwin"."Window Pack Left" = [];
        "kwin"."Window Pack Right" = [];
        "kwin"."Window Pack Up" = [];
        "kwin"."Window Quick Tile Bottom" = "Meta+Shift+J";
        "kwin"."Window Quick Tile Left" = "Meta+Shift+L";
        "kwin"."Window Quick Tile Right" = "Meta+Shift+H";
        "kwin"."Window Quick Tile Top" = "Meta+Shift+K";
        "kwin"."Window Raise" = [];
        "kwin"."Window Resize" = [];
        "kwin"."Window Shade" = [];
        "kwin"."Window Shrink Horizontal" = [];
        "kwin"."Window Shrink Vertical" = [];
        "kwin"."Window to Desktop 1" = "Meta+!";
        "kwin"."Window to Desktop 2" = "Meta+@";
        "kwin"."Window to Desktop 3" = "Meta+#";
        "kwin"."Window to Desktop 4" = "Meta+$";
        "kwin"."Window to Desktop 5" = "Meta+%";
        "kwin"."Window to Desktop 6" = "Meta+^";
        "kwin"."Window to Desktop 7" = "Meta+&";
        "kwin"."view_actual_size" = [];
        "kwin"."view_zoom_in" = [];
        "kwin"."view_zoom_out" = [];
        "plasmashell"."activate task manager entry 1" = [];
        "plasmashell"."activate task manager entry 10" = [];
        "plasmashell"."activate task manager entry 2" = [];
        "plasmashell"."activate task manager entry 3" = [];
        "plasmashell"."activate task manager entry 4" = [];
        "plasmashell"."activate task manager entry 5" = [];
        "plasmashell"."activate task manager entry 6" = [];
        "plasmashell"."activate task manager entry 7" = [];
        "plasmashell"."activate task manager entry 8" = [];
        "plasmashell"."activate task manager entry 9" = [];
        "plasmashell"."clear-history" = [];
        "plasmashell"."clipboard_action" = [];
        "plasmashell"."cycle-panels" = [];
        "plasmashell"."cycleNextAction" = [];
        "plasmashell"."cyclePrevAction" = [];
        "plasmashell"."manage activities" = [];
        "plasmashell"."next activity" = [];
        "plasmashell"."previous activity" = [];
        "plasmashell"."repeat_action" = [];
        "plasmashell"."show dashboard" = [];
        "plasmashell"."show-barcode" = [];
        "plasmashell"."show-on-mouse-pos" = "Meta+V";
        "plasmashell"."stop current activity" = [];
        "plasmashell"."switch to next activity" = [];
        "plasmashell"."switch to previous activity" = [];
        "plasmashell"."toggle do not disturb" = [];
        "services/org.kde.plasma.emojier.desktop"."_launch" = "Meta+.";
        "services/org.kde.spectacle.desktop"."ActiveWindowScreenShot" = [];
        "services/org.kde.spectacle.desktop"."FullScreenScreenShot" = [];
        "services/org.kde.spectacle.desktop"."RecordRegion" = [];
        "services/org.kde.spectacle.desktop"."RecordScreen" = [];
        "services/org.kde.spectacle.desktop"."RecordWindow" = [];
        "services/org.kde.spectacle.desktop"."RectangularRegionScreenShot" = [];
        "services/org.kde.spectacle.desktop"."WindowUnderCursorScreenShot" = [];
        "services/org.kde.spectacle.desktop"."_launch" = "Print";
      };
      configFile = {
        "kwinrc"."Desktops"."Id_1".value = "9e213faf-b9c2-4750-bc60-2b91a147ab1b";
        "kwinrc"."Desktops"."Id_2".value = "6ffe6fc2-d6c8-4b6a-b7c1-0258f388dba4";
        "kwinrc"."Desktops"."Id_3".value = "411957e3-e338-4cf5-9d4d-b4fbf81d82e7";
        "kwinrc"."Desktops"."Id_4".value = "8cc3b11b-cb5d-42a2-9d7e-71b153c27ca6";
        "kwinrc"."Desktops"."Id_5".value = "b5b7da75-bf4a-49e2-aae8-ccc6c49fb073";
        "kwinrc"."Desktops"."Id_6".value = "eef8b5cc-148f-44bb-810f-ba29ab1851dc";
        "kwinrc"."Desktops"."Id_7".value = "0d207184-6608-4882-8353-d421308ba767";
        "kwinrc"."Desktops"."Name_1".value = 1;
        "kwinrc"."Desktops"."Name_2".value = 2;
        "kwinrc"."Desktops"."Name_3".value = 3;
        "kwinrc"."Desktops"."Name_4".value = 4;
        "kwinrc"."Desktops"."Name_5".value = 5;
        "kwinrc"."Desktops"."Name_6".value = 6;
        "kwinrc"."Desktops"."Name_7".value = 7;
        "kwinrc"."Desktops"."Number".value = 7;
        "kwinrc"."Desktops"."Rows".value = 1;
        "kwinrc"."NightColor"."Active".value = true;
        "kwinrc"."NightColor"."LatitudeAuto".value = "-23.63";
        "kwinrc"."NightColor"."LongitudeAuto".value = "-46.64";
        "kwinrc"."Plugins"."desktopchangeosdEnabled".value = true;
        "kwinrc"."Plugins"."poloniumEnabled".value = true;
        "kwinrc"."Script-desktopchangeosd"."TextOnly".value = true;
        "kwinrc"."Script-polonium"."Borders".value = 3;
        "kwinrc"."Script-polonium"."KeepTiledBelow".value = true;
        "kwinrc"."Script-polonium"."TimerDelay".value = 5;
        "kwinrc"."Tiling"."padding".value = 4;
      };
    };
  };
}
