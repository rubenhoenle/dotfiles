{ pkgs, ... }:
{
  # disable gnome apps
  # https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505 
  environment.gnome.excludePackages = with pkgs.gnome; [
    #baobab      # disk usage analyzer
    cheese # photo booth
    #eog         # image viewer
    epiphany # web browser
    #gedit       # text editor
    #simple-scan # document scanner
    #totem       # video player
    yelp # help viewer
    #evince      # document viewer
    #file-roller # archive manager
    geary # email client
    seahorse # password manager

    # these should be self explanatory
    #gnome-calculator
    gnome-calendar
    gnome-characters
    #gnome-clocks 
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    #gnome-photos 
    #gnome-screenshot
    #gnome-system-monitor 
    gnome-weather
    #gnome-disk-utility 
    pkgs.gnome-connections
  ];
}
