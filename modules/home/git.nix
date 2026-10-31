{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "kawzuma";
    userEmail = "ngogiakhang1912@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      core.editor = "nano";
    };
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      cm = "commit -m";
    };
  };
}
