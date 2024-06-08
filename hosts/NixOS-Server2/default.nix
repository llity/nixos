{ config, lib, pkgs, ... }:

{
  imports = [
    ./configuration.nix
    ./disko.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./server.nix
  ];
}
