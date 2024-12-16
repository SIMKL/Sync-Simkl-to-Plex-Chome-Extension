{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      systems,
      treefmt-nix,
      ...
    }:
    let
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
      treefmtEval = eachSystem (
        pkgs:
        treefmt-nix.lib.mkWrapper pkgs {
          projectRootFile = "flake.nix";
          programs = {
            nixfmt.enable = true;
            deadnix.enable = true;
            statix.enable = true;
            shfmt.enable = true;
            shellcheck.enable = true;
            jsonfmt.enable = true;
            yamlfmt.enable = true;
            prettier.enable = true;
            prettier.excludes = [ "*/vendor/*" ];
            dprint.enable = true;
            dprint.settings.includes = [ "**/*.md" ];
            dprint.settings.plugins = [ "https://plugins.dprint.dev/markdown-0.17.8.wasm" ];
          };
        }
      );
    in
    {
      devShells = eachSystem (pkgs: {
        default = pkgs.mkShellNoCC {
          env = {
            PUPPETEER_SKIP_DOWNLOAD = true;
            PUPPETEER_BROWSER = "chrome";
            #PUPPETEER_EXECUTABLE_PATH = "${pkgs.brave}/bin/brave";
            PUPPETEER_EXECUTABLE_PATH = "${pkgs.chromium}/bin/chromium";
          };
          packages = with pkgs; [
            nodejs_18
            nodePackages.pnpm
            nodePackages.npm-check-updates
            minify
          ];
        };
      });
      formatter = treefmtEval;
    };
}
