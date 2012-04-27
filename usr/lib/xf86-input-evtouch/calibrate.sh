#!/bin/bash
XINIT=`which xinit`
XSERVER=`which X`
EVCALIBRATE=`which ev_calibrate || echo ./ev_calibrate`
UDI=$(hal-find-by-property --key input.x11_driver --string evtouch)
MYDPY=":1.0"
ZENITY=`which zenity`
KDIALOG=`which kdialog`
XDIALOG=`which Xdialog`

INFO="You have selected to (re)calibrate your touchscreen.\n\n\
Move your pen around all edges on the following screen.\n\n\
If you are done and touched all edges, hit the enter key and wait until \
the top left crosshair turns red.\nOnce you tap the red crosshair, \
the next one will turn red going from the top left to the \
bottom right.\nIf you miss a tap, the right mouse button will \
take you back one step.\n\n\
If you tapped the last (bottom right) crosshair, the program will \
return to your session. Note that changes only take effect after \
restarting the session."

RESTARTINFO="Touchscreen calibration done\nPlease restart your \
session to \nmake the changes take effect"

FAILINFO="No evtouch capable device found, if you are sure you have \n\
an evtouch capable touchscreen, please mail the \
resulting file of the command \"lshal > evtouch_hal.out\" to the\n\
ubuntu-mobile@lists.ubuntu.com mailing list, so support for your \
device can be added."

if [ -z "$UDI" ];then
    if [ -x "${ZENITY}" ]; then
        $ZENITY --info --text="${FAILINFO}"
    elif [ -x "${XDIALOG}" ]; then
        $XDIALOG --fill --msgbox "${FAILINFO}" 20 40
    elif [ -x "${KDIALOG}" ]; then
        $KDIALOG --msgbox "${FAILINFO}"
    fi
    exit 0
fi

if [ -x "${ZENITY}" ]; then
    $ZENITY --info --text="${INFO}"
elif [ -x "${XDIALOG}" ]; then
    $XDIALOG --fill --msgbox "${INFO}" 30 40
elif [ -x "${KDIALOG}" ]; then
    $KDIALOG --msgbox "${INFO}"
fi

echo $EVCALIBRATE

if [ -n "$DISPLAY" ]; then
    DPY=$(echo $DISPLAY|sed -e 's/[a-z:]*//g'|cut -d'.' -f1)
    MYDPY=":$(($DPY+1)).0"
fi

if ! [ -x "$EVCALIBRATE" ] ; then
	echo "ev_calibrate not found exiting ..."
	exit 1;
fi
echo "evalibrate located at $EVCALIBRATE"

if [ -z "$XINIT" ]; then
    echo "xinit not found exiting ..."
    exit 1;
fi
echo "xinit located at $XINIT"
if [ -z "$XSERVER" ]; then
    echo "X not found exiting ..."
    exit 1;
fi
echo "xserver located at $XSERVER"
if [ -e /tmp/ev_calibrate ]; then
	rm /tmp/ev_calibrate;
fi
echo "Creating FIFO..."
mknod /tmp/ev_calibrate p

#for development only :)
#cp evtouch_drv.o /usr/X11R6/lib/modules/input
#xinit /usr/bin/ddd ev_calibrate -- /usr/X11R6/bin/X
echo "Starting calibration program..."
sleep 2
hal-set-property --udi $UDI --key input.x11_options.calibrate --string "1"

$XINIT $EVCALIBRATE -- $XSERVER $MYDPY -auth /dev/null

hal-set-property --remove --udi $UDI --key input.x11_options.calibrate

invoke-rc.d --quiet xserver-xorg-input-evtouch start

rm /tmp/ev_calibrate

if [ -x "${ZENITY}" ]; then
    $ZENITY --info --text="${RESTARTINFO}"
elif [ -x "${XDIALOG}" ]; then
    $XDIALOG --fill --msgbox "${RESTARTINFO}" 10 40
elif [ -x "${KDIALOG}" ]; then
    $KDIALOG --msgbox "${RESTARTINFO}"
fi

exit 0
