{ pkgs, config, lib, ...}:
let
  useHelix = config.programs.helix.enable;
in
{
  programs = {
    fish = {
      enable = true;
      interactiveShellInit =  ''
        export BW_SESSION=(cat $HOME/.bwenv)
        set fish_greeting
        direnv hook fish | source
        zoxide init fish --cmd cd | source
        todo list


        # fish_vi_key_bindings
        # ${lib.optionalString useHelix "fish_helix_key_bindings"}
        # set fish_cursor_default     block      blink
        # set fish_cursor_insert      line       blink
        # set fish_cursor_replace_one underscore blink
        # set fish_cursor_visual      block


        # Use terminal colors
        set -x fish_color_autosuggestion      brblack
        set -x fish_color_cancel              -r
        set -x fish_color_command             brgreen
        set -x fish_color_comment             brmagenta
        set -x fish_color_cwd                 green
        set -x fish_color_cwd_root            red
        set -x fish_color_end                 brmagenta
        set -x fish_color_error               brred
        set -x fish_color_escape              brcyan
        set -x fish_color_history_current     --bold
        set -x fish_color_host                normal
        set -x fish_color_host_remote         yellow
        set -x fish_color_match               --background=brblue
        set -x fish_color_normal              normal
        set -x fish_color_operator            cyan
        set -x fish_color_param               brblue
        set -x fish_color_quote               yellow
        set -x fish_color_redirection         bryellow
        set -x fish_color_search_match        'bryellow' '--background=brblack'
        set -x fish_color_selection           'white' '--bold' '--background=brblack'
        set -x fish_color_status              red
        set -x fish_color_user                brgreen
        set -x fish_color_valid_path          --underline
        set -x fish_pager_color_completion    normal
        set -x fish_pager_color_description   yellow
        set -x fish_pager_color_prefix        'white' '--bold' '--underline'
        set -x fish_pager_color_progress      'brwhite' '--background=cyan'
      '';
      # plugins = lib.optional useHelix {
      #   name = "fish-helix";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "sshilovsky";
      #     repo = "fish-helix";
      #     rev = "8a5c7999ec67ae6d70de11334aa888734b3af8d7";
      #     hash = "sha256-04cL9/m5v0/5dkqz0tEqurOY+5sDjCB5mMKvqgpV4vM=";
      #   };
      # };
      shellAliases = {
        # file management

        # better copy copy
        cp = "rsync --archive --verbose --progress";
        rsync = "rsync --archive --verbose --progress";

        ls = "eza";
        la = "eza -a";
        mv = "mv -i";
        rm = "rm -i";
        df = "duf";
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
