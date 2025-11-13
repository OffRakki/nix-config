{ pkgs, config, lib, ... }: {
  programs = {
		nushell = lib.mkForce {
	    enable = true;
	    extraConfig = ''

				def create_left_prompt [] {
          let dir = match (do { $env.PWD | path relative-to $nu.home-path }) {
              null => $env.PWD
              ''' => '~'
              $relative_pwd => ([~ $relative_pwd] | path join)
          }

          let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
          let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
          let path_segment = $"($path_color)($dir)"

          $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
	      }

	      def create_right_prompt [] {
          # create a right prompt in magenta with green separators and am/pm underlined
          let time_segment = ([
              (ansi reset)
              (ansi magenta)
              (date now | format date '%x %X') # try to respect user's locale
          ] | str join | str replace --regex --all "([/:])" $"(ansi green)''${1}(ansi magenta)" |
              str replace --regex --all "([AP]M)" $"(ansi magenta_underline)''${1}")

          let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
              (ansi rb)
              ($env.LAST_EXIT_CODE)
          ] | str join)
          } else { "" }

          ([$last_exit_code, (char space), $time_segment] | str join)
	      }

	      def create_title [] {
	        let prefix = if SSH_TTY in $env {$"[(hostname | str replace -r "\\..*" "")] "}
	        let path = pwd | str replace $env.HOME "~"
	        ([$prefix, $path] | str join)
	      }

	      $env.PROMPT_COMMAND = { || create_left_prompt }
	      $env.PROMPT_COMMAND_RIGHT = { || create_right_prompt }
	      $env.PROMPT_INDICATOR = {|| "> " }
	      $env.PROMPT_INDICATOR_VI_INSERT = {|| "> " }
	      $env.PROMPT_INDICATOR_VI_NORMAL = {|| "| " }
	      $env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

	    	
				let carapace_completer = {|spans|
				carapace $spans.0 nushell ...$spans | from json
				}
				$env.config.show_banner = false
				$env.config.completions = {
					case_sensitive: false # case-sensitive completions
					quick: true    # set to false to prevent auto-selecting completions
					partial: true    # set to false to prevent partial filling of the prompt
					algorithm: "fuzzy"    # prefix or fuzzy
					external: {
					# set to false to prevent nushell looking into $env.PATH to find more suggestions
					enable: true 
					# set to lower can improve completion performance at the cost of omitting some options
					max_results: 100 
					completer: $carapace_completer # check 'carapace_completer' 
					}
		    }
				$env.PATH = ($env.PATH | 
				split row (char esep) |
				prepend /home/rakki/.apps |
				append /usr/bin/env
				)
	    '';
		  shellAliases = {
	      # jujutsu
	      jjs  = "jj split -r";
	      jjm  = "jj b m master --to";
	      jjd  = "jj describe -r"; 
	      jjsq = "jj squash -r";
	      jjgp = "jj git push";

	      # nix
	      ncg = "nix-collect-garbage";
	      nrd = "sudo nixos-rebuild switch --flake ~/Documents/nix-config#igris";
	      # nhos = "nh os switch ~/Documents/nix-config";
	      nixdev = "nix develop -c $env.SHELL";
	      nix-shell = "nix-shell --command $env.SHELL";

	      ff = "fastfetch";

	      # mount-cel
	      #celmount = "simple-mtpfs --device 1 ~/mount/"
	      #celumount = "fusermount -u ~/mount/"


	      # text editor
	      v = "hx";

	      # cd
	      ".." = "cd ..";

	      # youtube-dl
	      ytd = "youtube-dl -o '~/yt-downloads/%(title)s.%(ext)s' ";
	      yta-best = "youtube-dl --extract-audio --audio-format best -o '~/yt-downloads/%(title)s.%(ext)s' ";
	      yta-mp3 = "youtube-dl --extract-audio --audio-format mp3 -o '~/yt-downloads/%(title)s.%(ext)s' ";
	      ytd-best = "youtube-dl -f mp4+bestaudio -o '~/yt-downloads/%(title)s.%(ext)s' ";

	      # git
	      gitall = "git add -A; git commit -a; git push";

	      # misc
	      pipes = "pipes.sh -t 3 -f 100 -R -r 0";
	      htop = "btop";
	      cat = "bat";

	      cp = "rsync --archive --verbose --progress";
	      rsync = "rsync --archive --verbose --progress";

	      ls = "eza --colour=always --colour-scale all --colour-scale-mode gradient";
	      la = "eza --colour=always --colour-scale all --colour-scale-mode gradient -a";
	      eza = "eza --colour=always --colour-scale all --colour-scale-mode gradient";
	      ezaa = "eza --colour=always --colour-scale all --colour-scale-mode gradient -a";
	      mv = "mv -i";
	      rm = "rm -i";
	      df = "df -h";
	      tree = "tree --du -h";

	      fzf = "fzf --color=16";

	      grep = "grep --color=always";
	      egrep = "egrep --color=always";
	      fgrep = "fgrep --color=always";
	    };
		};
		carapace.enable = true;
		carapace.enableNushellIntegration = true;
	};
}
