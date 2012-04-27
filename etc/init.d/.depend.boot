TARGETS = mountkernfs.sh udev mountdevsubfs.sh bootlogd keyboard-setup hostname.sh hwclockfirst.sh console-setup urandom mountall.sh mountoverflowtmp networking ifupdown hwclock.sh checkroot.sh mountnfs.sh mountnfs-bootclean.sh ifupdown-clean alsa-utils fuse x11-common kbd checkfs.sh mountall-bootclean.sh procps mtab.sh module-init-tools bootmisc.sh stop-bootlogd-single udev-mtab
INTERACTIVE = udev keyboard-setup console-setup checkroot.sh kbd checkfs.sh
udev: mountkernfs.sh
mountdevsubfs.sh: mountkernfs.sh udev
bootlogd: mountdevsubfs.sh
keyboard-setup: bootlogd mountkernfs.sh udev
hostname.sh: bootlogd
hwclockfirst.sh: bootlogd mountdevsubfs.sh
console-setup: mountall.sh mountoverflowtmp mountnfs.sh mountnfs-bootclean.sh kbd
urandom: mountall.sh mountoverflowtmp
mountall.sh: checkfs.sh
mountoverflowtmp: mountall-bootclean.sh
networking: mountkernfs.sh mountall.sh mountoverflowtmp ifupdown
ifupdown: ifupdown-clean
hwclock.sh: checkroot.sh bootlogd
checkroot.sh: mountdevsubfs.sh hostname.sh hwclockfirst.sh bootlogd keyboard-setup
mountnfs.sh: mountall.sh mountoverflowtmp networking ifupdown
mountnfs-bootclean.sh: mountall.sh mountoverflowtmp mountnfs.sh
ifupdown-clean: checkroot.sh
alsa-utils: mountall.sh mountoverflowtmp mountnfs.sh mountnfs-bootclean.sh udev
fuse: mountall.sh mountoverflowtmp mountnfs.sh mountnfs-bootclean.sh
x11-common: mountall.sh mountoverflowtmp
kbd: mountall.sh mountoverflowtmp mountnfs.sh mountnfs-bootclean.sh
checkfs.sh: checkroot.sh mtab.sh
mountall-bootclean.sh: mountall.sh
procps: bootlogd mountkernfs.sh mountall.sh mountoverflowtmp udev module-init-tools
mtab.sh: checkroot.sh
module-init-tools: checkroot.sh
bootmisc.sh: mountall.sh mountoverflowtmp mountnfs.sh mountnfs-bootclean.sh udev
stop-bootlogd-single: mountall.sh mountoverflowtmp udev keyboard-setup console-setup urandom networking ifupdown mountkernfs.sh hwclock.sh checkroot.sh mountnfs.sh mountnfs-bootclean.sh ifupdown-clean alsa-utils fuse x11-common kbd hostname.sh checkfs.sh mountall-bootclean.sh mountdevsubfs.sh hwclockfirst.sh bootlogd procps mtab.sh module-init-tools bootmisc.sh udev-mtab
udev-mtab: udev mountall.sh mountoverflowtmp
