{
  pkgs,
  lib,
  ...
}: let
  fromGitHub = rev: ref: repo:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        inherit ref rev;
        url = "https://github.com/${repo}.git";
      };
    };
  conform-nvim = fromGitHub "43d2b5c6a254f60cbd2142345d2f903e04f9db07" "HEAD" "stevearc/conform.nvim";
  telescope-bibtex = fromGitHub "e4dcf64d351db23b14be3563190cf68d5cd49e90" "HEAD" "nvim-telescope/telescope-bibtex.nvim";
  zotcite = fromGitHub "442519a20a80b9ccc8a2baa0607080a21c4ecee0" "HEAD" "jalvesaq/zotcite";
  cmp-zotcite = fromGitHub "431c720a73fb84c8b1a51b4f123e2a7cc8a58bfd" "HEAD" "jalvesaq/cmp-zotcite";
in {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      zotcite # zotero integration
      cmp-zotcite # zotero completion
      catppuccin-nvim # colorscheme
      cmp-nvim-lsp # lsp completion
      cmp-path # path completion
      cmp_luasnip # snippets completion
      comment-nvim # comments
      conform-nvim # formatting
      copilot-vim # github copilot
      dial-nvim # increment/decrement
      executor-nvim # async jobs
      friendly-snippets # snippets
      gitsigns-nvim # git indicators
      iron-nvim # REPLs
      lazygit-nvim # git ui
      lsp_signature-nvim # lsp signature
      lspkind-nvim # vscode-like pictograms
      ltex_extra-nvim # ltex-ls utils
      luasnip # snippets
      markdown-preview-nvim # markdown preview
      mini-nvim # set of small plugins
      nabla-nvim # colorscheme
      nui-nvim # neovim ui component lib
      nvim-bqf # quickfix
      nvim-cmp # completion
      nvim-dap # debug adapter protocol
      nvim-dap-go # go dap support
      nvim-dap-python # python dap support
      nvim-dap-ui # ui for dap
      nvim-dap-virtual-text # virtual text for dap
      nvim-lint # linting
      nvim-lspconfig # lsp
      nvim-tree-lua # file explorer
      nvim-treesitter-context # treesitter context
      nvim-treesitter-textobjects # treesitter textobjects
      nvim-treesitter.withAllGrammars # treesitter
      nvim-web-devicons # icons
      otter-nvim # quarto dependency
      plenary-nvim # lua utils
      popup-nvim # zoxide dependency
      quarto-nvim # quarto integration
      telescope-bibtex # bibtex integration
      telescope-dap-nvim # dap integration
      telescope-fzy-native-nvim # telescope fzy integration
      telescope-nvim # fuzzy finder
      telescope-symbols-nvim # undo integration
      telescope-ui-select-nvim # telescope ui
      telescope-zoxide # zoxide integration
      todo-comments-nvim # todo comments
      undotree # undo tree
      vim-fugitive # git integration
      vim-helm # helm syntax
      vim-jinja # jinja syntax
      vim-nix # nix syntax
      vim-tmux-navigator # tmux keybindings
      vim-visual-multi # multiple cursors
      which-key-nvim # keybindings
      zen-mode-nvim # zen mode
    ];
    extraPackages =
      (with pkgs; [
        alejandra
        ansible-language-server
        ansible-lint
        delve
        gofumpt
        golangci-lint
        golines
        gopls
        gotools
        ltex-ls
        lua-language-server
        metals
        nil
        ruff
        ruff-lsp
        shellcheck
        shellharden
        statix
        stylua
        taplo
        terraform-ls
        texlab
      ])
      ++ (with pkgs.nodePackages; [
        bash-language-server
        prettier
        pyright
        vscode-json-languageserver
        yaml-language-server
      ])
      ++ (with pkgs.perl538Packages; [
        LatexIndent
      ]);
  };
}
