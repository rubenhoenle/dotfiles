{
  services.fprintd.enable = true;

  security.pam.services = {
    swaylock.fprintAuth = false;
    login.fprintAuth = true;
    sudo.fprintAuth = true;
  };
}
