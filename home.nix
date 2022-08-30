{pkgs, lib, config, ...}:
let
  extraDesktopPackages =
    if config.dotfiles.desktop.enable then
      with pkgs; [
        zoom
        wavebox
        rider
      ]
    else [];
in
{
  dotfiles = {
    desktop = {
      enable = true;
      dropbox.enable = false;
      onedrive.enable = false;
      laptop = true;
      xsessionInitExtra = ''
      '';
    };
    packages = {
      devel = {
        enable = true;
        nix = true;
        db = true;
        dotnet = true;
        node = true;
        rust = true;
        haskell = false;
        python = true;
        go = false;
        java = false;
        clojure = false;
      };
      desktop = {
        gnome = true;
        x11 = true;
        media = true;
        chat = true;
        graphics = true;
      };
      kubernetes = true;
      cloud = true;
      geo = true;
    };
    extraDotfiles = [
      "bcrc"
      "codex"
      "ghci"
      "haskeline"
      "taskrc"
    ];
    vimDevPlugins = false;
  };

  home.packages = with pkgs; [
  ] ++ extraDesktopPackages;

  home.keyboard = {
    layout = "no";
    model = "pc104";
    options = [
      "eurosign:e"
      "caps:none"
    ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs = {
    git = {
      userEmail = "stig.r.jensen@oceanbox.io";
      userName = "Stig Rune Jensen";
    };

    ssh.matchBlocks = {
      saga = {
        user = "stig";
        hostname = "saga.sigma2.no";
      };
      fram = {
        user = "stig";
        hostname = "fram.sigma2.no";
      };
      betzy = {
        user = "stig";
        hostname = "betzy.sigma2.no";
      };
      sandel = {
        user = "stig";
        hostname = "sandel.chem.uit.no";
      };
      woolf = {
        user = "stig";
        hostname = "woolf.chem.uit.no";
      };
    };
  };

  imports = [ ./modules ];
}
