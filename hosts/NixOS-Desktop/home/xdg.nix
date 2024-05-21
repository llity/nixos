{ config, lib, pkgs, ... }:

{
  xdg.userDirs = {
    desktop = "/mount/Data/Datein/Desktop";
    documents = "/mount/Data/Datein/Dokumente";
    download = "/mount/Data/Datein/Downloads";
    music = "/mount/Data/Datein/Musik";
    pictures = "/mount/Data/Datein/Bilder";
    videos = "/mount/Data/Datein/Videos";
    extraConfig = {
      XDG_GAMES_DIR = lib.mkDefault "/mount/Games/Spiele";
    };
  };
}

