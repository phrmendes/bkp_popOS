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
      vimPlugin = pname: src:
        pkgs.vimUtils.buildVimPlugin {
          inherit src pname;
          version = src.rev;
        };
      notes-nvim = vimPlugin "notes.nvim" inputs.notes-nvim;
      todotxt-nvim = vimPlugin "todotxt.nvim" inputs.todotxt-nvim;
      treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (parsers:
        with parsers; [
          bash
          bibtex
          css
          csv
          cuda
          diff
          dockerfile
          dot
          elixir
          erlang
          git_config
          git_rebase
          gitattributes
          gitcommit
          gitignore
          hcl
          helm
          html
          htmldjango
          hyprlang
          javascript
          json
          jsonc
          just
          latex
          lua
          luadoc
          luap
          make
          markdown
          markdown_inline
          mermaid
          nginx
          nix
          python
          requirements
          sql
          ssh_config
          terraform
          todotxt
          toml
          typescript
          vim
          vimdoc
          yaml
        ]);
    in {
      enable = true;
      package = pkgs.neovim-unwrapped;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = false;
      plugins = with pkgs.vimPlugins; [
        CopilotChat-nvim
        SchemaStore-nvim
        ansible-vim
        blink-cmp
        blink-compat
        cmp-pandoc-nvim
        copilot-vim
        efmls-configs-nvim
        friendly-snippets
        fzfWrapper
        lazydev-nvim
        markdown-nvim
        markdown-preview-nvim
        mini-nvim
        notes-nvim
        nvim-bqf
        nvim-dap
        nvim-dap-python
        nvim-dap-ui
        nvim-dap-virtual-text
        nvim-lspconfig
        nvim-treesitter-context
        nvim-treesitter-textobjects
        one-small-step-for-vimkind
        refactoring-nvim
        rest-nvim
        smart-splits-nvim
        snacks-nvim
        todotxt-nvim
        treesitter
        undotree
        vim-abolish
        vim-dadbod
        vim-dadbod-completion
        vim-dadbod-ui
        vim-eunuch
        vim-helm
        vim-sleuth
        vim-slime
      ];
      extraPython3Packages = pythonPkgs: with pythonPkgs; [debugpy];
      extraLuaPackages = luaPkgs: with luaPkgs; [tiktoken_core];
      extraPackages = with pkgs;
        [
          alejandra
          ansible-language-server
          ansible-lint
          basedpyright
          bash-language-server
          djlint
          dockerfile-language-server-nodejs
          dot-language-server
          efm-langserver
          elixir-ls
          emmet-language-server
          hadolint
          helm-ls
          ltex-ls-plus
          lua-language-server
          marksman
          neovim-remote
          nil
          ruff
          shellcheck
          shellharden
          stylua
          taplo
          terraform-ls
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
      "nvim/lua/paths/luvit-meta.lua".text = ''
        return "${pkgs.vimPlugins.luvit-meta}/library"
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
