{
  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "puppygrrl";
  gitEmail = "puppygirl@tuta.io";

  # Hyprland Settings
  extraMonitorSettings = "
  monitor=DP-1,2560x1440@144,0x0,1
  monitor=HDMI-A-1,1920x1080@240,2560x0,1
    ";

  # Waybar Settings
  clock24h = false;

  # Program Options
  browser = "firefox";
  terminal = "kitty";
  keyboardLayout = "us";
  consoleKeyMap = "us";

  # Enable NFS
  enableNFS = true;

  # Enable Printing Support
  printEnable = false;

  # Set Stylix Image
  stylixImage = ../../wallpapers/wallpaper.jpg;

  # Set Waybar
  # Includes alternates such as waybar-curved.nix & waybar-ddubs.nix
  waybarChoice = ../../modules/home/waybar/waybar-simple.nix;

  # Set Animation style
  # Available options are:
  # animations-def.nix  (default)
  # animations-end4.nix (end-4 project)
  # animations-dynamic.nix (ml4w project)
  animChoice = ../../modules/home/hyprland/animations-def.nix;
}
