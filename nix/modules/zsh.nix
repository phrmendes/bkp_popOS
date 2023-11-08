{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableVteIntegration = true;
    syntaxHighlighting.enable = true;
    initExtra = builtins.readFile ../cfg/init.sh;
    shellAliases = {
      cat = "bat --theme=catppuccin";
      docker = "podman";
      la = "eza --icons -a";
      lg = "lazygit";
      ll = "eza --icons -l";
      lla = "eza --icons -la";
      ls = "eza --icons";
      lt = "eza --icons --tree";
      mb = "micromamba";
      mba = "micromamba activate";
      mbc = "micromamba create";
      mbd = "micromamba deactivate";
      mbi = "micromamba install";
      mkdir = "mkdir -p";
      ncdu = "ncdu --color dark";
      sys_cat = "/usr/bin/cat";
      sys_ls = "/usr/bin/ls";
      sys_pip = "/usr/bin/pip";
      sys_python = "/usr/bin/python3";
    };
  };
}
