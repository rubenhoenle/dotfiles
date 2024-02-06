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
          border-radius: 16px;
          border: 1px solid #5074bd;
      }
      #entry:selected {
          background-color: #FF0000;
          color: white;
          border-radius: 16px;
      }
      #entry {
          margin-left: 16px;
          margin-right: 16px;
          margin-top: 8px;
          margin-bottom: 8px;
      }
    '';
  };
}
