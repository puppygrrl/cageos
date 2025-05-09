{
  host,
  username,
  ...
}: let
  inherit (import ../../hosts/${host}/variables.nix) gitUsername gitEmail;
in {
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
    signing = {
      format = "ssh";
      key = "/home/${username}/.ssh/id_ed25519";
    };
  };
}
