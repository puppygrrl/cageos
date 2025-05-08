{
  pkgs,
  lib,
  ...
}: {
  programs = {
    firefox.enable = true;
    hyprland.enable = true; #someone forgot to set this so desktop file is created
    dconf.enable = true;
    fuse.userAllowOther = true;
    gamemode.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    obsidian
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    bitwarden-desktop
    cliphist
    duf
    eza
    gimp
    glxinfo
    greetd.tuigreet
    htop
    eog
    libnotify
    lm_sensors
    lshw
    mpv
    ncdu
    nixfmt-rfc-style
    nwg-displays
    pavucontrol
    pciutils
    picard
    languagetool
    pkg-config
    playerctl
    rhythmbox
    ripgrep
    socat
    unrar
    unzip
    usbutils
    v4l-utils
    wget
    yazi
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
