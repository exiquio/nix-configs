{ config, pkgs, ... }:
  
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };

  # Networking
  networking = {
    hostName = "redteam";
    nameservers = [ "1.1.1.1" ];
    extraHosts = ''
    '';
    networkmanager.enable = true;
  };

  # Time
  time.timeZone = "America/Denver";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Desktop Environment
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  environment.gnome.excludePackages = (with pkgs; [
    atomix
    cheese
    epiphany
    geary
    gnome-characters
    gnome-music
    gnome-photos
    gnome-tour
    hitori
    iagno
    tali
    totem
  ]);
  
  # Printing
  services.printing.enable = true;

  # Audio
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Programs
  programs = {
    fish.enable = true;
    firefox.enable = true;
    gnupg.agent.enable = true;
    proxychains = {
      enable = true;
      proxies.prx1.enable = true;
      proxies.prx1.type = "socks5";
      proxies.prx1.host = "127.0.0.1";
      proxies.prx1.port = 9050;
    };
  };

  # Packages
  environment.systemPackages = with pkgs; [
    neovim
    wget
    unzip
    killall
    openssl
    gcc
  ];
  nixpkgs.config.allowUnfree = true;


  # Default editor
  environment.variables.EDITOR = "nvim"; 

  # Virtualization
  virtualisation.docker.enable = true;

  # Other Sevices
  services.openssh.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # Users
  users.users.redteam = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "redteam";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    ];
  };

  # TODO: Read before modifying!
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
