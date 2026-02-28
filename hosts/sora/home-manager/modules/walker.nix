{lib, ...}: {
  programs.walker = lib.mkForce {
    enable = true;
    runAsService = true;
    config = {
      # General Settings
      search.typehead = true;
      terminal = "kitty";
      force_keyboard_focus = false;
      activation_mode = "lalt";
      close_when_open = true;
      click_to_close = true;
      as_window = false;
      single_click_activation = true;
      selection_wrap = false;
      global_argument_delimiter = "#";
      exact_search_prefix = "'";
      theme = "default";
      disable_mouse = false;
      debug = false;
      page_jump_items = 10;
      hide_quick_activation = false;
      hide_action_hints = false;
      hide_action_hints_dmenu = true;
      hide_return_action = false;
      resume_last_query = false;
      actions_as_menu = false;
      autoplay_videos = false;

      shell = {
        layer = "overlay";
        anchor_top = true;
        anchor_bottom = true;
        anchor_left = true;
        anchor_right = true;
      };

      columns = {
        "symbols" = 3;
      };

      placeholders = {
        "default" = {
          input = "Search";
          list = "No Results";
        };
      };

      keybinds = {
        close = ["Escape"];
        next = ["Down"];
        previous = ["Up"];
        left = ["Left"];
        right = ["Right"];
        down = ["Down"];
        up = ["Up"];
        toggle_exact = ["ctrl e"];
        resume_last_query = ["ctrl r"];
        quk_activate = ["F1" "F2" "F3" "F4"];
        page_down = ["Page_Down"];
        page_up = ["Page_Up"];
        show_actions = ["alt j"];
      };

      providers = {
        default = ["desktopapplications" "calc" "websearch"];
        empty = ["desktopapplications"];
        ignore_preview = [];
        max_results = 50;

        # Prefixes mapping
        prefixes = [
          {
            prefix = ";";
            provider = "providerlist";
          }
          {
            prefix = ">";
            provider = "runner";
          }
          {
            prefix = "/";
            provider = "files";
          }
          {
            prefix = "!";
            provider = "todo";
          }
          {
            prefix = "%";
            provider = "bookmarks";
          }
          {
            prefix = "=";
            provider = "calc";
          }
          {
            prefix = "@";
            provider = "websearch";
          }
          {
            prefix = ":";
            provider = "clipboard";
          }
          {
            prefix = "$";
            provider = "windows";
          }
        ];

        clipboard = {time_format = "relative";};

        # Actions mapping
        actions = {
          fallback = [
            {
              action = "menus:open";
              label = "open";
              after = "Nothing";
            }
            {
              action = "menus:default";
              label = "run";
              after = "Close";
            }
            {
              action = "menus:parent";
              label = "back";
              bind = "Escape";
              after = "Nothing";
            }
            {
              action = "erase_history";
              label = "clear hist";
              bind = "ctrl h";
              after = "AsyncReload";
            }
          ];
          dmenu = [
            {
              action = "select";
              default = true;
              bind = "Return";
            }
          ];
          providerlist = [
            {
              action = "activate";
              default = true;
              bind = "Return";
              after = "ClearReload";
            }
          ];

          desktopapplications = [
            {
              action = "start";
              default = true;
              bind = "Return";
            }
            {
              action = "start:keep";
              label = "open+next";
              bind = "shift Return";
              after = "KeepOpen";
            }
            {
              action = "new_instance";
              label = "new instance";
              bind = "ctrl Return";
            }
            {
              action = "new_instance:keep";
              label = "new+next";
              bind = "ctrl alt Return";
              after = "KeepOpen";
            }
            {
              action = "pin";
              bind = "ctrl p";
              after = "AsyncReload";
            }
            {
              action = "unpin";
              bind = "ctrl p";
              after = "AsyncReload";
            }
            {
              action = "pinup";
              bind = "ctrl n";
              after = "AsyncReload";
            }
            {
              action = "pindown";
              bind = "ctrl m";
              after = "AsyncReload";
            }
          ];

          clipboard = [
            {
              action = "copy";
              default = true;
              bind = "Return";
            }
            {
              action = "remove";
              bind = "ctrl d";
              after = "AsyncClearReload";
            }
            {
              action = "remove_all";
              label = "clear";
              bind = "ctrl shift d";
              after = "AsyncClearReload";
            }
            {
              action = "pause";
              bind = "ctrl shift p";
            }
            {
              action = "unpause";
              bind = "ctrl shift p";
            }
          ];

          todo = [
            {
              action = "save";
              default = true;
              bind = "Return";
              after = "AsyncClearReload";
            }
            {
              action = "delete";
              bind = "ctrl d";
              after = "AsyncClearReload";
            }
          ];
        };
      };
    };
  };
}
