{ pkgs, ... }:
let
  selecterer = pkgs.writeScriptBin "selecterer" ''
    if [[ "$#" -eq 1 ]]; then
        # if an argument was given use this as selection target
        selected="$1"
    else
        # get a project from the pre-specified directories
        selected=$(${pkgs.findutils}/bin/find \
            $HOME/Developer/git \
            $HOME/Developer/git/HACKWERK \
            $HOME/Developer/git/BROMANCE-DOTFILES \
            -mindepth 1 -maxdepth 1 -type d | ${pkgs.fzf}/bin/fzf)
    fi

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
