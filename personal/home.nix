{ config, pkgs, ... }:

{
  home.username = "exiquio";
  home.homeDirectory = "/home/exiquio";
  home.packages = with pkgs; [
    # Dependancies
    nodejs
    openjdk

    # CLI Tools
    tmux
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
    ruby
    python3
    
    # Programming
    zig

    # Web Browsers
    librewolf
    chromium

    # Productivity 
    obsidian
    libreoffice-qt6-fresh
    flameshot
    todoist-electron

    # Communitcation 
    slack
    discord

    # Mulitmedia
    celluloid

    # Virtualization
    virt-manager

    # Quality of Life
    variety

    # Proton
    protonmail-desktop
    proton-pass
    protonvpn-gui

    # Cracking
    hashcat
    john

    # Synack
    #vmware-horizon-client 
  ];

  # Shell
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting;

      fish_vi_key_bindings

      alias vim='echo "Use nvim"'
      alias vi='echo "Use nvim"'
      alias vimdiff='echo "Use nvim -d"'
      alias ls='lsd'
      alias cat='bat'
      alias grep='rg'
      alias find='echo "Use fd"'
      alias clip='xclip -sel clipboard'
      alias top='echo "Use glances"'
      alias htop='echo "Use glances"'
      alias update='sudo nix flake update --flake /etc/nixos/'
      alias upgrade='sudo nixos-rebuild switch --flake /etc/nixos/'
      alias clean='sudo nix-collect-garbage -d'
      alias ng='~/Tools/node/node_modules/@angular/cli/bin/ng.js' 

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

  # Terminal
  programs.ghostty = {
    enable = true;

    settings = {
      shell-integration = "detect";
      theme = "Dracula";
      window-decoration = "auto";
      fullscreen = "true";
    };
  };

  # Source control
  programs.git = {
    enable = true;
    userName = "Exiquio Cooper-Anderson";
    userEmail = "exiquio@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };


  # Home Manager
  home.stateVersion = "24.11";
}
