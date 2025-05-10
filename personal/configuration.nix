{ config, pkgs, ... }:

{
  # TODO: Refactor

  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking
  networking = {
    # TODO: Change hostname as appropriate
    hostName = "luna";
    networkmanager.enable = true;
  };
  # Synack
  #networking.interfaces.wlo1 = {
  #  mtu = 1450;
  #};

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

  # Graphics
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];
  
  # Desktop Environment
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    videoDrivers = [ "amdgpu" ];
  };
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";

  # Printing
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Audio
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Programs
  programs = {
    firefox.enable = true;
    fish.enable = true;
    gnupg.agent.enable = true;
    virt-manager.enable = true;
  };

  # Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    neovim
    wget
    unzip
    killall
    openssl
    gcc
    clinfo
    kdePackages.kate
    kdePackages.kcalc
    kdePackages.kaccounts-providers
    kdePackages.kaccounts-integration
    kdePackages.kio-gdrive
    kdePackages.signond
  ];

  # Default editor
  environment.variables.EDITOR = "nvim";

  # Virtualization
  virtualisation = {
    # Docker
    docker.enable = true;

    # Virt-Manger/Qemu
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;

    # VirtualBoax
    virtualbox.host.enable = true;
  };

  # Other Services
  services.openssh.enable = true;

  # Users
  users.users.exiquio = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Exiquio Cooper-Anderson";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "vboxusers" ];
  };

  # TODO: READ BEFORE CHANGING!
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
