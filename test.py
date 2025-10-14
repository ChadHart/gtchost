import cv2

# vid = cv2.VideoCapture('/dev/v4l/by-id/usb-MACROSILICON_USB_Video-video-index0', cv2.CAP_V4L2)
vid = cv2.VideoCapture('/dev/v4l/by-id/usb-1', cv2.CAP_V4L2)

vid.set(cv2.CAP_PROP_FRAME_WIDTH, 1920)
vid.set(cv2.CAP_PROP_FRAME_HEIGHT, 1080)
vid.set(cv2.CAP_PROP_FPS, 30)


ret, frame = vid.read()
print(ret)
print(frame.shape)


cv2.imwrite('yes.jpg', frame)

