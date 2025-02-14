{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options.neovim.enable = lib.mkEnableOption "enable neovim";

  config = lib.mkIf config.neovim.enable {
    programs.neovim =
      let
        bibli-ls = inputs.bibli-ls.packages.${pkgs.system}.default;
      in
      {
        enable = true;
        vimAlias = true;
        vimdiffAlias = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = false;
        extraPython3Packages = p: with p; [ debugpy ];
        extraLuaPackages =
          p: with p; [
            luarocks
            mimetypes
            tiktoken_core
            xml2lua
          ];
        extraPackages =
          with pkgs;
          [
            ansible-language-server
            ansible-lint
            basedpyright
            bash-language-server
            bibli-ls
            djlint
            dockerfile-language-server-nodejs
            dot-language-server
            efm-langserver
            emmet-language-server
            hadolint
            helm-ls
            ltex-ls-plus
            lua-language-server
            lynx
            marksman
            neovim-remote
            nixd
            nixfmt-rfc-style
            ruff
            shellcheck
            shellharden
            sqruff
            stylua
            taplo
            terraform-ls
            tree-sitter
            tree-sitter
            vscode-langservers-extracted
            vtsls
            yaml-language-server
          ]
          ++ (with beam27Packages; [
            elixir-ls
          ])
          ++ (with nodePackages_latest; [
            prettier
            vscode-json-languageserver
          ]);
      };

    xdg.configFile."nvim/init.lua".enable = false;

    home.file = {
      ".config/nvim".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Projects/dotfiles/dotfiles/nvim";
      ".local/share/nvim/nix/lua/nix/luvit-meta.lua".text = ''
        return "${pkgs.vimPlugins.luvit-meta}/library"
      '';
      ".local/share/nvim/nix/lua/nix/base16.lua".text = with config.lib.stylix.colors.withHashtag; ''
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
