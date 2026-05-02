let
  matheo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPybOZB+lmPWgxHv5boGPtlMz6QQ8T881/Yzbk/M36z";
  fujitsu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICkOvyzHXL7ODR4wGx2oSdPCv8CLjWlWQaT3ESVMKAwA";
in
{
  "caddy.age".publicKeys = [
    matheo
    fujitsu
  ];
}
