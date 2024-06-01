{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      mandalore-nixos = {
        host = "mandalore";
        hostname = "192.168.178.5";
        port = 69;
        user = "ruben";
        identityFile = [
          "~/.ssh/id_ed25519_sk"
          "~/.ssh/yubikey-5-usb-c/id_ed25519_sk.pub"
        ];
      };
      mandalore-nixos-initrd = {
        host = "mandalore-initrd";
        hostname = "192.168.178.5";
        port = 69;
        user = "root";
        identityFile = [
          "~/.ssh/id_ed25519_sk"
          "~/.ssh/yubikey-5-usb-c/id_ed25519_sk.pub"
        ];
      };
      niklas = {
        host = "niklas";
        hostname = "185.16.60.119";
        port = 69;
        user = "ruben";
      };

      # git remotes
      github = {
        hostname = "github.com";
        port = 22;
      };
      gitlab = {
        hostname = "gitlab.com";
        port = 22;
      };
    };
  };
}
