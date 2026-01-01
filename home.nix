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

  keyboard = "no";
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

    packages =
      with pkgs;
      [
        #python3
      ]
      ++ extraDesktopPackages;

    keyboard = {
      layout = keyboard;
      model = "pc104";
      options = [
        "eurosign:e"
        "caps:none"
      ];
    };

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
      laptop = true;
      enable = true;
      wayland.enable = true;
      hyprland = {
        enable = true;
        monitor = [
          #"DP-6, 1920x1080, 0x0, 1"
          #"DP-5, 1920x1080, 1920x0, 1"
          #"eDP-1, disable"
          ", preferred, auto, 1"
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

    ssh.matchBlocks = {
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
