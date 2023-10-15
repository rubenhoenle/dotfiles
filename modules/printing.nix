{ pkgs, ... }: {
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      hplip
      #brlaser
    ];
  };
  hardware.printers = {
    ensureDefaultPrinter = "printer01";
    ensurePrinters = [
      {
        name = "Space-2D-Printer";
        model = "HP/hp-color_laserjet_mfp_m480-ps.ppd.gz";
        deviceUri = "socket://2d.sfz-aalen.space";
      }
      {
        # this printer from brother didn't wanted to work with brother drivers, so I just used the 
        # driver of the HP printer in the space (see above) and it worked... LOL
        name = "printer01";
        model = "HP/hp-color_laserjet_mfp_m480-ps.ppd.gz";
        deviceUri = "ipp://printer01.fritz.box";
        ppdOptions.PageSize = "A4";
      }
    ];
  };
}

