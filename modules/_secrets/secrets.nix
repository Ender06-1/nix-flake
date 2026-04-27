let
  matheo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPybOZB+lmPWgxHv5boGPtlMz6QQ8T881/Yzbk/M36z";
in
{
  "caddy.age".publicKeys = [ matheo ];
}
