{
  flake-file = {
    do-not-edit = "DO NOT EDIT: file automatically generated. use `nix run .#write-flake";

    description = "Ender06-1's flake";

    outputs = "inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules)";
  };

  systems = [
    "x86_64-linux"
  ];
}
