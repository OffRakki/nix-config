{
  config,
  pkgs,
  lib,
  ...
}:
{
  accounts.email = {
    accounts.offrakki = rec {
      primary = true;
      address = "offrakki@gmail.com";
      realName = "OffRakki";

      userName = address;
      passwordCommand = "${lib.getExe pkgs.oama} access ${userName}";
      flavor = "gmail.com";

      aerc = {
        enable = true;
        smtpAuth = "oauthbearer";
        imapAuth = "oauthbearer";
      };
    };
  };
}
