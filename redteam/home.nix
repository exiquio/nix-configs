{ config, pkgs, ... }:

{
  home.username = "redteam";
  home.homeDirectory = "/home/redteam";
  home.packages = with pkgs; [
    # Dependancies
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
    unzip
    python3
    go

    # Productivity 
    flameshot

    # Browsers 
    ungoogled-chromium

    # Penetration Testing Tools
    whois
    dnsutils
    nmap
    ssh-audit
    mitm6
    ffuf
    wafw00f
    john
    hashcat
    amass
    username-anarchy
    rdesktop
    freerdp3
    metasploit
    exploitdb
    smbmap
    sqlmap
    hashcat
    python312Packages.impacket
    netexec
    bloodhound-py
    thc-hydra
    medusa
    samba
    enum4linux-ng
    nikto
    whatweb
    naabu
  ];

  # Shell
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting;

      fish_vi_key_bindings

      alias vim='echo "Use nvim"'
      alias vi='echo "Use nvim"'
      alias vimdiff='echo "nvim -d"'
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
      alias burpsuite='java -jar "/home/redteam/Tools/Web Applications/Web Proxies/Burp Suite Pro/burpsuite_pro_v2024.12.1.jar"'

      export PATH="/home/redteam/go/bin:/home/redteam/.pdtm/go/bin:$PATH"
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
      background-opacity = "0.9";
    };
  };

  # Source control
  programs.git = {
    enable = true;
    userName = "Exiquio Cooper-Anderson";
    userEmail = "exiquio@gmail.com";
  };

  # Home Manager
  home.stateVersion = "24.11";
}
