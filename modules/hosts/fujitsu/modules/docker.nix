{ ... }:
{
  virtualisation.docker.enable = true;

  users.users."admin".extraGroups = [ "docker" ];
}
