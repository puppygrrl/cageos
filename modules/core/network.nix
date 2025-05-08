{
  pkgs,
  host,
  options,
  ...
}: {
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
    firewall = {
      enable = true;
      trustedInterfaces = ["tailscale0"];
      checkReversePath = "loose";
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
        8080
      ];
      allowedUDPPorts = [
        41641
        59010
        59011
      ];
    };
  };

  environment.systemPackages = with pkgs; [networkmanagerapplet tailscale];
}
