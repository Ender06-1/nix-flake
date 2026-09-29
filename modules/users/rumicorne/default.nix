{ self, lib, ... }:
let
  username = "rumicorne";
in
{
  flake.homeConfigurations = self.lib.mkHomeManager "x86_64-linux" username;

  flake.modules = lib.mkMerge [
    (self.lib.mkSimpleUser username)

    {
      homeManager.${username} = {
        imports = with self.modules.homeManager; [
          obs-studio

          minecraft
        ];
      };
    }
  ];
}
