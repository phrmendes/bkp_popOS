{
  config,
  lib,
  pkgs,
  ...
}: {
  options.packages.enable = lib.mkEnableOption "enable packages";

  config = lib.mkIf config.packages.enable {
    home.packages = with pkgs;
      [
        age
        ansible
        atac
        bitwarden
        cachix
        chromium
        coreutils-full
        coursier
        csvlens
        curtail
        deluge
        droidcam
        fd
        ffmpegthumbnailer
        file
        findutils
        firefox
        gcc
        gcolor3
        gdu
        gnumake
        gnused
        graphviz
        grex
        gzip
        hugo
        imagemagick
        inkscape
        jdk
        jq
        libqalculate
        libreoffice
        mongosh
        nemo-with-extensions
        networkmanagerapplet
        obsidian
        pandoc
        parallel
        pavucontrol
        phockup
        plex
        podman-tui
        poppler
        portal
        postgresql
        python312
        qalculate-gtk
        quarto
        qview
        rar
        sshs
        syncthingtray
        tectonic
        terraform
        unar
        vagrant
        ventoy
        vlc
        wget
        xarchiver
        zip
        zotero
      ]
      ++ (with nodePackages_latest; [
        nodejs
      ]);
  };
}
