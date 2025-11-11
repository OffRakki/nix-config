{
  config,
  pkgs,
  lib,
  ...
}: let
  gmail_channels = {
    Inbox = {
      farPattern = "INBOX";
      nearPattern = "Inbox";
      extraConfig = {
        Create = "Near";
        Expunge = "Both";
      };
    };
    Junk = {
      farPattern = "[Gmail]/Spam";
      nearPattern = "Junk";
      extraConfig = {
        Create = "Near";
        Expunge = "Both";
      };
    };
    Trash = {
      farPattern = "[Gmail]/Trash";
      nearPattern = "Trash";
      extraConfig = {
        Create = "Near";
        Expunge = "Both";
      };
    };
    Drafts = {
      farPattern = "[Gmail]/Drafts";
      nearPattern = "Drafts";
      extraConfig = {
        Create = "Near";
        Expunge = "Both";
      };
    };
    Sent = {
      farPattern = "[Gmail]/Sent Mail";
      nearPattern = "Sent";
      extraConfig = {
        Create = "Near";
        Expunge = "Both";
      };
    };
    # Gmail has no true "archived" folder
    # Using All Mail causes duplicates
    # So use a custom gmail tag instead
    # Note the absence of the [Gmail] prefix.
    Archive = {
      farPattern = "Archived Mail";
      nearPattern = "Archive";
      extraConfig = {
        Create = "Both";
        Expunge = "Both";
      };
    };
  };
in {
  accounts.email = {
    accounts.main = rec {
      primary = true;
      address = "offrakki@gmail.com";
      realName = "OffRakki";

      userName = address;
      passwordCommand = "${lib.getExe pkgs.oama} access ${userName}";
      flavor = "gmail.com";

      mbsync = {
        enable = true;
        create = "maildir";
        expunge = "both";
        groups.main.channels = gmail_channels;
        extraConfig = {
          account.AuthMechs = "XOAUTH2";
        };
      };

      neomutt = {
        enable = true;
        extraMailboxes = [
          "Archive"
          "Drafts"
          "Junk"
          "Sent"
          "Trash"
        ];
      };

      msmtp = {
        enable = true;
        extraConfig = {
          auth = "oauthbearer";
        };
      };
    };
  };

  programs.msmtp.enable = true;

  programs.mbsync = {
    enable = true;
    package = pkgs.isync.override {
      withCyrusSaslXoauth2 = true;
    };
  };
  services.mbsync = {
    enable = true;
    package = config.programs.mbsync.package;
  };

  xdg.configFile."oama/config.yaml".text = builtins.toJSON {
    encryption.tag = "KEYRING";
    services.google = {
      client_id_cmd = "${lib.getExe pkgs.pass} oama/google_client_id | head -1";
      client_secret_cmd = "${lib.getExe pkgs.pass} oama/google_client_secret | head -1";
      auth_scope = "https://mail.google.com/ https://www.googleapis.com/auth/calendar https://www.googleapis.com/auth/contacts";
    };
  };
}
