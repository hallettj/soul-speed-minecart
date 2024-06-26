{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
  };
  outputs = { self, nixpkgs, systems }:
    let
      perSystem = callback: nixpkgs.lib.genAttrs (import systems) (system: callback (mkPkgs system));
      mkPkgs = system: nixpkgs.legacyPackages.${system};
    in
    {
      packages = perSystem (pkgs: {
        default = pkgs.stdenvNoCC.mkDerivation {
          name = "soulspeed-minecarts.zip";
          nativeBuildInputs = with pkgs; [
            gnumake
            zip
          ];
          src = ./.;
          buildPhase = ''
            make
          '';
          installPhase = ''
            mv *.zip $out
          '';
        };
      });

      devShells = perSystem (pkgs: {
        default = pkgs.mkShell {
          inputsFrom = [ self.packages.${pkgs.system}.default ];
        };
      });
    };
}
