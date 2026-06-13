{ config, pkgs, lib, ... }:

let
  caldavPass = "/run/secrets/caldavPass";
in
{
  home.packages = with pkgs; [ vdirsyncer khal khard ];

  xdg.configFile."vdirsyncer/config".text = ''
    [general]
    status_path = "${config.xdg.dataHome}/vdirsyncer/status"

    [pair personal_calendar]
    a = "personal_calendar_remote"
    b = "personal_calendar_local"
    collections = ["from a", "from b"]

    [pair personal_contacts]
    a = "personal_contacts_remote"
    b = "personal_contacts_local"

    [storage personal_calendar_local]
    type = "filesystem"
    path = "~/Calendars/"
    fileext = ".ics"

    [storage personal_calendar_remote]
    type = "caldav"
    url = "https://apidata.googleusercontent.com/caldav/v2/fernandomarques1505@gmail.com/user"
    username = "fernandomarques1505@gmail.com"
    password.fetch = ["command", "cat", "${caldavPass}"]

    [storage personal_contacts_local]
    type = "filesystem"
    path = "~/Contacts/"
    fileext = ".vcf"

    [storage personal_contacts_remote]
    type = "carddav"
    url = "https://www.googleapis.com/carddav/v1/fernandomarques1505@gmail.com"
    username = "fernandomarques1505@gmail.com"
    password.fetch = ["command", "cat", "${caldavPass}"]
  '';

  xdg.configFile."khal/config".text = ''
    [calendars]
    [[personal]]
    path = ~/Calendars/
    type = discover
    color = light blue
    priority = 10

    [locale]
    firstweekday = 0
    timeformat = %H:%M
    dateformat = %d/%m/%Y
  '';

  xdg.configFile."khard/khard.conf".text = ''
    [addressbooks]
    [[contacts]]
    path = ~/Contacts/
  '';

  xdg.configFile."todoman/config".text = ''
    [DEFAULT]
    date_format = %d/%m/%Y
    time_format = %H:%M
    humanize = True
    default_due = 0
    glob = ~/Calendars/*/*
    default_list = personal
  '';

  systemd.user.services.vdirsyncer = {
    Unit = {
      Description = "vdirsyncer sync";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${lib.getExe pkgs.vdirsyncer} sync";
    };
    Install.WantedBy = [ "multi-user.target" ];
  };

  systemd.user.timers.vdirsyncer = {
    Unit.Description = "vdirsyncer periodic sync";
    Timer = {
      OnCalendar = "*:0/30";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };

  home.persistence."/persist".directories = lib.mkAfter [
    "Calendars"
    "Contacts"
    ".local/share/vdirsyncer"
  ];
}
