self: super:
let
  pname = "dotnet-sdk";
  platform = "linux";
  suffix = "x64";
in
{
  dotnet-sdk_6 = super.dotnetCorePackages.sdk_6_0.overrideAttrs (attrs: rec {
    version = "6.0.401";
    src = super.fetchurl {
      url = "https://dotnetcli.azureedge.net/dotnet/Sdk/${version}/${pname}-${version}-${platform}-${suffix}.tar.gz";
      sha512 = "sha512-b85fKebPyA2h34bS3jpjcQgCM5fSdeDc+gt57zbrhcLDQz20Z6pdj9p+MrwhIFoSZja1PVbE60xUfZ07I3DLMQ==";
    };
  });

  dotnet-sdk_7 = super.dotnetCorePackages.sdk_6_0.overrideAttrs (attrs: rec {
    version = "7.0.100-rc.1.22431.12";
    src = super.fetchurl {
      url = "https://dotnetcli.azureedge.net/dotnet/Sdk/${version}/${pname}-${version}-${platform}-${suffix}.tar.gz";
      sha256 = "sha256-WAnEwKNFuvTDDo1vS1qT33cr2tOtmCq+ysLS1uHtk+E=";
    };
  });

# workaround for a bug in nixpkgs
  # dotnetCorePackages.aspnetcore_2_1 = {};
  # dotnetCorePackages.netcore_2_1 = {};
  # dotnetCorePackages.sdk_2_1 = {};
  # dotnetCorePackages.sdk_3_1 = {};
}
