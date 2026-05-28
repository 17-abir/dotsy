### for key chain issue of vscode in hyprland:
```bash
sudo pacman -S gnome-keyring libsecret seahorse
```
```bash
sudo nano /etc/pam.d/login
sudo nano /etc/pam.d/sddm   # or lightdm depending on your login manager
```
add these lines in the bottom of both files:
```
auth       optional     pam_gnome_keyring.so
session    optional     pam_gnome_keyring.so auto_start
```
