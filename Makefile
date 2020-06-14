ARCHS = arm64 arm64e
TARGET = iphone:clang:12.2:10.0

INSTALL_TARGET_PROCESSES = LightSpeedApp Messenger Preferences

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MessengerNoAds
MessengerNoAds_FILES = $(wildcard *.xm *.m settingsview/*.xm settingsview/*.m)
MessengerNoAds_EXTRA_FRAMEWORKS = libhdev
MessengerNoAds_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += pref

include $(THEOS_MAKE_PATH)/aggregate.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/Application\ Support/MessengerNoAds.bundle/$(ECHO_END)
	$(ECHO_NOTHING)cp -a settingsview/Resources/. $(THEOS_STAGING_DIR)/Library/Application\ Support/MessengerNoAds.bundle/$(ECHO_END)
