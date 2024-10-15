{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options.neovim.enable = lib.mkEnableOption "enable neovim";

  config = lib.mkIf config.neovim.enable {
    programs.neovim = let
      fromGitHub = pname: src:
        pkgs.vimUtils.buildVimPlugin {
          inherit src pname;
          version = src.rev;
        };
      cmp-zotcite = fromGitHub "cmp-zotcite" inputs.cmp-zotcite;
      curl-nvim = fromGitHub "curl.nvim" inputs.curl-nvim;
      efmls-configs-nvim = fromGitHub "efmls-configs-nvim" inputs.efmls-configs-nvim;
      luasnip-latex-snippets = fromGitHub "luasnip-latex-snippets" inputs.luasnip-latex-snippets;
      nvim-cmp = fromGitHub "magazine.nvim" inputs.nvim-cmp;
      smart-open-nvim = fromGitHub "smart-open.nvim" inputs.smart-open-nvim;
      tailwindcss-colorizer-cmp-nvim = fromGitHub "tailwindcss-colorizer-cmp.nvim" inputs.tailwindcss-colorizer-cmp-nvim;
      zotcite = fromGitHub "zotcite" inputs.zotcite;
    in {
      enable = true;
      package = pkgs.neovim-unwrapped;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = false;
      plugins = with pkgs.vimPlugins; [
        SchemaStore-nvim
        ansible-vim
        better-escape-nvim
        cmp-buffer
        cmp-cmdline
        cmp-latex-symbols
        cmp-nvim-lsp
        cmp-nvim-lsp-signature-help
        cmp-pandoc-nvim
        cmp-path
        cmp-zotcite
        cmp_luasnip
        copilot-vim
        curl-nvim
        dial-nvim
        dressing-nvim
        efmls-configs-nvim
        friendly-snippets
        fzfWrapper
        image-nvim
        lazydev-nvim
        lazygit-nvim
        lspkind-nvim
        ltex_extra-nvim
        luasnip
        luasnip-latex-snippets
        markdown-nvim
        markdown-preview-nvim
        mini-nvim
        nabla-nvim
        neogen
        neotest
        neotest-elixir
        neotest-golang
        neotest-python
        nvim-bqf
        nvim-cmp
        nvim-colorizer-lua
        nvim-dap
        nvim-dap-go
        nvim-dap-python
        nvim-dap-ui
        nvim-dap-virtual-text
        nvim-lspconfig
        nvim-treesitter-context
        nvim-treesitter-textobjects
        nvim-treesitter.withAllGrammars
        nvim-ts-autotag
        nvim-ts-context-commentstring
        obsidian-nvim
        refactoring-nvim
        smart-open-nvim
        smart-splits-nvim
        tailwindcss-colorizer-cmp-nvim
        telescope-fzf-native-nvim
        telescope-nvim
        undotree
        vim-abolish
        vim-dadbod
        vim-dadbod-completion
        vim-dadbod-ui
        vim-eunuch
        vim-helm
        vim-jinja
        vim-rsi
        vim-sleuth
        vim-slime
        zotcite
      ];
      extraLuaPackages = luaPkgs:
        with luaPkgs; [
          jsregexp
          magick
          nui-nvim
          nvim-nio
          plenary-nvim
          sqlite
        ];
      extraPython3Packages = pythonPkgs:
        with pythonPkgs; [
          debugpy
          poppler-qt5
          pynvim
          pyqt5
          pyyaml
        ];
      extraPackages = with pkgs;
        [
          alejandra
          ansible-language-server
          ansible-lint
          basedpyright
          bash-language-server
          delve
          djlint
          dockerfile-language-server-nodejs
          dot-language-server
          efm-langserver
          elixir-ls
          emmet-language-server
          gofumpt
          golangci-lint
          golines
          gopls
          hadolint
          helm-ls
          ltex-ls
          lua-language-server
          neovim-remote
          nixd
          ruff
          shellcheck
          shellharden
          sqls
          stylua
          tailwindcss-language-server
          taplo
          terraform-ls
          texlab
          vscode-js-debug
          vscode-langservers-extracted
          yaml-language-server
        ]
        ++ (with nodePackages_latest; [
          prettier
          sql-formatter
          vscode-json-languageserver
        ]);
    };

    xdg.configFile = {
      "nvim" = {
        source = ../dotfiles/nvim;
        recursive = true;
      };
      "nvim/lua/luvit-meta.lua".text = ''
        return {
            path = "${pkgs.vimPlugins.luvit-meta}/library",
        }
      '';
      "nvim/lua/base16.lua".text = with config.lib.stylix.colors.withHashtag; ''
        return {
            palette = {
                base00 = "${base00}",
                base01 = "${base01}",
                base02 = "${base02}",
                base03 = "${base03}",
                base04 = "${base04}",
                base05 = "${base05}",
                base06 = "${base06}",
                base07 = "${base07}",
                base08 = "${base08}",
                base09 = "${base09}",
                base0A = "${base0A}",
                base0B = "${base0B}",
                base0C = "${base0C}",
                base0D = "${base0D}",
                base0E = "${base0E}",
                base0F = "${base0F}",
            },
        }
      '';
    };
  };
}
