{ pkgs, config, lib, ... }: {

	xdg.mimeApps.defaultApplications = {
	  "text/html" = ["org.qutebrowser.qutebrowser.desktop"];
    "text/xml" = ["org.qutebrowser.qutebrowser.desktop"];
    "x-scheme-handler/http" = ["org.qutebrowser.qutebrowser.desktop"];
    "x-scheme-handler/https" = ["org.qutebrowser.qutebrowser.desktop"];
    "x-scheme-handler/qute" = ["org.qutebrowser.qutebrowser.desktop"];
	};

	programs.qutebrowser = {
		enable = true;
    loadAutoconfig = true;
    searchEngines = rec {
      kagi = "https://kagi.com/search?q={}";
      duckduckgo = "https://duckduckgo.com/?q={}";
      google = "https://google.com/search?q={}";
      modrinth = "https://modrinth.com/mods?q={}";
      scryfall = "https://scryfall.com/search?q={}";
      nix = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}";
      steamrip = "https://steamrip.com/?s={}";
      warframe_wiki = "https://wiki.warframe.com/?search={}";
      youtube = "https://www.youtube.com/results?search_query={}";
      tweeter = "https://x.com/search?q={}";
      anilist = "https://anilist.co/search/anime?search={}";
      
      # abbrs
      k = kagi;
      ddg = duckduckgo;
      g = google;
      mod = modrinth;
      sf = scryfall;
      str = steamrip;
      wf = warframe_wiki;
      y = youtube;
      x = tweeter;
      ani = anilist;

      # default engine
      DEFAULT = kagi;
    };
		settings = {
      url = rec {
        default_page = "192.168.15.12:1202/fernando";
        start_pages = [default_page];
      };
      tabs = {
        show = "multiple";
        position = "left";
        indicator.width = 0;
        width = "10%";
      };
      new_instance_open_target = "tab";
      #colors = {
      #};
		};    
    extraConfig = ''
      c.tabs.padding = {"bottom": 4, "left": 2, "right": 2, "top": 4}
      c.auto_save.session = True

      # aliases
      c.aliases['gm'] = 'open https://mail.google.com/mail/u/1/'

      # dark mode
      c.colors.webpage.preferred_color_scheme = "dark"
      # config.set('colors.webpage.darkmode.enabled', False, '*://youtube.com/*')
      
      config.bind('e', 'hint links spawn ${../../scripts/yt_mpv.sh} {hint-url}')
      config.bind('E', 'hint links spawn ${../../scripts/yt_mpv.sh} {url}')
      config.bind('xb', 'config-cycle statusbar.show always never')
    '';
	};
}
