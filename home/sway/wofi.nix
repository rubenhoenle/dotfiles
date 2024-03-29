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
          border: 1px solid #ccc;
      }
      #input {
          border-radius: 0px;
          border: none;
      }
      #entry:selected {
          background-color: #5e1b72;
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
