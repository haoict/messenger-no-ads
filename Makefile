ARCHS = arm64 arm64e
TARGET = iphone:clang:12.2:12.0

INSTALL_TARGET_PROCESSES = LightSpeedApp Messenger

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = messengernoads
messengernoads_FILES = Tweak.xm
messengernoads_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += pref ccmodule

include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"
