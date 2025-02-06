{ config, pkgs, ... }:

{
  # USER CONFIGURATION
  home.username = "exiquio";
  home.homeDirectory = "/home/exiquio";

  # PACKAGE CONFIGURATION
  home.packages = with pkgs; [
    # SOTWARE PACKAGES

    # Terminal
    alacritty
    tmux

    # CLI Tools
    jq
    feh
    glow
    xclip
    bat
    lsd
    ripgrep
    fd
    glances
    openvpn
    gh
    
    # Programming
    python39
    ruby_3_4

    # Web Browsers
    librewolf
    ungoogled-chromium

    # Proton
    protonmail-desktop
    proton-pass
    protonvpn-gui

    # Productivity 
    obsidian
    libreoffice-qt6-fresh
    flameshot
    todoist-electron

    # Communication tools
    slack
    discord

    # Quality of Life
    variety

    # Others
    virt-manager
  ];

  # Terminal
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = ["/home/exiquio/.themes/alacritty/dracula/dracula.toml"];
    }; 
  };

  # Shell
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting;

      fish_vi_key_bindings

      alias vim='nvim'
      alias vi='nvim'
      alias vimdiff='nvim -d'
      alias ls='lsd'
      alias cat='bat'
      alias grep='rg'
      alias find='echo "Use fd"'
      alias clip='xclip -sel clipboard'
      alias top='echo "Use glances"'
      alias htop='echo "Use glances"'
      alias update='sudo nixos-rebuild switch'
      alias clean='sudo nix-collect-garbage -d'

      export PATH="$PATH"
    '';

    plugins = [
      {
        name = "dracula-theme";
        src = pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "fish";
          rev = "269cd7d76d5104fdc2721db7b8848f6224bdf554";
          sha256 = "sha256-Hyq4EfSmWmxwCYhp3O8agr7VWFAflcUe8BUKh50fNfY=";
        };
      }
    ];
  };

  # Source control
  programs.git = {
    enable = true;
    userName = "Exiquio Cooper-Anderson";
    userEmail = "exiquio@gmail.com";
    extraConfig = {
      init.defaultBranch = "master";
    };
  };

  # Home Manager
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
