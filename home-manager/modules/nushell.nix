{ pkgs, config, nix-colors, ... }: {
    programs = {
	nushell = {
	    enable = true;
	    extraConfig = ''
		let carapace_completer = {|spans|
		carapace $spans.0 nushell ...$spans | from json
		}
		$env.config = {
		    show_banner: false,
		    completions: {
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
		} 
		$env.PATH = ($env.PATH | 
		split row (char esep) |
		prepend /home/rakki/.apps |
		append /usr/bin/env
		)
	    '';
	  shellAliases = {
	    
# nix
		ncg = "nix-collect-garbage";
		nrd = "sudo nixos-rebuild switch --flake ~/Documents/nix-config#igris";

# sudo
		sv = "sudo nvim";

# neofetch (uwufetch)
#neofetch = "neofetch --backend jp2a --source ~/.config/alacritty/uwuarch/uwuarch.png"
		nf = "neofetch";

# fish
		src = "source ~/.config/fish/config.fish";

# mount-cel
#celmount = "simple-mtpfs --device 1 ~/mount/"
#celumount = "fusermount -u ~/mount/"


# nvim
		vfish = "nvim ~/.config/fish/config.fish";
		nvfish = "neovide ~/.config/fish/config.fish";
		vzsh = "nvim ~/.zshrc";
		nvzsh = "neovide ~/.zshrc";
		vi3 = "nvim ~/.i3/config";
		nvi3 = "neovide ~/.i3/config";
		vherb = "nvim ~/.config/herbstluftwm/autostart";
		valias = "nvim ~/.aliases";
		nvalias = "neovide ~/.aliases";
		vim = "nvim";
		v = "nvim";
		nv = "neovide";
		vstar = "nvim ~/.config/starship.toml";
		vbkp = "nvim ~/.scripts/backup/backup.sh";


# cd
		".." = "cd ..";

# youtube-dl
		ytd = "youtube-dl -o '~/yt-downloads/%(title)s.%(ext)s' ";
		yta-best = "youtube-dl --extract-audio --audio-format best -o '~/yt-downloads/%(title)s.%(ext)s' ";
		yta-mp3 = "youtube-dl --extract-audio --audio-format mp3 -o '~/yt-downloads/%(title)s.%(ext)s' ";
		ytd-best = "youtube-dl -f mp4+bestaudio -o '~/yt-downloads/%(title)s.%(ext)s' ";

# mpv
		mpvs = "~/.scripts/mpv/mpvs";
		mpvsa = "~/.scripts/mpv/mpvsa";

# music
		mpa = "~/.scripts/mpv/mpa.sh";
		lofi = "mpv --ytdl-format = bestaudio ytdl://ytsearch:'www.youtube.com/watch?v = hGvWS1pLb3g'";
		lofi2 = "mpv --ytdl-format = bestaudio ytdl://ytsearch:https://www.youtube.com/watch?v = zRRq4Rd1lPs";
		hype = "mpv --ytdl-format = bestaudio ytdl://ytsearch:'https://www.youtube.com/watch?v = MTahu17Cgc8'";
		lucas20 = "mpv --ytdl-format = bestaudio ytdl://ytsearch:'https://www.youtube.com/watch?v = fLpCyU_SHRo'";
		lucas19 = "mpv --ytdl-format = bestaudio ytdl://ytsearch:'https://www.youtube.com/watch?v = PhfXQ58ywuI'";
		violin = "mpv --ytdl-format = bestaudio ytdl://ytsearch:'https://www.youtube.com/watch?v = iceS6BvhuQ8'";
		violin2 = "mpv --ytdl-format = bestaudio ytdl://ytsearch:'https://www.youtube.com/watch?v = synJbsrk0k8'";
		villain = "mpv --ytdl-format = bestaudio ytdl://ytsearch:'https://www.youtube.com/watch?v = le1l4eeo8Ow'";
		bnha = "mpv --no-video ~/Music/BNHA/*";
		gambare = "mpv --ytdl --no-video 'https://www.youtube.com/watch?v = gnxNdYi69Zg'";

# git
		gitall = "git add -A and git commit -a and git push";

# misc
		pipes = "pipes.sh -t 3 -f 100 -R -r 0";
		htop = "btop";
		cat = "bat";
		localserver = "~/.scripts/localserver/startlocalserver";

# file management
		mv = "mv -i";
		rm = "rm -i";
		cp = "cp -i";
		df = "df -h";
		#du = "du -hc --time";
		tree = "tree --du -h";
		ls = "ls -FahsSL --color = always";
		#la = "ls -A";
		exa = "exa -lFs name --colour = always --colour-scale --group-directories-first";

		fzf = "fzf --color = 16";

		grep = "grep --color = always";
		egrep = "egrep --color = always";
		fgrep = "fgrep --color = always";
	    };
	};
	carapace.enable = true;
	carapace.enableNushellIntegration = true;
    };
}
