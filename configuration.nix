{ config, pkgs, ... }:

let
  user = "phrmendes";
  unstable = builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/master.tar.gz;
in {
  imports =
    [
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
      ./home.nix
    ];
  boot = {
    loader = {
      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        devices = [ "nodev" ];
        gfxmodeEfi = "1024x768";
        configurationLimit = 5;
      };
      efi = {
        efiSysMountPoint = "/boot/efi";
        canTouchEfiVariables = true;
      };
      timeout = 5;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    wireless.enable = true;
  };
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
        (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        noto-fonts-extra
    ];
    fontconfig = {
        defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "SourceCodePro" ];
        };
    };
  };
  services = {
    clipmenu.enable = true
    autorandr.enable = true;
    openssh.enable = true;
    flatpak.enable = true;
    xserver = {
      enable = true;
      autorun = true;
      layout = "us,br";
      videoDrivers = [ "nvidia" ];
      xrandrHeads = [
        {
          output = "HDMI-0";
          primary = true;
        }
      ];
      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
          extraPackages = haskellPackages: with haskellPackages; [
            xmonad
            xmonad-contrib
            xmonad-extras
            xmobar
          ];
        };
        config = builtins.readFile $HOME/.config/xmonad/xmonad.hs;
      };
      displayManager = {
        defaultSession = "none+xmonad";
        lightdm = {
          greeters.enso = {
            enable = true;
            blur = true;
          };
          extraConfig = "default-wallpaper=/usr/share/streets_of_gruvbox.png";
        };
        sessionCommands = ''
          xrandr --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal
        '';
      };
      libinput = {
        enable = true;
        tapping = true;
        naturalScrolling = true;
      };
    };
  };
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraConfig = ''
        load-module module-switch-on-connect
      '';
    };
    bluetooth = {
      enable = true;
      hsphfpd.enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
  users.users.${user} = {
    isNormalUser = true;
    home = "/home/${user}"
    uid = 1000;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    initialPassword = "password";
    shell = pkgs.bash;
  };
  nixpkgs.config.allowUnfree = true;
  environment = {
    systemPackages = with pkgs; [
      xclip
      dmenu
      blueman
      bluez
      pavucontrol
      zip
      curl
      unzip
      unrar
      tree
      git
      gzip
      vim
      arand
      feh
      appimage-run
      home-manager
    ];
  };
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      "volman"
      "archive-plugin"
      "media-tags-plugin"
    ];
  };
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    trustedUsers = ["root" "@wheel"];
    package = pkgs.nixFlakes;
    experimental-features = [ "nix-command" "flakes" ];
  };
  system = {
    stateVersion = "unstable";
    system.autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";
    autoUpgrade.enable = true;
    journald.extraConfig = "SystemMaxUse=1G";
  }
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
