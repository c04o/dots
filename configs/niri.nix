{
  config,
  pkgs,
  theme,
  inputs,
  ...
}: let
  # wbg fetcher so niri can use it
  myWallpaper = pkgs.fetchurl {
    url = theme.wallpaper.url;
    sha256 = theme.wallpaper.sha256;
  };
in {
  # import niri home manager module from the flake
  imports = [inputs.niri.homeModules.niri];

  programs.niri = {
    enable = true;

    settings = {
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      environment = {
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };

      spawn-at-startup = [
        {command = ["elephant"];}
        {command = ["sunsetr"];}
        {command = ["xwayland-satellite"];}

        # start clipboard history listeners for walker
        {command = ["wl-paste" "--type" "text" "--watch" "cliphist" "store"];}
        {command = ["wl-paste" "--type" "image" "--watch" "cliphist" "store"];}

        # niri launches these instead of systemd
        {command = ["waybar"];}
        {command = ["walker" "--gapplication-service"];}
        {command = ["${pkgs.wbg}/bin/wbg" "${myWallpaper}"];}
      ];

      input = {
        keyboard.xkb.layout = "us";
        touchpad = {
          tap = true;
          natural-scroll = true;
          dwt = true;
          accel-profile = "flat";
        };
        mouse.accel-profile = "flat";
      };

      outputs."eDP-1" = {
        scale = 1.0;
        mode = {
          width = 1920;
          height = 1080;
        };
        position = {
          x = 0;
          y = 0;
        };
      };

      layout = {
        gaps = 8;
        center-focused-column = "never";
        default-column-width = {proportion = 0.5;};

        preset-column-widths = [
          {proportion = 1.0 / 3.0;}
          {proportion = 0.5;}
          {proportion = 1.0;}
        ];

        # won't disappear after focus
        border = {
          enable = true;
          width = 2;
          active.color = theme.colors.aqua;
          inactive.color = theme.colors.bg_dim;
        };

        # disappears after focus
        focus-ring.enable = false;

        shadow = {
          enable = true;
          softness = 30;
          spread = 5;
          offset = {
            x = 0;
            y = 0;
          };
          color = "#00000070"; # docs default
        };
      };

      animations = {
        enable = true;
        slowdown = 0.75;
        # below 1.0 speeds up

        workspace-switch = {
          kind = {
            easing = {
              duration-ms = 150;
              curve = "ease-out-quad";
            };
          };
        };

        window-close = {
          kind = {
            easing = {
              duration-ms = 150;
              curve = "ease-out-quad";
            };
          };
        };

        horizontal-view-movement = {
          kind = {
            spring = {
              damping-ratio = 1.0;
              stiffness = 1000;
              epsilon = 0.0001;
            };
          };
        };

        window-movement = {
          kind = {
            spring = {
              damping-ratio = 1.0;
              stiffness = 1000;
              epsilon = 0.0001;
            };
          };
        };
      };

      window-rules = [
        {
          # apply to all windows
          geometry-corner-radius = {
            # rounding
            top-left = 18.0;
            top-right = 18.0;
            bottom-left = 18.0;
            bottom-right = 18.0;
          };

          # cut client-side window shadows
          clip-to-geometry = true;
        }
        {
          # fix steam notifications because xwayland blah blah
          matches = [
            {
              app-id = "steam";
              title = "^notificationtoasts_\\d+_desktop$";
            }
          ];
          default-floating-position = {
            x = 10;
            y = 10;
            relative-to = "bottom-right";
          };
        }
        {
          # set browser for pip content
          matches = [
            {
              app-id = "^(firefox|zen.*)$";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
        }
      ];

      binds = with config.lib.niri.actions; {
        # terminal emulator
        "Mod+Return".action = spawn "ghostty";

        # app launcher
        "Mod+Space".action = spawn "walker";

        # browser
        "Mod+B".action = spawn "zen";

        # system
        "Mod+Shift+E".action = quit;
        "Mod+Q".action = close-window;
        "Mod+Shift+P".action = power-off-monitors;
        "Mod+Shift+Slash".action = show-hotkey-overlay;

        # audio & brightness
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        };
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          action = spawn "brightnessctl" "set" "+10%";
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          action = spawn "brightnessctl" "set" "10%-";
        };

        # screenshots
        "Print".action = spawn "niri" "msg" "action" "screenshot";
        # interactive area screenshot
        "Ctrl+Print".action = spawn "niri" "msg" "action" "screenshot-screen";
        "Alt+Print".action = spawn "niri" "msg" "action" "screenshot-window";

        # nav: focus
        # vim-motions
        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+J".action = focus-window-or-workspace-down;
        "Mod+K".action = focus-window-or-workspace-up;
        # arrow keys
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Down".action = focus-window-or-workspace-down;
        "Mod+Up".action = focus-window-or-workspace-up;

        # nav: move windows/columns
        # vim-motions
        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+L".action = move-column-right;
        "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
        "Mod+Shift+K".action = move-window-up-or-to-workspace-up;
        # arrow keys
        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
        "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;

        # workspaces: focus jumps
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;

        # layout actions
        "Mod+F".action = maximize-column;
        "Mod+C".action = center-column;
        "Mod+V".action = toggle-window-floating;
        "Mod+W".action = toggle-column-tabbed-display;
        "Mod+R".action = switch-preset-column-width;
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Shift+F".action = fullscreen-window;

        # niri groupings
        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;
      };
    };
  };
}
