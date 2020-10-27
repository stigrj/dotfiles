pkgs:
{
  desktop = {
    enable = false;
    laptop = false;
    dropbox = false;
  };
  wsl.enable = false;
  dotnet = rec {
    enable = false;
    sdk = pkgs.dotnetCorePackages.sdk_5_0;
    root =
      if enable then
        { DOTNET_ROOT = sdk; }
      else
        {};
  };
  node = false;
  haskell = false;
  python = false;
  proton = false;
  languages = false;
  vimDevPlugins = false;
  eth = "ens3";
  gitUser = {
    userEmail = "jonas.juselius@itpartner.no";
    userName = "Jonas Juselius";
    signing = {
      key = "jonas.juselius@gmail.com";
    };
  };
  sshHosts = {
    example = {
      user = "demo";
      hostname = "acme.com";
    };
  };

}

