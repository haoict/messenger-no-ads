ARCHS = arm64 arm64e
TARGET = iphone:clang:12.2:12.0

INSTALL_TARGET_PROCESSES = LightSpeedApp Messenger

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MessengerNoAds
MessengerNoAds_FILES = Tweak.xm $(wildcard settingsview/*.xm settingsview/*.m)
MessengerNoAds_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/Application\ Support/MessengerNoAds.bundle/$(ECHO_END)
	$(ECHO_NOTHING)cp -a settingsview/Resources/. $(THEOS_STAGING_DIR)/Library/Application\ Support/MessengerNoAds.bundle/$(ECHO_END)
