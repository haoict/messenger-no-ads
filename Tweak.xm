#import <Foundation/Foundation.h>
#import <Cephei/HBPreferences.h>

// Option Switches
BOOL noads = YES;
BOOL removestoriesrow = YES;
BOOL disablereadreceipt = YES;

%group LSCore

%hook MSGThreadListDataSource
- (NSArray *)inboxRows {
  NSArray *orig = %orig;
  NSMutableArray *resultRows = [@[] mutableCopy];

  // add orig's row 0 because it is stories row
  // TODO: make preferences to have an option to remove stories row (some people want it)
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

%hook LSMessageListViewController
- (void)_sendReadReceiptIfNeeded {
  if (!disablereadreceipt) {
    %orig;
  }
  return;
}
%end

%end

%ctor {
  HBPreferences *pfs = [[HBPreferences alloc] initWithIdentifier:@"com.haoict.messengernoadspref"];
  [pfs registerBool:&noads default:YES forKey:@"noads"];
  [pfs registerBool:&removestoriesrow default:YES forKey:@"removestoriesrow"];
  [pfs registerBool:&disablereadreceipt default:YES forKey:@"disablereadreceipt"];

  %init(LSCore);
}

