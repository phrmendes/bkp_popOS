{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      psmisc
      wl-clipboard
      xclip
      xdg-utils
      kdePackages.polkit-kde-agent-1
    ];
  };
}
