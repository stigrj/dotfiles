{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.dotfiles.packages;

  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
  hie = all-hies.selection { selector = p: { inherit (p) ghc865; }; };

  configuration = {
    dotfiles.packages.devel = {
      nix = mkDefault true;
    };

    home.packages = enabledPackages;
  };

  base = with pkgs; [
    git
    binutils
    gcc
    gdb
    gnumake
    cmake
    libxml2
    docker-compose
    gettext
    gnum4
    chromedriver # for selenium
    jq
    websocat
    meld
    automake
    autoconf
    libtool
    git-filter-repo
    bfg-repo-cleaner
    # sqsh
    squashfsTools
  ];

  haskell = with pkgs; [
    ghc
    # stack
    hie
    cabal-install
    hlint
    hoogle
    # cabal2nix
    # alex
    # happy
    # cpphs
    # hscolour
    # haddock
    # pointfree
    # pointful
    # hasktags
    # threadscope
    # hindent
    # codex
    # hscope
    # glirc
  ];

  dotnetPackage =
    if cfg.devel.dotnet.combined then
        with pkgs.dotnetCorePackages; combinePackages [
          pkgs.dotnet-sdk_6
          pkgs.dotnet-sdk_7
        ]
    else
          pkgs.dotnet-sdk_6;

  dotnet = {
    home.sessionVariables = {
        DOTNET_ROOT = dotnetPackage;
    };
    home.packages = [
        dotnetPackage
    ];
  };

  python = with pkgs; [
    (python3.withPackages (ps: with ps; [
        numpy
        netcdf4
        matplotlib
        tkinter
        virtualenv
        jupyter
        pandas
        scipy
        plotly
        networkx
      ]))
  ];

  node = with pkgs.nodePackages; [
    pkgs.nodejs
    npm
    yarn
    webpack
    # node2nix
    # gulp
    # bundler
    # bundix
    # yo
    # purescript
    # psc-package
    # pulp
    # cordova
  ];

  rust = with pkgs; [
    cargo
  ];

  go = with pkgs; [
    go
    go2nix
  ];

  clojure = with pkgs; [
    clooj
    leiningen
  ];

  nix = with pkgs; [
    niv
    lorri
    nix-prefetch-scripts
    patchelf
    rnix-lsp
  ];

  db = with pkgs; [
    postgresql
    sqlite-interactive
  ];

  java = with pkgs; [
    openjdk
    gradle
    ant
  ];

  useIf = x: y: if x then y else [];

  enabledPackages =
    base ++
    useIf cfg.devel.node node ++
    useIf cfg.devel.rust rust ++
    useIf cfg.devel.haskell haskell ++
    useIf cfg.devel.python python ++
    useIf cfg.devel.go go ++
    useIf cfg.devel.clojure clojure ++
    useIf cfg.devel.nix nix ++
    useIf cfg.devel.java java ++
    useIf cfg.devel.db db;
in {
  options.dotfiles.packages = {
    devel = {
      enable = mkEnableOption "Enable development packages";
      dotnet = {
          enable = mkEnableOption "Enable dotnet sdk";
          combined = mkEnableOption "Enable combined dotnet sdk";
      };
      node = mkEnableOption "Enable Node.js";
      nix = mkEnableOption "Enable nix";
      rust = mkEnableOption "Enable Rust";
      haskell = mkEnableOption "Enable Haskell";
      python = mkEnableOption "Enable Python";
      go = mkEnableOption "Enable Go";
      clojure = mkEnableOption "Enable Clojure";
      java = mkEnableOption "Enable Java";
      db = mkEnableOption "Enable database cli tools";
    };

  };

  config = mkIf cfg.devel.enable (mkMerge [
    configuration
    (mkIf cfg.devel.dotnet.enable dotnet)
  ]);

}
