{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        name = "nix-flake";

        packages = with pkgs; [
          nil
        ];
      };
    };
}
