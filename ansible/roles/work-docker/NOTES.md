https://forum.proxmox.com/threads/openvpn-in-unprivileged-container.38670/post-222147


I have this working (OpenVPN, unprivileged) with only:

Code:

lxc.mount.entry = /dev/net dev/net none bind,create=dir


in:

Code:

/etc/pve/lxc/102.conf


From inside the container, I see:

Code:

# ls -l /dev/net/
total 0
crw-rw-rw- 1 nobody nogroup 10, 200 Sep 13 02:14 tun

