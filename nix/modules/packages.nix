{ pkgs, ... }: {
  home.packages = with pkgs; [
    # CLI 
    ansible
    asdf-vm
    coursier
    exa
    fd
    gh
    gnome-extensions-cli
    helix
    hugo
    jdk20
    lazydocker
    lf
    mlocate
    ncdu
    pandoc
    pipr
    quarto
    rename
    ripgrep
    slides
    sqlite
    tealdeer
    tectonic
    tesseract4
    xclip
    zellij
    # GUI
    bitwarden
    copyq
    caffeine-ng
    deluge
    obsidian
    onlyoffice-bin
    thunderbird
    vlc
    vscode
    zotero
    # language servers/formatters
    marksman
    nil
    nixpkgs-fmt
    shfmt
    taplo
    terraform-ls
    yamlfmt
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.prettier
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
  ];
}
