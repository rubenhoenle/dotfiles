{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ruben = {
    isNormalUser = true;
    description = "Ruben";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "dialout" # for arduino 
    ];
    shell = pkgs.zsh;
  };
}
