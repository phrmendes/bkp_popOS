{
  inputs,
  parameters,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ../../shared/home
    ./btop.nix
    ./copyq.nix
    ./dconf.nix
    ./flameshot.nix
    ./gtk.nix
    ./home-manager.nix
    ./packages.nix
    ./symlinks.nix
  ];

  targets.genericLinux.enable = true;

  home = {
    username = parameters.user;
    homeDirectory = parameters.home;
  };
}
