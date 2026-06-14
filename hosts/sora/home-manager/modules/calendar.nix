{ config, pkgs, lib, ... }:

let
  caldavPass = "/run/secrets/caldavPass";
in
{
  home.packages = with pkgs; [ vdirsyncer khal khard ];

  accounts.calendar.basePath = "Calendars";

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
    collections = null

    [storage personal_calendar_local]
    type = "filesystem"
    path = "~/Calendars/"
    fileext = ".ics"

    [storage personal_calendar_remote]
    type = "caldav"
    url = "https://www.googleapis.com/calendar/dav/fernandomarques1505@gmail.com/user"
    username = "fernandomarques1505@gmail.com"
    password.fetch = ["command", "cat", "${caldavPass}"]

    [storage personal_contacts_local]
    type = "filesystem"
    path = "~/Contacts/"
    fileext = ".vcf"

    [storage personal_contacts_remote]
    type = "carddav"
    url = "https://www.googleapis.com/carddav/v1/principals/fernandomarques1505@gmail.com/lists/default"
    username = "fernandomarques1505@gmail.com"
    password.fetch = ["command", "cat", "${caldavPass}"]
  '';

  xdg.configFile."khal/config".text = ''
    [calendars]
    [[events]]
    path = ~/Calendars/events/
    color = light blue
    priority = 10

    [[birthdays]]
    path = ~/Contacts/
    type = birthdays
    color = dark magenta
    priority = 15

    [default]
    highlight_event_days = True

    [highlight_days]
    color = light blue

    [locale]
    firstweekday = 0
    timeformat = %H:%M
    dateformat = %d/%m/%Y
  '';

  xdg.configFile."khard/khard.conf".text = ''
    [contact table]
    localize_dates = True

    [addressbooks]
    [[contacts]]
    path = ~/Contacts/
  '';

  programs.todoman = {
    enable = true;
    glob = "*";
    extraConfig = ''
      default_list = "events"
      date_format = "%d/%m/%Y"
      time_format = "%H:%M"
      humanize = True
      default_due = 0
    '';
  };

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
