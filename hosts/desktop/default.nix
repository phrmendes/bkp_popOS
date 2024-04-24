{
  inputs,
  parameters,
  pkgs,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
    inputs.impermanence.nixosModules.impermanence
    inputs.sops-nix.nixosModules.sops
    (import ./disko.nix {inherit (parameters) device;})
    ./boot.nix
    ./file-systems.nix
    ./fonts.nix
    ./hardware.nix
    ./home-manager.nix
    ./i18n.nix
    ./impermanence.nix
    ./networking.nix
    ./nix-settings.nix
    ./packages.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./sops.nix
    ./syncthing.nix
    ./time.nix
    ./users.nix
    ./virtualisation.nix
  ];

  console.keyMap = "us";
  sound.enable = true;
  system.stateVersion = "23.11";
  xdg.portal.enable = true;
}
