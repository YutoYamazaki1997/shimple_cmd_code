import os
os.add_dll_directory(r'C:\gstreamer\1.0\msvc_x86_64\bin')
import cv2  # nopep
import time
gst_str = 'udpsrc port=100 caps = "application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264, payload=(int)96" ! rtph264depay ! decodebin ! videoconvert ! appsink'
cap = cv2.VideoCapture(gst_str, cv2.CAP_GSTREAMER)

cap.isOpened()
while True:
    ret, img = cap.read()
    if not ret:
        break
    cv2.imshow("img",img)
    ## ブレーク処理
    key = cv2.waitKey(1)
    if key==27: #[esc] key
        break
cap.release()
