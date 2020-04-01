@interface MSGThreadListDataSource : NSObject
- (NSArray *)inboxRows;
@end

%hook MSGThreadListDataSource
- (NSArray *)inboxRows {  
  NSMutableArray *orig = [%orig mutableCopy];
  
  // start array from 1 because row 0 is stories row
  // note: [array removeObject:id] won't work, had to use NSMutableIndexSet
  NSMutableIndexSet *adsIndexes = [[NSMutableIndexSet alloc] init];
  for (int i = 1; i < [orig count]; i++) {
    NSArray *row = orig[i];
    NSNumber *type = row[1];
    if ([type intValue] == 2) {
      [adsIndexes addIndex:i];
    }
  }

  [orig removeObjectsAtIndexes:adsIndexes];

  return orig;
}
%end

