THEOS_DEVICE_IP = 192.168.1.21

ARCHS = arm64 arm64e
TARGET = iphone::12.0:latest

INSTALL_TARGET_PROCESSES = LightSpeedApp Messenger

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = messengernoads
messengernoads_FILES = Tweak.xm
messengernoads_CFLAGS = -fobjc-arc
messengernoads_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += pref

include $(THEOS_MAKE_PATH)/aggregate.mk

