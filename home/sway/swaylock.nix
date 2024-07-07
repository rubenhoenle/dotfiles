let
  image = builtins.fetchurl {
    url = "https://github.com/Golo300/dotfiles/blob/c76fd362753374c6c1f4d428033894cc959db3bd/home/timl/wallpaper/nixos.jpg";
    sha256 = "105w2chk50hz24vvb2jqaqv3ip6r8kzcqjcaf0ci5gsr601q1wag";
  };
in
{
  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
      image = "${image}";
    };
  };
}
