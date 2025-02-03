{ config, pkgs, ... }:

{
  # USER CONFIGURATION
  home.username = "redteam";
  home.homeDirectory = "/home/redteam";

  # PACKAGE CONFIGURATION
  home.packages = with pkgs; [
    # SOTWARE PACKAGES

    # CLI tools
    wget
    mlocate
    jq
    feh
    glow
    xclip
    bat
    lsd
    ripgrep
    fd
    glances
    unzip
    openvpn
    killall
    
    # Programming
    go
    python39
    ruby_3_4
    jdk23

    # Alternative web browsers
    ungoogled-chromium

    # Desktop tools
    libreoffice-qt-fresh
    flameshot
    variety

    # Penetration testing tools
    whois
    dnsutils
    nmap
    ssh-audit
    mitm6
    nikto
    ffuf
    wafw00f
    amass
    username-anarchy
    freerdp3
    metasploit
    smbmap
    sqlmap
    httpx
    naabu
    katana
    nuclei
    subfinder

    # Create package for
    # urlfinder
  ];

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
      alias burpsuite='java -jar Tools/Burp-Suite-Pro/burpsuite_pro_v2024.12.1.jar'

      export PATH="/home/redteam/go/bin:$PATH"
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
  };

  # Home Manager
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
