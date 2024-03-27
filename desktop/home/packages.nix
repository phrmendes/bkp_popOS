{pkgs, ...}: {
  home.packages = with pkgs;
    [
      ansible
      bashly
      bitwarden
      bruno
      cachix
      chromium
      curtail
      dbeaver
      deluge
      droidcam
      evince
      firefox
      gcolor3
      gh
      git
      gnuplot
      gparted
      graphviz
      grex
      grim
      httpie
      hugo
      jq
      just
      kubectl
      kubernetes-helm
      libqalculate
      libreoffice
      mc
      minikube
      nwg-displays
      nwg-look
      obsidian
      opentofu
      pandoc
      parallel
      pavucontrol
      phockup
      qemu
      quarto
      quickemu
      qview
      satty
      slurp
      swaybg
      tectonic
      terraform
      tokei
      ventoy
      vlc
      xdotool
      zotero
    ]
    ++ (with pkgs.xfce; [
      thunar
      thunar-volman
      thunar-archive-plugin
    ]);
}
