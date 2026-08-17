let
  admin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN44us5eU3w0e0qGB1/xwQLOLt9zTCpXwDyixOaaVl8m";
  fujitsu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICkOvyzHXL7ODR4wGx2oSdPCv8CLjWlWQaT3ESVMKAwA";
in
{
  "tandoor.age".publicKeys = [
    admin
    fujitsu
  ];
}
