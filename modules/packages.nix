{
  config,
  lib,
  pkgs,
  ...
}: {
  options.packages.enable = lib.mkEnableOption "enable packages";

  config = lib.mkIf config.packages.enable {
    home.packages = with pkgs; let
      gcloud = google-cloud-sdk.withExtraComponents (with google-cloud-sdk.components; [
        gke-gcloud-auth-plugin
      ]);
    in
      [
        age
        android-tools
        ansible
        bitwarden
        bitwarden-cli
        brightnessctl
        bws
        chromium
        deluge
        discord
        droidcam
        elixir
        exiftool
        fd
        ffmpegthumbnailer
        firefox
        gcloud
        gdu
        gnumake
        gnused
        go
        gotools
        gparted
        graphviz
        grim
        hugo
        imagemagick
        infisical
        inkscape
        jdk
        jq
        kooha
        kubectl
        kubernetes-helm
        lazydocker
        libreoffice
        livebook
        minikube
        mongosh
        nemo
        networkmanagerapplet
        ngrok
        obsidian
        parallel
        pavucontrol
        phockup
        playerctl
        plex
        poppler
        postgresql
        protonvpn-gui
        python312
        qalculate-gtk
        quarto
        qview
        satty
        scrcpy
        slurp
        stremio
        syncthingtray
        tectonic
        terraform
        typescript
        uv
        vagrant
        ventoy
        vlc
        wofi-emoji
        xarchiver
        zotero
      ]
      ++ (with nodePackages_latest; [
        nodejs
        typescript-language-server
      ]);
  };
}
