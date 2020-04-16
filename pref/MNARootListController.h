#import <notify.h>
#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

@interface NSTask : NSObject
@property (copy) NSArray *arguments;
@property (copy) NSString *currentDirectoryPath;
@property (copy) NSDictionary *environment;
@property (copy) NSString *launchPath;
@property (readonly) int processIdentifier;
@property (retain) id standardError;
@property (retain) id standardInput;
@property (retain) id standardOutput;
+ (id)currentTaskDictionary;
+ (id)launchedTaskWithDictionary:(id)arg1;
+ (id)launchedTaskWithLaunchPath:(id)arg1 arguments:(id)arg2;
- (id)init;
- (void)interrupt;
- (bool)isRunning;
- (void)launch;
- (bool)resume;
- (bool)suspend;
- (void)terminate;
@end

@interface MNAHeader : UITableViewCell {
  UILabel *label;
  UILabel *underLabel;
}
@end

@interface MNARootListController : PSListController
+ (id)sharedInstance;
@end
