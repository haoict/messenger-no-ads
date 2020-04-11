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

