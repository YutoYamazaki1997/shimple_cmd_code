@echo off
cd gstreamer/bin
set "parent_path=%CD%"
echo %parent_path%
set GSTREAMER_1_0_ROOT_X86_64=%parent_path%
set PATH=%parent_path%
gst-launch-1.0 --version
gst-launch-1.0 filesrc location=../../input.mp4 ! decodebin ! videoconvert ! videorate! video/x-raw,framerate=10/1 ! videoscale ! video/x-raw,width=1800,height=1200 ! videoconvert ! x264enc bitrate=100 ! mp4mux ! filesink location=../../output.mp4
pause