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
        port = 2222;
        user = "root";
        identityFile = [
          "~/.ssh/id_ed25519_sk"
          "~/.ssh/yubikey-5-usb-c/id_ed25519_sk.pub"
        ];
      };
      scarif-nixos = {
        host = "scarif";
        hostname = "192.168.178.4";
        port = 69;
        user = "ruben";
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
      schlag-o-meterer = {
        host = "schlag-o-meterer";
        hostname = "127.0.0.1";
        port = 23235;
        user = "ruben";
      };
      schlago = {
        host = "schlago";
        hostname = "schlago.hoenle.xyz";
        port = 23235;
        user = "guest";
      };

      # git remotes
      "github.com" = {
        hostname = "github.com";
        port = 22;
      };
      "git.hoenle.xyz" = {
        hostname = "192.168.178.5";
        port = 69;
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
