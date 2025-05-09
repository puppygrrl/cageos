{profile, ...}: {
  # Services to start

  services = {
    tailscale.enable = true;
    libinput.enable = true; # Input Handling
    fstrim.enable = true; # SSD Optimizer
    gvfs.enable = true; # For Mounting USB & More
    openssh.enable = true; # Enable SSH
    blueman.enable = true; # Bluetooth Support
    tumbler.enable = true; # Image/video preview
    gnome.gnome-keyring.enable = true;
    flatpak.enable = true;

    udev.extraRules = ''
      # GameCube and 8BitDo/Lossless adapters – allow full access
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="102b", MODE="0666"
    '';
    dnsmasq = {
      enable = true;
      settings = {
        bind-interfaces = true;
        listen-address = ["0.0.0.0"];
        server = [
          "1.1.1.1"
          "9.9.9.9"
        ];
        addn-hosts = ["/etc/stevenblack/hosts"];
      };
    };

    transmission = {
      enable = true; #Enable transmission daemon
      openFirewall = true;
      settings = {
        bind-address-ipv4 = "100.111.61.107";
        rpc-bind-address = "0.0.0.0";
        download-dir = "/data/torrents";
      };
    };

    jackett = {
      enable = true;
      openFirewall = true;
    };

    sonarr = {
      enable = true;
      openFirewall = true;
    };

    radarr = {
      enable = true;
      openFirewall = true;
    };

    jellyfin = {
      enable = true;
      openFirewall = true;
    };

    smartd = {
      enable =
        if profile == "vm"
        then false
        else true;
      autodetect = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
