#import <Foundation/Foundation.h>

// @interface MBUIStoryViewerStoryIdentifierModel : NSObject;
// @property(readonly, nonatomic) BOOL isExpired;
// @property(readonly, nonatomic) int bucketType;
// @property(readonly, nonatomic) int storyType;
// @property(readonly, copy, nonatomic) NSString *authorFirstName;
// @end

%group NotInCore

%hook MSGStoryAdViewController 
- (BOOL)isReadyToPlay {
  NSLog(@"haoo---");
  return 0;
}
%end

%end

%group LSCore

%hook MSGThreadListDataSource
- (NSArray *)inboxRows {
  NSArray *orig = %orig;
  NSMutableArray *rowsNoAds = [@[] mutableCopy];

  // add orig's row 0 because it is stories row
  // TODO: make preferences to have an option to remove stories row (some people want it)
  [rowsNoAds addObject:orig[0]];

  for (int i = 1; i < [orig count]; i++) {
    NSArray *row = orig[i];
    if ([row[1] intValue] != 2) {
      [rowsNoAds addObject:row];
    }
  }

  return rowsNoAds;
}
%end

// %hook MBUIStoryViewerStoryIdentifierModel
// - (int)storyType {
//   int orig = %orig;
//   @try {
//     NSLog(@"hao--%d%@", orig, self.authorFirstName);
//   }
//   @catch (NSException *e) {
//   }
  
//   return orig;
// }

// - (BOOL) isExpired {
//   return true;
// }
// %end

// %hook LSStoryBucketViewController
// %end

%hook LSMessageListViewController
- (void)_sendReadReceiptIfNeeded {
  return;
}
%end

// %hook MBUIInboxModel
// - (BOOL)isTyping {
//   return 0;
// }
// %end

// %hook MSGInboxRowAdapter
// - (BOOL)isTyping {
//   return 0;
// }
// %end

// %hook MSGThreadRowCell
// - (void)_initTypingIndicatorIfNeeded {
//   return;
// }
// %end

// %hook MSGMessageRowCell
// - (void)_initTypingIndicatorViewIfNeeded {
//   return;
// }
// %end

%end

%ctor {
  %init(LSCore);
  dlopen([[[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"Frameworks/NotInCore.framework/NotInCore"] UTF8String], RTLD_NOW);
  %init(NotInCore);
}

