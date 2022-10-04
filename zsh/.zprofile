if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  set MOZ_ENABLE_WAYLAND = 1
  exec sway
fi
