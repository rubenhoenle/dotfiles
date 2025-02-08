{ pkgs, ... }:
let
  /* The 'clonerer' is a tool which clones git repos to specified locations and sets up additional git remotes for them. */

  gitBasePath = "/home/ruben/Developer";
  bromanceDotfilesPath = "${gitBasePath}/BROMANCE-DOTFILES";
  hackwerkReposPath = "${gitBasePath}/HACKWERK";
  configFile = pkgs.writeText "clonerer-config.json" (builtins.toJSON [
    {
      name = "homepage";
      path = "${gitBasePath}";
      origin = "git@github.com:rubenhoenle/rubenhoenle.github.io.git";
    }
    {
      name = "Matrix-MQTT-Bridge";
      path = "${gitBasePath}";
      origin = "git@github.com:rubenhoenle/Matrix-MQTT-Bridge.git";
    }
    {
      name = "texerer";
      path = "${gitBasePath}";
      origin = "git@github.com:rubenhoenle/texerer.git";
    }
    {
      name = "NixOServer";
      path = "${gitBasePath}";
      origin = "git@github.com:rubenhoenle/NixOServer.git";
    }
    {
      name = "pi-nixos";
      path = "${gitBasePath}";
      origin = "git@github.com:rubenhoenle/pi-nixos.git";
      remotes = {
        sezuisa = "git@github.com:sezuisa/pi-nixos.git";
      };
    }
    {
      name = "bergkapellen-docs";
      path = "${gitBasePath}";
      origin = "git@github.com:rubenhoenle/bergkapellen-docs.git";
    }
    {
      name = "docker-composer";
      path = "${gitBasePath}";
      origin = "git@github.com:rubenhoenle/docker-composer.git";
    }
    {
      name = "gigacube";
      path = "${gitBasePath}";
      origin = "git@github.com:rubenhoenle/gigacube.git";
    }
    {
      name = "lovebox";
      path = "${gitBasePath}";
      origin = "git@github.com:rubenhoenle/lovebox.git";
    }
    {
      name = "adventofcode";
      path = "${gitBasePath}";
      origin = "git@github.com:rubenhoenle/adventofcode.git";
    }
    {
      name = "pixelknecht";
      path = "${gitBasePath}";
      origin = "git@github.com:rubenhoenle/pixelknecht.git";
    }
    {
      name = "wiki";
      path = "${gitBasePath}";
      origin = "git@git.hoenle.xyz:wiki.git";
    }
    {
      name = "Bewerbungsunterlagen";
      path = "${gitBasePath}";
      origin = "git@git.hoenle.xyz:bewerbungsunterlagen.git";
    }
    {
      name = "Briefvorlage";
      path = "${gitBasePath}";
      origin = "git@git.hoenle.xyz:briefvorlage.git";
    }
    {
      name = "Kirche-Homepage";
      path = "${gitBasePath}";
      origin = "git@git.hoenle.xyz:Kirche-Homepage.git";
    }
    {
      name = "NixOS";
      path = "/home/ruben";
      origin = "git@github.com:rubenhoenle/dotfiles.git";
      remotes = {
        linus = "git@gitlab.com:Lutzlin-peu/dotfiles.git";
        jgero = "git@github.com:jgero/dotfiles.git";
        golo300 = "git@github.com:Golo300/dotfiles.git";
        mschwer = "git@github.com:Markus-Schwer/dotfiles.git";
        sezuisa = "git@github.com:sezuisa/dotfiles.git";
      };
    }
    {
      /* linus dotfiles */
      name = "linus";
      path = "${bromanceDotfilesPath}";
      origin = "git@gitlab.com:rubenhoenle/lutzlin-peu-dotfiles.git";
      remotes = {
        upstream = "git@gitlab.com:Lutzlin-peu/dotfiles.git";
        ruben = "git@github.com:rubenhoenle/dotfiles.git";
      };
    }
    {
      /* golo300 dotfiles */
      name = "golo300";
      path = "${bromanceDotfilesPath}";
      origin = "git@github.com:rubenhoenle/golo300-dotfiles.git";
      remotes = {
        upstream = "git@github.com:Golo300/dotfiles.git";
        ruben = "git@github.com:rubenhoenle/dotfiles.git";
      };
    }
    {
      /* jgero dotfiles */
      name = "jgero";
      path = "${bromanceDotfilesPath}";
      origin = "git@github.com:rubenhoenle/jgero-dotfiles.git";
      remotes = {
        upstream = "git@github.com:jgero/dotfiles.git";
        ruben = "git@github.com:rubenhoenle/dotfiles.git";
      };
    }
    {
      /* mschwer dotfiles */
      name = "mschwer";
      path = "${bromanceDotfilesPath}";
      origin = "git@github.com:rubenhoenle/Markus-Schwer-dotfiles.git";
      remotes = {
        upstream = "git@github.com:Markus-Schwer/dotfiles.git";
        ruben = "git@github.com:rubenhoenle/dotfiles.git";
      };
    }
    {
      /* sezuisa dotfiles */
      name = "sezuisa";
      path = "${bromanceDotfilesPath}";
      origin = "git@github.com:rubenhoenle/sezuisa-dotfiles.git";
      remotes = {
        upstream = "git@github.com:sezuisa/dotfiles.git";
        ruben = "git@github.com:rubenhoenle/dotfiles.git";
      };
    }
    {
      name = "space-notebooks";
      path = "${hackwerkReposPath}";
      origin = "git@gitlab.com:sfz.aalen/infra/space-notebooks.git";
    }
    {
      name = "MirAAkunix";
      path = "${hackwerkReposPath}";
      origin = "git@gitlab.com:sfz.aalen/infra/miraakunix.git";
    }
    {
      name = "wuerfelschubser";
      path = "${hackwerkReposPath}";
      origin = "git@gitlab.com:sfz.aalen/infra/wuerfelschubser.git";
    }
    {
      name = "logos";
      path = "${hackwerkReposPath}";
      origin = "git@gitlab.com:sfz.aalen/hackwerk/hackwerklogo.git";
    }
    {
      name = "stickers";
      path = "${hackwerkReposPath}";
      origin = "git@gitlab.com:sfz.aalen/hackwerk/Stickers.git";
    }
    {
      name = "dotinder";
      path = "${hackwerkReposPath}";
      origin = "git@gitlab.com:sfz.aalen/hackwerk/dotinder.git";
    }
    {
      name = "hackwerk_homepage";
      path = "${hackwerkReposPath}";
      origin = "git@gitlab.com:sfz.aalen/hackwerk/hackwerk_homepage.git";
    }
    {
      name = "eventserver";
      path = "${hackwerkReposPath}";
      origin = "git@gitlab.com:sfz.aalen/infra/eventserver.git";
    }
  ]);

  clonerer = pkgs.writeShellApplication {
    name = "clonerer";
    runtimeInputs = [ pkgs.openssh ];
    text = ''
      export GIT_SSH="${pkgs.openssh}/bin/ssh"

      JSON_FILE="${configFile}"

      # Read the JSON file and process each repository
      ${pkgs.jq}/bin/jq -c '.[]' "$JSON_FILE" | while read -r repo; do
          NAME=$(echo "$repo" | ${pkgs.jq}/bin/jq -r '.name')
          PATH=$(echo "$repo" | ${pkgs.jq}/bin/jq -r '.path')
          ORIGIN=$(echo "$repo" | ${pkgs.jq}/bin/jq -r '.origin')

          # create the base directory if it doesn't exist
          ${pkgs.coreutils}/bin/mkdir -p "$PATH"

          # clone the repo if it isn't present already
          if [ -d "$PATH/$NAME" ]; then
            echo "Repo $NAME is already present in $PATH. Skipping ..."
          else
            echo "Cloning $NAME into $PATH..."
            ${pkgs.git}/bin/git clone "$ORIGIN" "$PATH/$NAME"
          fi


          # Check for additional remotes
          REMOTES=$(echo "$repo" | ${pkgs.jq}/bin/jq -c '.remotes // empty')

          if [ -n "$REMOTES" ]; then
              echo "Adding additional remotes for $NAME..."
              cd "$PATH/$NAME"

              # Add each additional remote
              echo "$REMOTES" | ${pkgs.jq}/bin/jq -r 'to_entries[] | "\(.key)|\(.value)"' | while read -r remote_def; do
                  # split the string
                  IFS='|'
                  read -r remote_name remote_url <<< "$remote_def"
                  unset IFS
                  
                  if ! ${pkgs.git}/bin/git config remote."$remote_name".url > /dev/null; then
                      echo "Adding git remote $remote_name"
                      ${pkgs.git}/bin/git remote add "$remote_name" "$remote_url"
                  else
                      echo "Git remote $remote_name is already present."
                  fi

              done

              # Go back to the original directory
              cd - > /dev/null
          fi
      done

      echo "All repositories have been cloned and configured."
    '';
  };
in
{
  home.packages = [ clonerer ];
}
