{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      vps = {
        host = "vps";
        hostname = "vps.hoenle.xyz";
        port = 41524;
        user = "ruben";
        identityFile = [
          "~/.ssh/id_ed25519_sk"
        ];
      };
      mandalore-nixos = {
        host = "mandalore";
        hostname = "192.168.178.5";
        port = 41524;
        user = "ruben";
        identityFile = [
          "~/.ssh/id_ed25519_sk"
        ];
      };
      mandalore-nixos-initrd = {
        host = "mandalore-initrd";
        hostname = "192.168.178.5";
        port = 45274;
        user = "root";
        identityFile = [
          "~/.ssh/id_ed25519_sk"
        ];
      };
      niklas = {
        host = "niklas";
        hostname = "185.16.60.119";
        port = 69;
        user = "ruben";
      };
      bergkapellen-backup = {
        host = "bergkapellen-backup";
        hostname = "192.168.178.6";
        port = 69;
        user = "ruben";
      };

      # git remotes
      "github.com" = {
        hostname = "github.com";
        port = 22;
      };
      "git.hoenle.xyz" = {
        hostname = "192.168.178.5";
        port = 41524;
        user = "git";
        identityFile = [
          "~/.ssh/id_ed25519_sk"
        ];
      };
      github-private = {
        hostname = "github.com";
        port = 22;
        identityFile = [ "~/.ssh/id_ed25519_sk" ];
      };
      "gitlab.com" = {
        hostname = "gitlab.com";
        port = 22;
      };
    };
  };
}
