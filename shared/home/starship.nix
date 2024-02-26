{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      command_timeout = 1000;
      docker_context.disabled = true;
      conda.symbol = "🐍 ";
      nix_shell.symbol = " ";
      scala.symbol = " ";
    };
  };
}
