{ config, pkgs, ... }:

{
  home.username = "exiquio";
  home.homeDirectory = "/home/exiquio";
  home.packages = with pkgs; [
    # Dependancies
    nodejs
    openjdk

    # CLI Tools
    jq
    feh
    glow
    xclip
    bat
    ripgrep
    fd
    glances
    openvpn
    gh
    ruby

    # Programming
    (pkgs.python3.withPackages (python_packages: [
      # E.g., python_packages.requests
 
      # GOAD Requirements
      python_packages.pip
      python_packages.rich
      python_packages.jinja2
      python_packages.psutil
      python_packages.pyyaml
      python_packages.azure-core
      python_packages.azure-mgmt-compute
      python_packages.azure-mgmt-network
      python_packages.azure-identity
      python_packages.boto3
      python_packages.proxmoxer
      python_packages.ansible
      python_packages.ansible-core
      python_packages.ansible-runner
      python_packages.pywinrm
    ]))
    zig

    # Web Browsers
    librewolf
    chromium

    # Productivity 
    obsidian
    libreoffice-qt6-fresh
    flameshot
    todoist-electron
    freeplane

    # Communitcation 
    slack
    discord

    # Mulitmedia
    celluloid

    # Quality of Life
    variety

    # Cracking
    hashcat
    john

    # Virtualization
    vagrant

    # Remote Access
    freerdp3

    # Cloud
    #azure-cli
    #terraform
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
      theme = "/home/exiquio/Tools/dracula-pro/themes/ghostty/pro";
      window-decoration = "none";
      fullscreen = "true";
    };
  };
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-battery false
          set -g @dracula-show-powerline true
          set -g @dracula-refresh-rate 10
        '';
      }
    ];

    extraConfig = ''
      set -g mouse on
    '';
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

  # CLI Tools
  programs.lsd = {
    enable = true;

    settings = {
      layout = "oneline";
      size = "short";
      permission = "rwx";
      hyperlink = "never";
      no-symlink = false;
      symlink-arrow = "⇒";
    };

    colors = {
      userColor = "#00b3b3";
      groupColor = "#e7e7e7";

      permissions = {
        read = "#b3b3ff";
        write = "#d66bb3";
        exec = "#00b3b3";
        execSticky = "#00b3b3";
        noAccess = "#d66b66";
      };

      date = {
        hourOld = "#9292b3";
        dayOld = "#6666b3";
        older = "#9999b3";
      };

      size = {
        none = "#9999b3";
        small = "#66ff66";
        medium = "#d77f42";
        large = "#d66b66";
      };

      inode = {
        valid = "#e7e7e7";
        invalid = "#d66b66";
      };

      links = {
        valid = "#00b3b3";
        invalid = "#d66b66";
      };

      treeEdge = "#b3b3ff";

      color = {
        when = "always";
        theme = "custom";
      };

      icons = {
        when = "always";
        theme = "fancy";
        separator = " ";
      };
    };
  };

  # Home Manager
  home.stateVersion = "24.11";
}
