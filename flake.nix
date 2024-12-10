{
    description = "Advent of Code 2024 in Elixir";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    };

    outputs = { self, nixpkgs, ... }:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        projectName = "AdventOfCode2024";
    in
    {
        devShells.${system}.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
                elixir
                elixir-ls
            ];

            shellHook = ''
                printf '\x1b[36m\x1b[1m\x1b[4mTime to develop ${projectName}!\x1b[0m\n\n'
            '';
        };
    };
}
