{
  description = "Python environment with FPDF";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: 
  let
    systems = [ "x86_64-linux" "aarch64-darwin" ];  # Explicit support for macOS (Apple Silicon)
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f (import nixpkgs { system = system; }));
  in {
    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        buildInputs = [
          pkgs.python311
          pkgs.python311Packages.fpdf
        ];
      };
    });
  };
}
