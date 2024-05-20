{
  lib,
  config,
  pkgs,
  ...
}: {
  options.nwg.enable = lib.mkEnableOption "enable nwg";

  config = lib.mkIf config.nwg.enable {
    home.file = let
      swaylock = lib.getExe pkgs.swaylock;
      systemctl = "${pkgs.systemd}/bin/systemctl";
    in {
      ".config/nwg-bar/style.css".text = ''
        @define-color background #2a2827;
        @define-color foreground #fbf1c7;

        window {
          background-color: @background;
          border-radius: 10px;
        }

        #outer-box {
          margin: 5px;
          border-radius: 10px;
        }

        #inner-box {
          background-color: @background;
          border-color: @background;
          border-radius: 10px;
          border-style: none;
          border-width: 1px;
          margin: 5px;
          padding: 5px;
        }

        button, image {
          background: none;
          border: none;
          box-shadow: none;
        }

        button {
          padding-left: 10px;
          padding-right: 10px;
          margin: 5px;
        }

        button:hover {
          background-color: @foreground;
        }
      '';
      ".config/nwg-bar/bar.json".text = builtins.toJSON [
        {
          "label" = "Lock";
          "exec" = "${swaylock}";
          "icon" = "${pkgs.nwg-bar}/share/nwg-bar/images/system-lock-screen.svg";
        }
        {
          "label" = "Suspend";
          "exec" = "${systemctl} -i suspend";
          "icon" = "${pkgs.nwg-bar}/share/nwg-bar/images/system-suspend.svg";
        }
        {
          "label" = "Reboot";
          "exec" = "${systemctl} -i reboot";
          "icon" = "${pkgs.nwg-bar}/share/nwg-bar/images/system-reboot.svg";
        }
        {
          "label" = "Shutdown";
          "exec" = "${systemctl} -i poweroff";
          "icon" = "${pkgs.nwg-bar}/share/nwg-bar/images/system-shutdown.svg";
        }
      ];
    };
  };
}
