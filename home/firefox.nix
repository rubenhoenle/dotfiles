{ pkgs, ... }: {

  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        OverrideFirstRunPage = "";
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = false;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          };
          "vimium-ff@gavinsharp.github.com" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium/latest.xpi";
          };
        };

        FirefoxHome = {
          Search = true;
          Pocket = false;
          Snippets = false;
          TopSites = true;
          Highlights = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
      };
    };

    profiles.default = {
      search.force = true; # This is required so the build won't fail each time
      isDefault = true;
      name = "default";
      search.default = "DuckDuckGo";
      settings = {
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.pinned" = [
          {
            label = "Mail";
            url = "https://mail.proton.me/u/1/inbox";
          }
          {
            label = "Drive";
            url = "https://drive.proton.me/u/1/";
          }
          {
            label = "Space";
            url = "https://home.sfz-aalen.space/";
          }
          {
            label = "Space";
            url = "https://home.sfz-aalen.space/";
          }
          {
            label = "Space";
            url = "https://home.sfz-aalen.space/";
          }
          {
            label = "Github";
            url = "https://github.com/";
          }
          {
            label = "Nix search";
            url = "https://search.nixos.org/";
          }
          {
            label = "Space";
            url = "https://home.sfz-aalen.space/";
          }
        ];
      };
    };
  };
}
