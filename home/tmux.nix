{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    extraConfig = ''
      # Start windows and panes at 1, not 0
      set -g base-index 1
      setw -g pane-base-index 1

      # Set new panes to open in current directory
      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };

  programs.zsh.prezto = {
    enable = false;
    tmux = {
      autoStartLocal = false;
      autoStartRemote = false;
      defaultSessionName = "auto";
    };
  };
}
