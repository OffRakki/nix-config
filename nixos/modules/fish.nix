{ pkgs, config, lib, ...}:
{
  programs = {
    fish = {
      enable = true;
      vendor = {
        config.enable = true;
        completions.enable = true;
        functions.enable = true;
      };
      interactiveShellInit =  ''
        set fish_greeting
        direnv hook fish | source
        zoxide init fish --cmd cd | source
        fastfetch
        todo list
      '';
     shellAliases = {
        # file management

        # better copy copy
        cp = "rsync --archive --verbose --progress";
        rsync = "rsync --archive --verbose --progress";

        ls = "eza --colour=always --colour-scale all --colour-scale-mode gradient";
        la = "eza --colour=always --colour-scale all --colour-scale-mode gradient -a";
        eza = "eza --colour=always --colour-scale all --colour-scale-mode gradient";
        ezaa = "eza --colour=always --colour-scale all --colour-scale-mode gradient -a";
        mv = "mv -i";
        rm = "rm -i";
        df = "df -h";
        du = "du -hc --time";
        tree = "tree --du -h";

        fzf = "fzf --color=16";

        grep = "grep --color=always";
        egrep = "egrep --color=always";
        fgrep = "fgrep --color=always";
      };
      shellAbbrs = {

        # jujutsu
        jjs  = "jj split -r";
        jjm  = "jj b m master --to";
        jjd  = "jj describe -r"; 
        jjsq = "jj squash -r";
        jjgp = "jj git push";

        # nix
        ncg = "nix-collect-garbage";
        nrd = "sudo nixos-rebuild switch --flake ~/Documents/nixConfig#sora";
        # nhos = "nh os switch ~/Documents/nix-config";
        nixdev = "nix develop -c $SHELL";
        nix-shell = "nix-shell --command $SHELL";

        ff = "fastfetch";

        # fish
        src = "source ~/.config/fish/config.fish";

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
        gitall = "git add -A && git commit -a && git push";

        # misc
        pipes = "pipes.sh -t 3 -f 100 -R -r 0";
        htop = "btop";
        cat = "bat";
      };
    };
  };
}
