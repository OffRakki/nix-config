{ pkgs, inputs, ...}: let

python-packages = pkgs.python3.withPackages (
		ps:
		with ps; [
		requests
		pyquery # needed for hyprland-dots Weather script
		]
		);

in {

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = (with pkgs; [
# System Packages
			mangohud
			baobab
			btrfs-progs
			clang
			curl
			cpufrequtils
			duf
			eza
			ffmpeg   
			glib #for gsettings to work
			gsettings-qt
			killall  
			libappindicator
			libnotify
			openssl #required by Rainbow borders
			pciutils
			vim
			wget
			xdg-user-dirs
			xdg-utils
			fastfetch
			oh-my-fish
			(mpv.override {scripts = [mpvScripts.mpris];}) # with tray
#ranger

# Hyprland Stuff
#(ags.overrideAttrs (oldAttrs: { inherit (oldAttrs) pname; version = "1.8.2"; }))
			ags_1 # desktop overview  
			wofi
			btop
			brightnessctl # for brightness control
			cava
			cliphist
			eog
			gnome-system-monitor
			grim
			gtk-engine-murrine #for gtk themes
			hypridle
			imagemagick 
			inxi
			jq
			alacritty
			kitty
			libsForQt5.qtstyleplugin-kvantum #kvantum
			networkmanagerapplet
			nwg-look
			nvtopPackages.full	 
			pamixer
			pavucontrol
			playerctl
			polkit_gnome
			pyprland
			libsForQt5.qt5ct
			kdePackages.qt6ct
			kdePackages.qtwayland
			kdePackages.qtstyleplugin-kvantum #kvantum
			rofi-wayland
			slurp
			swappy
			swaynotificationcenter
			swww
			unzip
			wallust
			wl-clipboard
			wlogout
			xarchiver
			yad
			yt-dlp

#waybar  # if wanted experimental next line
#(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
			]) ++ [
			python-packages
			];

# FONTS
	fonts = { 
		packages = with pkgs; [
			corefonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-color-emoji
      material-icons
      font-awesome
      fira-code-symbols
			fira-code
      symbola
      nerd-fonts.jetbrains-mono
      nerd-fonts.comic-shanns-mono
      nerd-fonts.shure-tech-mono
      nerd-fonts.lekton
			nerd-fonts.fira-code
			nerd-fonts.inconsolata
			jetbrains-mono
			terminus_font
	];
	fontconfig = {
  	defaultFonts = {
      serif = ["Lekton Nerd Font"];
      sansSerif = ["Lekton Nerd Font"];
      monospace = ["Lekton Nerd Font Mono"];
    };
	};
};

	programs.waybar.enable = true;
	programs.hyprlock.enable = true;
	programs.firefox.enable = true;
	programs.nm-applet.indicator = true;
	programs.neovim.enable = true;
	programs.neovim.defaultEditor = true;
	programs.thunar.enable = true;
	programs.thunar.plugins = with pkgs.xfce; [
		exo
			mousepad
			thunar-archive-plugin
			thunar-volman
			tumbler
	];

	programs.virt-manager.enable = false;

	programs.steam = {
  	enable = true;
  	gamescopeSession.enable = true;
  	remotePlay.openFirewall = true;
  	dedicatedServer.openFirewall = true;
	};

	programs.seahorse.enable = true;
	programs.fuse.userAllowOther = true;
	programs.mtr.enable = true;
	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};

# Extra Portal Configuration
	xdg.portal = {
		enable = true;
		wlr.enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-gtk
		];
		configPackages = [
			pkgs.xdg-desktop-portal-gtk
				pkgs.xdg-desktop-portal
		];
	};

}
