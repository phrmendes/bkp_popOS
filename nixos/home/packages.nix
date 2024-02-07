{pkgs, ...}: {
  home.packages =
    (with pkgs; [
      ansible
      backblaze-b2
      bashly
      beekeeper-studio
      bitwarden
      bitwarden-cli
      bruno
      chromium
      coursier
      deluge
      droidcam
      firefox
      gcolor3
      gh
      git
      helix
      httpie
      hugo
      jq
      just
      kind
      kubectl
      kubernetes-helm
      lazydocker
      libreoffice
      mc
      ncdu
      neovide
      obsidian
      opentofu
      pandoc
      parallel
      peek
      phockup
      pop-launcher
      qalculate-gtk
      quarto
      qview
      syncthingtray
      tectonic
      terraform
      vagrant
      ventoy
      vlc
      zellij
      zotero
    ])
    ++ (with pkgs.gnome; [
      file-roller
      gnome-disk-utility
      gnome-tweaks
      nautilus
    ])
    ++ (with pkgs.gnomeExtensions; [
      appindicator
      espresso
      pop-shell
      user-themes
    ]);
}
