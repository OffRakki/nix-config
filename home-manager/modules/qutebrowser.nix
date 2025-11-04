{ pkgs, config, lib, ... }: {

	programs.qutebrowser = {
		enable = true;
    loadAutoconfig = true;
    searchEngines = rec {
      kagi = "https://kagi.com/search?q={}";
      duckduckgo = "https://duckduckgo.com/?q={}";
      google = "https://google.com/search?hl=en&q={}";
      k = kagi;
      ddg = duckduckgo;
      g = google;
      DEFAULT = kagi;
    };
		settings = {
      url = rec {
        default_page = "https://kagi.com";
        start_pages = "192.168.15.12:1202/fernando";
      };
      tabs = {
        show = "multiple";
        position = "left";
        # indicator.width = 0;
      };
      new_instance_open_target = "window";
      #colors = {
      #};
		};    
    extraConfig = ''
      c.tabs.padding = {"bottom": 10, "left": 10, "right": 10, "top": 10}
    '';
	};
																				}
