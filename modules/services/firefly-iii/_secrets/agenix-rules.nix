let
  admin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPtfsQkSeOawtr1QvAIBMTpx5xR2/8I550VI3VHD02E";
  hp-server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP5zNX4MmEgbltKKVrXDsqVAGufH2rQwSHHbDOG/kkuJ";

  keys = [
    admin
    hp-server
  ];
in
{
  "firefly-iii-app.age".publicKeys = keys;
  "firefly-iii-db.age".publicKeys = keys;
}
