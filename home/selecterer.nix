{ pkgs, ... }:
let
  selecterer = pkgs.writeScriptBin "selecterer" ''
    SEARCH_DIR=/home/ruben/Developer
    selected=$(find "$SEARCH_DIR" -type d -name ".git" | sed 's/\/.git$//' | ${pkgs.fzf}/bin/fzf --height=20% --reverse --info=inline --prompt="Select a repository: ")

    # exit if no project was selected
    if [[ -z "$selected" ]]; then
        exit 0
    fi

    selected_name=$(basename "$selected" | tr . _)
    echo "$selected"
  '';
in
{
  home.packages = [ selecterer ];
}
