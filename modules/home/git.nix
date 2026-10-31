{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "kawzuma";
        email = "ngogiakhang1912@gmail.com"; # Replace with your actual email
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      core.editor = "nano";
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        cm = "commit -m";
      };
    };
  };
}
