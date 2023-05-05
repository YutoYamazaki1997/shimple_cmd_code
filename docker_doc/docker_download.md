# 参考
https://exploratory.io/note/exploratory/Exploratory-Collaboration-Server-Exploratory-Desktop-pUy2myi2DE

sudo usermod -aG docker <USER>

```
docker run -it --privileged --net=host \
   --device /dev/dri \
   -v ~/.Xauthority:/home/dlstreamer/.Xauthority \
   -v /tmp/.X11-unix \
   -e DISPLAY=$DISPLAY \
   -v /dev/bus/usb \
   --rm intel/dlstreamer:devel /bin/bash
```