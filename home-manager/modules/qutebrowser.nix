{ pkgs, config, lib, ... }: {

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
        position = "top";
        # indicator.width = 0;
      };
      new_instance_open_target = "window";
      #colors = {
      #};
		};    
    extraConfig = ''
      c.tabs.padding = {"bottom": 2, "left": 4, "right": 4, "top": 2}
      c.auto_save.session = True

      # aliases
      c.aliases['gm'] = 'open https://mail.google.com/mail/u/1/'

      # dark mode
      c.colors.webpage.preferred_color_scheme = "dark"
      
      config.bind('e', 'hint links spawn /home/rakki/Documents/nix-config/hosts/rakki/scripts/yt_mpv.sh {hint-url}')
      config.bind('E', 'hint links spawn /home/rakki/Documents/nix-config/hosts/rakki/scripts/yt_mpv.sh {url}')
      config.bind('xb', 'config-cycle statusbar.show always never')
    '';
	};
																				}
