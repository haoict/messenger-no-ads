ARCHS = arm64 arm64e
TARGET = iphone::12.0:latest

INSTALL_TARGET_PROCESSES = LightSpeedApp Messenger

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = messengernoads
messengernoads_FILES = Tweak.xm
messengernoads_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

