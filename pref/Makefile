ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = MNAPref
MNAPref_FILES = $(wildcard *.m)
MNAPref_INSTALL_PATH = /Library/PreferenceBundles
MNAPref_FRAMEWORKS = UIKit
MNAPref_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/MNAPref.plist$(ECHO_END)
