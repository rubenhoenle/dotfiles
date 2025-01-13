{ pkgs, ... }:
let
  eduroam-dhbw-hdh = builtins.fetchurl {
    name = "cateduroam.py";
    url = "https://cat.eduroam.org/user/API.php?action=downloadInstaller&lang=en&profile=7797&device=linux&generatedfor=user&openroaming=0";
    sha256 = "10m05dh86dnhjln04py1hj60vr2x9r57q4vrl3famgx3f6y8qnw8";
  };
  python-with-dbus = pkgs.python3.withPackages (p: with p; [ dbus-python ]);
  install-script = pkgs.writeShellScriptBin "install-eduroam-dhbw-hdh"
    "${python-with-dbus}/bin/python3 ${eduroam-dhbw-hdh}";
in
{
  home.packages = [ install-script ];
}
