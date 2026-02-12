# NixOs-Vista
A nostalgic Windows Vista-inspired NixOS setup

```txt
# ========
# Credit goes alot to diinki 
# Inspiration: https://github.com/diinki/diinki-aero/
# ========
```

# to run it just run 

nix run github:Peritia-System/NixOS-Vista#vm


# For configuring use: 

```txt

i have to still do this 
maybe check ./showcaseVM/nixosVista.nix
```




# The Default Keybinds 
You can edit the keybinds in the hyprland config file as needed to match your preference, by default the most important ones:

MOD is the super key/windows key by default in this config.
MOD + Enter = opens terminal (by default, kitty, you need to have it installed or edit the config file).
MOD + F = Toggle maximize of a window
MOD + D = Open the Wofi application launcher
MOD + E = open the file explorer (you need caja, or edit the config file)
MOD + SHIFT + SPACE = Toggle a window from tiling to floating.
MOD + mouse1 drag = Move a window
MOD + mouse2 drag = Resize a window
MOD + Q = Exit/Close an application
MOD + SHIFT + (number, 1 to 9) = Move the window to a workspace with that ID.
MOD + Arrow Keys to switch focus 

