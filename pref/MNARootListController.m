#include "MNARootListController.h"

#define TWEAK_TITLE "Messenger No Ads"
#define TINT_COLOR "#00a2e8"
#define BUNDLE_NAME "MNAPref"

@implementation MNARootListController
- (id)init {
  self = [super init];
  if (self) {
    self.tintColorHex = @TINT_COLOR;
    self.bundlePath = [NSString stringWithFormat:@"/Library/PreferenceBundles/%@.bundle", @BUNDLE_NAME];
  }
  return self;
}

@end
