{
  lib,
  parameters,
  ...
}: {
  imports = [
    ./bat.nix
    ./blueman.nix
    ./btop.nix
    ./direnv.nix
    ./dunst.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./gnome-keyring.nix
    ./gtk.nix
    ./hyprland.nix
    ./kitty.nix
    ./lazygit.nix
    ./neovim.nix
    ./network-manager.nix
    ./packages.nix
    ./pasystray.nix
    ./pyenv.nix
    ./rofi.nix
    ./starship.nix
    ./swayidle.nix
    ./swaylock.nix
    ./swayosd.nix
    ./symlinks.nix
    ./targets.nix
    ./tealdeer.nix
    ./tmux.nix
    ./udiskie.nix
    ./waybar.nix
    ./yazi.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  bat.enable = lib.mkDefault true;
  direnv.enable = lib.mkDefault true;
  eza.enable = lib.mkDefault true;
  fzf.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  kitty.enable = lib.mkDefault true;
  lazygit.enable = lib.mkDefault true;
  neovim.enable = lib.mkDefault true;
  packages.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;
  symlinks.enable = lib.mkDefault true;
  tealdeer.enable = lib.mkDefault true;
  tmux.enable = lib.mkDefault true;
  yazi.enable = lib.mkDefault true;
  zoxide.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;

  home = {
    stateVersion = "23.11";
    username = parameters.user;
    homeDirectory = parameters.home;
  };

  programs.home-manager.enable = true;
}
