{
  description = "ffbtools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = rec {
          default = ffbtools;
          ffbtools = pkgs.multiStdenv.mkDerivation {
            pname = "ffbtools";
            version = "master";

            src = pkgs.fetchFromGitHub {
              owner = "berarma";
              repo = "ffbtools";
              rev = "master";
              sha256 = "K9RdZ211nhzQhNaw+vPx6XZ047ERjU++eUyaMyyEl70=";
            };

            installPhase = ''
              # cd bin
              # ls
              runHook preInstall
              mkdir -p $out/bin
              cp bin/* $out/bin
              runHook postInstall
            '';
          };
        };
      }
    );
}
