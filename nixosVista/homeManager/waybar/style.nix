{
  config,
  lib,
  nixosVista,
  ...
}: let
  cfg = nixosVista.waybar;

  ############################################################
  # DEFAULT PRESET
  ############################################################

  defaultStyle = ''
    @define-color accent_color #20d0fc;

    * {
      border: none;
      border-radius: 8;
      min-height: 0;
      /* For the taskbar, I prefer simple Noto Sans.*/
      font-family: Noto Sans;
      font-weight: bold;
      font-size: 14px;
      padding: 0px;
      padding-left: 0px;
      padding-right: 0px;
      background: transparent;
    }

    window#waybar {
      background-image: linear-gradient(to bottom, rgba(255,255,255,0.25)0%, rgba(0,0,0,0.5)50%, rgba(0,0,0,0.6)50%);
      border-radius: 12px;
      border-width: 1px;
      border-bottom-width: 1px;
      padding: 0px;

      border-style: solid;
      border-color: rgba(255,255,255,0.2);
    }

    tooltip {
      background-image: linear-gradient(to bottom, rgba(255,255,255,0.15)50%, rgba(0,0,0,0.2)50%, rgba(0,0,0,0.3)50%);
      color: white;

      border-top-style: solid;
      border-bottom-style: solid;
      border-width: 1px;
      border-top-color: rgba(255,255,255,0.4);
      border-bottom-color: rgba(255,255,255,0.25);
    }
    tooltip label {
      color: white;
    }

    #custom-os_btn {
      margin-left: 0.5cm;
    }

    #taskbar {
      margin: 4px 8px;
      margin-left: 0.25cm;
      color: white;
    }
    #taskbar button {
      margin-left: 0.2cm;
      margin-right: 0.2cm;
      padding: 1px;
      border-radius: 4px;

      border-style: none;
      border-bottom-style: solid;
      border-top-style: solid;
      border-width: 1px;
      border-bottom-color: rgba(255,255,255,0.15);
      border-top-color: rgba(255,255,255,0.3);

      box-shadow: 0px 0px 4px rgba(0,0,0,0.2);
    }
    #taskbar button:hover {
      background-color: rgba(0,0,0,0);
      box-shadow: 0px 0px 5px rgba(0,0,0,0.5);
      background-image: linear-gradient(to bottom, rgba(255,255,255,0.05), rgba(0,0,0,0.4));

      border-style: none;
      border-bottom-style: solid;
      border-top-style: solid;
      border-width: 1px;
      border-bottom-color: rgba(255,255,255,0.15);
      border-top-color: rgba(255,255,255,0.3);
    }
    #taskbar button.active {
      background-image: linear-gradient(to bottom, rgba(0,255,255,0.6), rgba(0,100,100,0.1));
    }

    #battery,
    #network,
    #clock,
    #tray,
    #workspaces,
    #pulseaudio {
      background-image: linear-gradient(to bottom, rgba(255,255,255,0.25), rgba(0,0,0,0.025));
      box-shadow: 0px 0px 3px rgba(0,0,0,0.34);
      margin: 4px;
      padding: 4px 8px;
      border-radius: 8px;
      color: rgb(220,220,220);

      /* Important style feature in order to give a glassy look! */
      /* I'm using the top and bottom borders to mimic highlights in highly reflective surfaces, looks good with the glassy-look */
      border-style: none;
      border-bottom-style: solid;
      border-top-style: solid;
      border-bottom-color: rgba(255,255,255,0.15);
      border-top-color: rgba(255,255,255,0.45);
      border-width: 1px;
    }

    #tray menu {
      background-color: rgba(255,255,255,0.025);
      color: rgba(220,220,220, 1);
      padding: 4px;
    }
    #tray menu menuitem {
      background-image: linear-gradient(to bottom, rgba(255,255,255,0.15),rgba(0,0,0,0.2),rgba(0,0,0,0.4));
      margin: 3px;
      color: rgb(220,220,220);
      border-radius: 4px;

      border-style: none;
      border-bottom-style: solid;
      border-top-style: solid;
      border-bottom-color: rgba(255,255,255,0.15);
      border-top-color: rgba(255,255,255,0.3);
      border-width: 1px;
    }
    #tray menu menuitem:hover {
      background-image: linear-gradient(to bottom, rgba(0,255,255,0.15), rgba(0,0,0,0.3), rgba(0,255,255,0.15));
      color: @accent_color;
      text-shadow: 0px 0px 6px @accent_color;
      box-shadow: 0px 0px 4px rgba(0,0,0,0.4);
    }

    #workspaces button {
    transition-duration: 100ms;
    all: initial;
    min-width: 0;
    color: rgb(220,220,220);
    margin-right: 0.2cm;
    margin-left: 0.2cm;
    text-shadow: 0px 0px 4px rgb(135,135,135);
    }


    #workspaces button.active {
      color: @accent_color;
      text-shadow: 0px 0px 6px @accent_color;
    }

    #workspaces button:hover {
      transition-duration: 120ms;
      color:@accent_color;
      text-shadow: 0px 0px 8px @accent_color;
    }

    #workspaces button.current_output {
    color: @accent_color;;
    }

    #workspaces button.urgent {
    color: #e78a4e;
    text-shadow: 0px 0px 6px #e78a4e;
    }

    #battery.warning,
    #battery.critical,
    #battery.urgent {
    color: #fcf520;
    }

  '';

  ############################################################
  # TRANSLUCENT PRESET
  ############################################################

  translucentStyle = ''
    @define-color accent_color #20d0fc;

    * {
      border: none;
      border-radius: 8;
      min-height: 0;
      /* For the taskbar, I prefer simple Noto Sans.*/
      font-family: Noto Sans;
      font-weight: bold;
      font-size: 14px;
      padding: 0px;
      padding-left: 0px;
      padding-right: 0px;
      background: transparent;
    }

    window#waybar {
      background-image: linear-gradient(to bottom, rgba(255,255,255,0.25)0%, rgba(0,0,0,0.5)50%, rgba(0,0,0,0.6)50%);
      border-radius: 12px;
      border-width: 1px;
      border-bottom-width: 1px;
      padding: 0px;

      border-style: solid;
      border-color: rgba(255,255,255,0.2);
    }

    tooltip {
      background-image: linear-gradient(to bottom, rgba(255,255,255,0.15)50%, rgba(0,0,0,0.2)50%, rgba(0,0,0,0.3)50%);
      color: white;

      border-top-style: solid;
      border-bottom-style: solid;
      border-width: 1px;
      border-top-color: rgba(255,255,255,0.4);
      border-bottom-color: rgba(255,255,255,0.25);
    }
    tooltip label {
      color: white;
    }

    #custom-os_btn {
      margin-left: 0.5cm;
    }

    #taskbar {
      margin: 4px 8px;
      margin-left: 0.25cm;
      color: white;
    }
    #taskbar button {
      margin-left: 0.2cm;
      margin-right: 0.2cm;
      padding: 1px;
      border-radius: 4px;

      border-style: none;
      border-bottom-style: solid;
      border-top-style: solid;
      border-width: 1px;
      border-bottom-color: rgba(255,255,255,0.15);
      border-top-color: rgba(255,255,255,0.3);

      box-shadow: 0px 0px 4px rgba(0,0,0,0.2);
    }
    #taskbar button:hover {
      background-color: rgba(0,0,0,0);
      box-shadow: 0px 0px 5px rgba(0,0,0,0.5);
      background-image: linear-gradient(to bottom, rgba(255,255,255,0.05), rgba(0,0,0,0.4));

      border-style: none;
      border-bottom-style: solid;
      border-top-style: solid;
      border-width: 1px;
      border-bottom-color: rgba(255,255,255,0.15);
      border-top-color: rgba(255,255,255,0.3);
    }
    #taskbar button.active {
      background-image: linear-gradient(to bottom, rgba(0,255,255,0.6), rgba(0,100,100,0.1));
    }

    #battery,
    #network,
    #clock,
    #tray,
    #workspaces,
    #pulseaudio {
      background-image: linear-gradient(to bottom, rgba(255,255,255,0.25), rgba(0,0,0,0.025));
      box-shadow: 0px 0px 3px rgba(0,0,0,0.34);
      margin: 4px;
      padding: 4px 8px;
      border-radius: 8px;
      color: rgb(220,220,220);

      /* Important style feature in order to give a glassy look! */
      /* I'm using the top and bottom borders to mimic highlights in highly reflective surfaces, looks good with the glassy-look */
      border-style: none;
      border-bottom-style: solid;
      border-top-style: solid;
      border-bottom-color: rgba(255,255,255,0.15);
      border-top-color: rgba(255,255,255,0.45);
      border-width: 1px;
    }

    #tray menu {
      background-color: rgba(255,255,255,0.025);
      color: rgba(220,220,220, 1);
      padding: 4px;
    }
    #tray menu menuitem {
      background-image: linear-gradient(to bottom, rgba(255,255,255,0.15),rgba(0,0,0,0.2),rgba(0,0,0,0.4));
      margin: 3px;
      color: rgb(220,220,220);
      border-radius: 4px;

      border-style: none;
      border-bottom-style: solid;
      border-top-style: solid;
      border-bottom-color: rgba(255,255,255,0.15);
      border-top-color: rgba(255,255,255,0.3);
      border-width: 1px;
    }
    #tray menu menuitem:hover {
      background-image: linear-gradient(to bottom, rgba(0,255,255,0.15), rgba(0,0,0,0.3), rgba(0,255,255,0.15));
      color: @accent_color;
      text-shadow: 0px 0px 6px @accent_color;
      box-shadow: 0px 0px 4px rgba(0,0,0,0.4);
    }

    #workspaces button {
    transition-duration: 100ms;
    all: initial;
    min-width: 0;
    color: rgb(220,220,220);
    margin-right: 0.2cm;
    margin-left: 0.2cm;
    text-shadow: 0px 0px 4px rgb(135,135,135);
    }


    #workspaces button.active {
      color: @accent_color;
      text-shadow: 0px 0px 6px @accent_color;
    }

    #workspaces button:hover {
      transition-duration: 120ms;
      color:@accent_color;
      text-shadow: 0px 0px 8px @accent_color;
    }

    #workspaces button.current_output {
    color: @accent_color;;
    }

    #workspaces button.urgent {
    color: #e78a4e;
    text-shadow: 0px 0px 6px #e78a4e;
    }

    #battery.warning,
    #battery.critical,
    #battery.urgent {
    color: #fcf520;
    }

  '';

  ############################################################
  # OPAQUE PRESET
  ############################################################

  opaqueStyle = ''
    @define-color accent_color #20d0fc;

    * {
      border: none;
      border-radius: 8;
      min-height: 0;
      /* For the taskbar, I prefer simple Noto Sans.*/
      font-family: Noto Sans;
      font-weight: bold;
      font-size: 14px;
      padding: 0px;
      padding-left: 0px;
      padding-right: 0px;
    }

    window#waybar {
      background-image: linear-gradient(to bottom, #ffffff, #bbbbbb);
      border-radius: 12px;
      padding: 0px;
    }

    tooltip {
      background-color: rgb(255,255,255);
      color: rgb(135,135,135);
      text-shadow: 0px 0px 4px rgb(135,135,135);
    }

    #custom-os_btn {
      margin-left: 0.5cm;
    }

    #taskbar {
      margin: 4px 8px;
      margin-left: 0.25cm;
    }
    #taskbar button {
      margin-left: 0.2cm;
      margin-right: 0.2cm;
      padding: 1px;
      border-radius: 4px;
    }
    #taskbar button:hover {
      background-color: rgba(0,0,0,0);
      box-shadow: 0px 0px 5px rgb(135,135,135);
    }
    #taskbar button.active {
      box-shadow: 0px 0px 5px rgb(135,135,135);
    }
    battery
    #battery,
    #network,
    #clock,
    #tray,
    #pulseaudio {
    background-image: linear-gradient(to bottom, #ffffff, #bbbbbb);
    box-shadow: 0px 0px 3px rgb(135,135,135);
    margin: 4px;
    padding: 4px 8px;
    border-radius: 8px;
    color: rgb(90,90,90);
    text-shadow: 0px 0px 4px rgb(135,135,135);
    }

    #tray menu {
      background-color: rgba(255,255,255, 0.5);
      color: rgb(90,90,90);
      text-shadow: 0px 0px 4px rgb(135,135,135);
      padding: 4px;
    }
    #tray menu menuitem {
      background-image: linear-gradient(to bottom, #ffffff, #bbbbbb);
      margin: 4px;
      border-radius: 4px;
      box-shadow: 0px 0px 4px rgba(135,135,135, 0.45);
      color: rgb(90,90,90);
    }
    #tray menu menuitem:hover {
      color: @accent_color;
      text-shadow: 0px 0px 6px @accent_color;
      box-shadow: 0px 0px 6px rgba(135,135,135,1);
    }

    #workspaces {
    background-image: linear-gradient(to bottom, #ffffff, #bbbbbb);
    margin: 4px;
    padding: 4px 8px;
    border-radius: 8px;
    box-shadow: 0px 0px 3px rgb(135,135,135);
    }

    #workspaces button {
    transition-duration: 100ms;
    all: initial;
    min-width: 0;
    color: rgb(90,90,90);
    margin-right: 0.2cm;
    margin-left: 0.2cm;
    text-shadow: 0px 0px 4px rgb(135,135,135);
    }


    #workspaces button.active {
      color: @accent_color;
      text-shadow: 0px 0px 6px @accent_color;
    }

    #workspaces button:hover {
      transition-duration: 120ms;
      color:@accent_color;
      text-shadow: 0px 0px 8px @accent_color;
    }

    #workspaces button.current_output {
    color: @accent_color;;
    }

    #workspaces button.urgent {
    color: #e78a4e;
    text-shadow: 0px 0px 6px #e78a4e;
    }

    #battery.warning,
    #battery.critical,
    #battery.urgent {
    color: #cc1a1a;
    }

  '';

  ############################################################
  # SELECT PRESET
  ############################################################

  selectedStyle =
    if cfg.style.preset == "default"
    then defaultStyle
    else if cfg.style.preset == "translucent"
    then translucentStyle
    else if cfg.style.preset == "opaque"
    then opaqueStyle
    else "";
in {
  programs.waybar = lib.mkIf (cfg.enable && cfg.style.preset != "none") {
    style = selectedStyle;
  };
}
