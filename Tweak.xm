#import <Foundation/Foundation.h>
#include "Tweak.h"

/**
 * Preferences Bundle
 */
BOOL noads = YES;
BOOL removestoriesrow = YES;
BOOL disablereadreceipt = YES;
BOOL disabletypingindicator = YES;
BOOL disablepeopletab = YES;

static void reloadPrefs() {
  NSDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.haoict.messengernoadspref.plist"];

  noads = [[settings objectForKey:@"noads"] boolValue];
  removestoriesrow = [[settings objectForKey:@"removestoriesrow"] boolValue];
  disablereadreceipt = [[settings objectForKey:@"disablereadreceipt"] boolValue];
  disabletypingindicator = [[settings objectForKey:@"disabletypingindicator"] boolValue];
  disablepeopletab = [[settings objectForKey:@"disablepeopletab"] boolValue];
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
      NSMutableArray *resultRows = [@[] mutableCopy];

      if (!removestoriesrow) {
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
      return;
    }
  %end
%end

%group DisableTypingIndicator
  %hook LSTextView
    - (void)updateTextViewForTextChangedAnimated:(BOOL)arg1 {
      [self updateSizeAnimated:arg1];
      self.collapsed = false;
      if (![self hasText] || [self.text length] == 1) {
        [[%c(LSComposerViewController) sharedInstance] updateComposerBarState];
      }

      UILabel *placeholderLabel = MSHookIvar<UILabel *>(self, "_placeholderLabel");
      if ([self hasText]) {
        [[%c(LSComposerViewController) sharedInstance] setTextChangedSinceTextViewCollapsed:true];
        placeholderLabel.text  = @"";
      } else {
        placeholderLabel.text  = @"Aa";
      }
    }
  %end

  %hook LSComposerViewController
    static LSComposerViewController *__weak sharedInstance;

    - (id)initWithMailbox:(id)arg1 mediaManager:(id)arg2 generatedImageManager:(id)arg3 audioSessionManager:(id)arg4 backgroundTaskManager:(id)arg5 composerTheme:(id)arg6 composerConfiguration:(id)arg7 threadViewContextUniqueIdentifier:(id)arg8 textInputContextIdentifier:(id)arg9 composerState:(id)arg10 composerExtendedSendBlock:(id)arg11 {
      id original = %orig;
      sharedInstance = original;
      return original;
    }

    %new
    + (id)sharedInstance {
      return sharedInstance;
    }
  %end
%end

%group DisablePeopleTab
  %hook UITabBarController
    - (UITabBar *)tabBar {
      UITabBar *orig = %orig;
      orig.hidden = true;
      return orig;
    }
  %end
%end


// %group Story
//   %hook MBUIStoryViewerBucketModel 
//     - (BOOL) hasUnread {
//       return true;
//     }
//   %end

//   %hook LSMediaViewController
//     - (BOOL)canSaveMedia {
//       return true;
//     }
//   %end

//   %hook LSMediaPhotoViewController
//     - (BOOL)canSaveMedia {
//       return true;
//     }
//   %end

//   %hook LSMediaVideoViewController
//     - (BOOL)canSaveMedia {
//       return true;
//     }
//   %end

//   %hook LSStoryBucketViewController
//     // - (void)_configureSeenHeads {
//     //   return;
//     // }
//   %end

//   %hook MBUIStoryViewerStoryIdentifierModel
//     - (BOOL)isRead {
//       return false;
//     }
//   %end

//   %hook LSThreadMediaViewerBucketViewController
//     - (id) threadMediaViewerBucketLoggingInfo {
//       return nil;
//     }

//     - (BOOL) isPlaying {
//       return false;
//     }
//   %end
// %end

/**
 * Constructor
 */
%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR("com.haoict.messengernoadspref/ReloadPrefs"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
  reloadPrefs();

  %init(NoAdsNoStoriesRow);

  if (disablereadreceipt) {
    %init(DisableReadReceipt);
  }

  if (disabletypingindicator) {
    %init(DisableTypingIndicator);
  }

  if (disablepeopletab) {
    %init(DisablePeopleTab);
  }

  // not working yet
  // %init(Story);
}

