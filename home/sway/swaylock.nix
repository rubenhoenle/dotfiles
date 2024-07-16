let
  image = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/Golo300/dotfiles/93bab13ad41c666af34d49aca63a251fbfa9b9b5/home/timl/wallpaper/nixos.jpg";
    sha256 = "02x2cdms4gp7dr6zr4af1s9qlxqha1mp5jbki90bazz2c1b8amm0";
  };
in
{
  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 60;
      inside-color = "000000";
      #line-color = "253243";
      key-hl-color = "87c1cf";
      ring-color = "6081ac";
      show-failed-attempts = false;
      image = "${image}";
    };
  };
}
