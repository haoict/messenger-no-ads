#include "Tweak.h"

/**
 * Load Preferences
 */
BOOL noads;
BOOL disablereadreceipt;
BOOL disabletypingindicator;
BOOL disablestoryseenreceipt;
BOOL cansavefriendsstory;
BOOL hidesearchbar;
BOOL hidestoriesrow;
BOOL hidepeopletab;

static void reloadPrefs() {
  NSDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@PLIST_PATH];

  noads = [[settings objectForKey:@"noads"] ?: @(YES) boolValue];
  disablereadreceipt = [[settings objectForKey:@"disablereadreceipt"] ?: @(YES) boolValue];
  disabletypingindicator = [[settings objectForKey:@"disabletypingindicator"] ?: @(YES) boolValue];
  disablestoryseenreceipt = [[settings objectForKey:@"disablestoryseenreceipt"] ?: @(YES) boolValue];
  cansavefriendsstory = [[settings objectForKey:@"cansavefriendsstory"] ?: @(YES) boolValue];
  hidesearchbar = [[settings objectForKey:@"hidesearchbar"] ?: @(NO) boolValue];
  hidestoriesrow = [[settings objectForKey:@"hidestoriesrow"] ?: @(NO) boolValue];
  hidepeopletab = [[settings objectForKey:@"hidepeopletab"] ?: @(NO) boolValue];
}
static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  reloadPrefs();
}


/**
 * Tweak's hooking code
 */
%group NoAdsNoStoriesRow
  %hook MSGThreadListDataSource
    - (NSArray *)inboxRows {
      NSArray *orig = %orig;
      if (![orig count]) {
        return orig;
      }

      NSMutableArray *resultRows = [@[] mutableCopy];

      if (!(hidestoriesrow && [orig[0][2] isKindOfClass:[NSArray class]] && [orig[0][2][1] isEqual:@"montage_renderer"])) {
        [resultRows addObject:orig[0]];
      }

      for (int i = 1; i < [orig count]; i++) {
        NSArray *row = orig[i];
        if (!noads || (noads && [row[1] intValue] != 2)) {
          [resultRows addObject:row];
        }
      }

      return resultRows;
    }
  %end
%end

%group DisableReadReceipt
  %hook LSMessageListViewController
    - (void)_sendReadReceiptIfNeeded {
      if (!disablereadreceipt) {
        %orig;
      }
    }
  %end
%end

%group DisableTypingIndicator
  %hook LSComposerViewController
    - (void)_updateComposerEventWithTextViewChanged:(id)arg1 {
      if (!disabletypingindicator) {
        %orig;
      }
    }
  %end
%end

%group DisableStorySeenReceipt
  %hook LSStoryBucketViewController
    - (void)startTimer {
      if (!disablestoryseenreceipt) {
        %orig;
      }
    }
  %end
%end

%group CanSaveFriendsStory
  %hook LSAppDelegate
    static LSAppDelegate *__weak sharedInstance;
    - (void)applicationDidBecomeActive:(id)arg1 {
      %orig;
      sharedInstance = self;
    }

    %new
    + (id)sharedInstance {
      return sharedInstance;
    }
  %end

  %hook MBUIStoryViewerAuthorOverlayModel
    - (NSString *)authorId {
      if (cansavefriendsstory) {
        NSString *userId = [[%c(LSAppDelegate) sharedInstance] getCurrentLoggedInUserId];
        return userId;
      }
      return %orig;
    }
  %end
%end

%group HidePeopleTab
  %hook UITabBarController
    - (UITabBar *)tabBar {
      UITabBar *orig = %orig;
      orig.hidden = true;
      return orig;
    }
  %end
%end

%group HideSearchBar
  %hook UINavigationController
    - (void)_createAndAttachSearchPaletteForTransitionToTopViewControllerIfNecesssary:(id)arg1 {
    }
  %end
%end


/**
 * Constructor
 */
%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR(PREF_CHANGED_NOTIF), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
  reloadPrefs();

  dlopen([[[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"Frameworks/NotInCore.framework/NotInCore"] UTF8String], RTLD_NOW);

  %init(NoAdsNoStoriesRow);
  %init(DisableReadReceipt);
  %init(DisableTypingIndicator);
  %init(DisableStorySeenReceipt);
  %init(CanSaveFriendsStory);

  if (hidesearchbar) {
    %init(HideSearchBar);
  }

  if (hidepeopletab) {
    %init(HidePeopleTab);
  }
}

