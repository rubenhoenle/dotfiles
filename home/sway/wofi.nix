{
  programs.wofi = {
    enable = true;
    style = ''
      * {
          font-family: "JetBrainsMono Nerd Font";
          background-color: transparent;
          color: #ccc;
          outline-width: 0px;
          outline: none;
      }
      window {
          background-color: #222;
          border-radius: 4px;
          border: 1px solid #5074bd;
      }
      #entry:selected {
          background-color: #59281D;
          color: white;
      }
    '';
  };
}
