{
  pkgs,
  lib,
  ...
}: {
  programs = {
    firefox.enable = true;
    hyprland.enable = true; #someone forgot to set this so desktop file is created
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    adb.enable = true;
    gamemode.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    prismlauncher
    obsidian
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    amfora # Fancy Terminal Browser For Gemini Protocol
    #    appimage-run # Needed For AppImage Support
    bitwarden-desktop
    brightnessctl # For Screen Brightness Control
    cliphist # Clipboard manager using rofi menu
    cmatrix # Matrix Movie Effect In Terminal
    cowsay # Great Fun Terminal Program
    docker-compose # Allows Controlling Docker From A Single File
    duf # Utility For Viewing Disk Usage In Terminal
    eza # Beautiful ls Replacement
    file-roller # Archive Manager
    gedit # Simple Graphical Text Editor
    gimp # Great Photo Editor
    glxinfo #needed for inxi diag util
    greetd.tuigreet # The Login Manager (Sometimes Referred To As Display Manager)
    htop # Simple Terminal Based System Monitor
    hyprpicker # Color Picker
    eog # For Image Viewing
    inxi # CLI System Information Tool
    killall # For Killing All Instances Of Programs
    libnotify # For Notifications
    lm_sensors # Used For Getting Hardware Temps
    lolcat # Add Colors To Your Terminal Command Output
    lshw # Detailed Hardware Information
    mpv # Incredible Video Player
    ncdu # Disk Usage Analyzer With Ncurses Interface
    nixfmt-rfc-style # Nix Formatter
    nwg-displays #configure monitor configs via GUI
    onefetch #provides zsaneyos build info on current system
    pavucontrol # For Editing Audio Levels & Devices
    pciutils # Collection Of Tools For Inspecting PCI Devices
    picard # For Changing Music Metadata & Getting Cover Art
    languagetool
    pkg-config # Wrapper Script For Allowing Packages To Get Info On Others
    playerctl # Allows Changing Media Volume Through Scripts
    rhythmbox
    ripgrep # Improved Grep
    socat # Needed For Screenshots
    unrar # Tool For Handling .rar Files
    unzip # Tool For Handling .zip Files
    usbutils # Good Tools For USB Devices
    v4l-utils # Used For Things Like OBS Virtual Camera
    wget # Tool For Fetching Files With Links
    yazi #TUI File Manager
    ytmdl # Tool For Downloading Audio From YouTube
  ];

  nixpkgs.overlays = with pkgs; [
    (
      final: prev: {
        jellyfin-web = prev.jellyfin-web.overrideAttrs (finalAttrs: previousAttrs: {
          installPhase = ''
            runHook preInstall

            # this is the important line
            sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script></head>#" dist/index.html

            mkdir -p $out/share
            cp -a dist $out/share/jellyfin-web

            runHook postInstall
          '';
        });
      }
    )
  ];

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    ELECTRON_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "0";
    WLR_NO_HARDWARE_CURSORS = "1"; # work around broken hw cursors :contentReference[oaicite:3]{index=3}
    LD_LIBRARY_PATH = lib.mkForce [
      "${pkgs.xorg.libICE}/lib"
      "${pkgs.xorg.libSM}/lib"
      "${pkgs.xorg.libX11}/lib"
    ];
  };
}
