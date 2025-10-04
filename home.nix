{pkgs, lib, config, ...}:
let
  extraDesktopPackages =
    if config.dotfiles.desktop.enable then
      with pkgs; [
        # zoom-us
        # rider
        # ferdium
        # discord
      ]
    else [];
in
{
  home.username = "stig";
  home.homeDirectory = "/home/stig";

  home.packages = with pkgs; [
  ] ++ extraDesktopPackages;

  dotfiles = {
    desktop = {
      enable = true;
      dropbox.enable = false;
      onedrive.enable = false;
      laptop = false;
      xsessionInitExtra = ''
      '';
    };
    packages = {
      devel = {
        enable = true;
        nix = true;
        db = true;
        dotnet = {
            enable = true;
            combined = true;
        };
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
    vimDevPlugins = true;
    fish.vi-mode = false;
    atuin = false;
  };

  home.keyboard = {
    layout = "us(altgr-intl)";
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
      extraConfig = {
        grep.lineNumber = true;
      };
    };
  };

  services.lorri.enable = true;

  imports = [ ./modules ];
}
