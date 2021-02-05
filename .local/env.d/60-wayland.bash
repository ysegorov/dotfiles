#export LIBVA_DRIVER_NAME=iHD
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
# export QT_QPA_PLATFORM=wayland-egl
export WLR_DRM_NO_MODIFIERS=1

export CLUTTER_BACKEND=wayland
export ECORE_EVAS_ENGINE=wayland
export ELM_ENGINE=wayland
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export NO_AT_BRIDGE=1

# vim:ft=sh:
