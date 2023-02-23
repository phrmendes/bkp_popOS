{ config, pkgs, ... }:

let
  user = "phrmendes";
in {
  home-manager.users.${user} = {
    home = {
      username = "${user}";
      homeDirectory = "/home/${user}";
      packages = with pkgs; [
        btop
        pandoc
        lazygit
        ripgrep
        fd
        sd
        gnupg
        stow
        exa
        sqlite
        jq
        hugo
        biber
        tectonic
        ditaa
        tere
        imagemagick
        bitwarden
        spotify
        ventoy-bin-full
        haruna
        peek
        droidcam
        mu
        isync
        ispell
        aspell
        aspellDicts.pt_BR
        aspellDicts.en
        unstable.cmdstan
        unstable.terraform
        unstable.ansible
        unstable.gh
        unstable.quarto
        unstable.python311
        unstable.python311Packages.ipython
        unstable.pipenv
        unstable.cargo
        unstable.go
        unstable.nodejs
        unstable.gopls
        unstable.rnix-lsp
        unstable.tflint
        unstable.lua53Packages.digestif
        unstable.podman
        unstable.emacs
        unstable.pcloud
        unstable.zotero
        unstable.firefox
        unstable.chromium
        unstable.protonvpn-gui
        unstable.thunderbird
        libsForQt5.bismuth
        libsForQt5.ktorrent
        libsForQt5.filelight
        libsForQt5.kpmcore
        libsForQt5.kate
        libsForQt5.syntax-highlighting
        libsForQt5.ark
      ];
      stateVersion = "22.11";
      sessionVariables = {
        VISUAL = "nvim";
        TERMINAL = "alacritty";
        SUDO_EDITOR = "nvim";
      };
    };
    programs = {
      home-manager.enable = true;
      bat = {
        enable = true;
        config.theme = "Nord";
      };
      fzf = {
        enable = true;
        enableFishIntegration = true;
      };
      direnv = {
        enable = true;
        enableBashIntegration = true;
      };
      fish = {
        enable = true;
        shellAliases = {
          mkdir = "mkdir -p";
          cat = "${pkgs.bat}/bin/bat";
          nv = "${pkgs.neovim}/bin/nvim";
          lg = "${pkgs.lazygit}/bin/lazygit";
          ls = "${pkgs.exa}/bin/exa --icons";
          ll = "${pkgs.exa}/bin/exa --icons -l";
          la = "${pkgs.exa}/bin/exa --icons -a";
          lt = "${pkgs.exa}/bin/exa --icons --tree";
          lla = "${pkgs.exa}/bin/exa --icons -la";
        };
        shellAbbrs = {
          stow_dotfiles = "stow --target=$HOME --dir=$HOME/Projects/bkps/ --stow .dotfiles";
          nix_update = "sudo nixos-rebuild switch";
          nix_clean = "nix-collect-garbage";
        };
        shellInit = ''
          fish_add_path "$HOME/.emacs.d/bin"
          fish_add_path "$HOME/.npm-global/bin"
      
          function tere
              set --local result (command tere $argv)
              [ -n "$result" ] && cd -- "$result"
          end
        '';
      };
      neovim = {
        enable = true;
        defaultEditor = true;
        plugins = with pkgs.vimPlugins; [
          nvim-web-devicons
          nvim-tree-lua
          plenary-nvim
          vim-nix
          vim-easymotion
          vim-commentary
          vim-gitgutter
          auto-pairs
          {
            plugin = nord-nvim;
            config = "lua vim.cmd('colorscheme nord')";
          }
          {
            plugin = indent-blankline-nvim;
            config = "lua require('indent_blankline').setup()";
          }
          {
            plugin = nvim-treesitter;
            config = ''
              lua << EOF
              require('nvim-treesitter.configs').setup {
                  highlight = {
                      enable = true,
                      additional_vim_regex_highlighting = false
                  }
              }
              EOF
            '';
          }
          {
            plugin = lualine-nvim;
            config = ''
              lua << EOF
              require('lualine').setup {
                  options = {
                      icons_enabled = true,
                      theme = 'nord'
                  }
              }
              EOF
            '';
          }
        ];
        extraLuaConfig = ''
          vim.o.background = 'dark'
          vim.o.clipboard = 'unnamedplus'
          vim.o.completeopt = 'noinsert,menuone,noselect'
          vim.o.cursorline = true
          vim.o.hidden = true
          vim.o.inccommand = 'split'
          vim.o.number = true
          vim.o.relativenumber = true
          vim.o.splitbelow = true
          vim.o.splitright = true
          vim.o.title = true
          vim.o.wildmenu = true
          vim.o.expandtab = true
          vim.o.ttimeoutlen = 0
          vim.o.shiftwidth = 2
          vim.o.tabstop = 2
          vim.o.undofile = true
          vim.o.smartindent = true
          vim.o.tabstop = 4
          vim.o.shiftwidth = 4
          vim.o.shiftround = true
          vim.o.expandtab = true
          vim.o.scrolloff = 3
        '';
        vimAlias = true;
        vimdiffAlias = true;
      };
      alacritty = {
        enable = true;
        settings = {
          window = {
            padding = {
              x = 15;
              y = 15;
            };
            class = {
              instance = "Alacritty";
              general = "Alacritty";
            };
            opacity = 1;
          };
          scrolling = {
            history = 10000;
            multiplier = 3;
          };
          font = {
            normal = {
              family = "SauceCodePro Nerd Font";
              style = "Medium";
            };
            bold = {
              family = "SauceCodePro Nerd Font";
              style = "Bold";
            };
            italic = {
              family = "SauceCodePro Nerd Font";
              style = "MediumItalic";
            };
            bold_italic = {
              family = "SauceCodePro Nerd Font";
              style = "BoldItalic";
            };
            size = 11;
          };
          draw_bold_text_with_bright_colors = true;
          selection.save_to_clipboard = true;
          shell.program = "${pkgs.fish}/bin/fish";
          colors = {
            primary = {
              background = "#2e3440";
              foreground = "#d8dee9";
              dim_foreground = "#a5abb6";
              footer_bar = {
                background = "#434c5e";
                foreground = "#d8dee9";
              };
            };
            cursor = {
              text = "#2e3440";
              cursor = "#d8dee9";
            };
            vi_mode_cursor = {
              text = "#2e3440";
              cursor = "#d8dee9";
            };
            selection = {
              text = "CellForeground";
              background = "#4c566a";
            };
            search = {
              matches = {
                foreground = "CellBackground";
                background = "#88c0d0";
              };
            };
            normal = {
              black = "#3b4252";
              red = "#bf616a";
              green = "#a3be8c";
              yellow = "#ebcb8b";
              blue = "#81a1c1";
              magenta = "#b48ead";
              cyan = "#88c0d0";
              white = "#e5e9f0";
            };
            bright = {
              black = "#4c566a";
              red = "#bf616a";
              green = "#a3be8c";
              yellow = "#ebcb8b";
              blue = "#81a1c1";
              magenta = "#b48ead";
              cyan = "#8fbcbb";
              white = "#eceff4";
            };
            dim = {
              black = "#373e4d";
              red = "#94545d";
              green = "#809575";
              yellow = "#b29e75";
              blue = "#68809a";
              magenta = "#8c738c";
              cyan = "#6d96a5";
              white = "#aeb3bb";
            };
          };
        };
      };
      starship = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
      };
    };
    xdg.enable = true;
    xdg.mime.enable = true;
    targets.genericLinux.enable = true;
  };
}
