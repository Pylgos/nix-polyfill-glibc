{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/24.05";
    polyfill-glibc-src = {
      url = "github:corsix/polyfill-glibc";
      flake = false;
    };
  };

  outputs =
    {
      self,
      flake-utils,
      nixpkgs,
      polyfill-glibc-src,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = rec {
          polyfill-glibc = pkgs.callPackage ./polyfill-glibc.nix { src = polyfill-glibc-src; };
          default = polyfill-glibc;
        };
      }
    )
    // {
      overlays.default = final: prev: {
        polyfill-glibc = final.callPackage ./polyfill-glibc.nix { src = polyfill-glibc-src; };
      };
    };
}
