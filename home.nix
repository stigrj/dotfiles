{
  pkgs,
  config,
  ...
}:
let
  sources = import ./npins;
  unstable = import sources.nixpkgs {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };

  username = "stig";
  fullname = "Stig Rune Jensen";
  email = "stig.r.jensen@oceanbox.io";

  keyboard = "us(altgr-intl)";
  extraDesktopPackages =
    if config.dotfiles.desktop.enable then
      with pkgs;
      [
        ferdium
        unstable.jetbrains.rider
      ]
    else
      [ ];
in
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    packages = with pkgs; [ ] ++ extraDesktopPackages;

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  dotfiles = {
    keyboard = {
      layout = keyboard;
      model = "pc104";
      options = [
        "eurosign:e"
        "caps:none"
      ];
    };

    desktop = {
      laptop = false;
      enable = true;
      wayland.enable = true;
      hyprland = {
        enable = true;
        monitor = [
          "HDMI-A-1, 2560x1440, 0x0, 1, transform, 3"
          "DP-1, 3840x1600, 1440x480, 1"
        ];
      };
      noctalia-shell.enable = true;
      waybar.enable = false;
      sway.enable = false;
      dropbox.enable = false;
      onedrive.enable = false;
      cursorSize = 24;
      packages = {
        gnome = true;
        x11 = false;
        media = true;
        chat = true;
        graphics = true;
      };
    };
    devel = {
      enable = true;
      nix = true;
      db = true;
      dotnet = {
        enable = true;
        combined = true;
      };
      node = true;
      rust = false;
      haskell = false;
      python = true;
      go = false;
      java = false;
      clojure = false;
    };
    packages = {
      kubernetes = true;
      cloud = true;
      geo = true;
    };
    fish.vi-mode = false;
    atuin = false;
  };

  services.lorri.enable = true;

  programs = {
    git.settings = {
      user = {
        inherit email;
        name = fullname;
      };
      extraConfig = {
        grep.lineNumber = true;
      };
    };
    difftastic = {
      enable = false;
      git = {
        enable = true;
        diffToolMode = true;
      };
    };

    ssh.settings = {
      saga = {
        user = "${username}";
        hostname = "saga.sigma2.no";
      };
      fram = {
        user = "${username}";
        hostname = "fram.sigma2.no";
      };
      betzy = {
        user = "${username}";
        hostname = "betzy.sigma2.no";
      };
      sandel = {
        user = "${username}";
        hostname = "sandel.chem.uit.no";
      };
      woolf = {
        user = "${username}";
        hostname = "woolf.chem.uit.no";
      };
      ekman = {
        user = "${username}";
        hostname = "ekman.ts.obx";
      };
      rossby = {
        user = "${username}";
        hostname = "rossby.ts.obx";
      };
    };
  };

  imports = [ ./modules ];
}
