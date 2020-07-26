#import "MNAIntroViewController.h"

@implementation MNAIntroViewController
- (id)init {
  self = [super init];
  if (self) {
    self->_supportedInterfaceOrientations = UIInterfaceOrientationMaskPortrait;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  CAGradientLayer* gradient = [[CAGradientLayer alloc] init];
  [gradient setFrame: [[self view] bounds]];
  [gradient setStartPoint:CGPointMake(0.0, -0.5)];
  [gradient setEndPoint:CGPointMake(1.0, 1.0)];
  [gradient setColors:@[(id)[[HCommon colorFromHex:@KTINT_COLOR] CGColor], (id)[[UIColor whiteColor] CGColor]]];
  [gradient setLocations:@[@0,@1]];

  [[[self view] layer] insertSublayer:gradient atIndex:0];

  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 50, 100, 100)];
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  UIImage *introImg1 = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", @PREF_BUNDLE_PATH, @"intro-image-1.png"]];
  UIImage *introImg2 = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", @PREF_BUNDLE_PATH, @"intro-image-2.png"]];
  imageView.animationImages = @[introImg1, introImg2];
  imageView.animationDuration = 0.8;
  [imageView startAnimating];

  UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 60.0f, 120)];
  CGPoint center = self.view.center;
  center.y = center.y - 60 - 50;
  [headerLabel setCenter:center];
  headerLabel.textColor = [UIColor whiteColor];
  headerLabel.text = [MNAUtil localizedItem:@"WELCOME_TO_MESSENGER_NO_ADS"];
  headerLabel.numberOfLines = 2;
  headerLabel.clipsToBounds = YES;
  headerLabel.textAlignment = NSTextAlignmentCenter;
  headerLabel.font = [UIFont fontWithName: @"HelveticaNeue-Bold" size:40];
  headerLabel.adjustsFontSizeToFitWidth = YES;
  headerLabel.minimumScaleFactor = 0.5;

  UILabel* introductionText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 60.0f, 60)];
  [introductionText setCenter:self.view.center];
  introductionText.textColor = [UIColor whiteColor];
  introductionText.text = [MNAUtil localizedItem:@"INTRO_TEXT_GUIDE"];
  introductionText.numberOfLines = 2;
  introductionText.clipsToBounds = YES;
  introductionText.textAlignment = NSTextAlignmentCenter;
  introductionText.font = [UIFont fontWithName: @"HelveticaNeue-Regular" size:27];
  introductionText.adjustsFontSizeToFitWidth = YES;
  introductionText.minimumScaleFactor = 0.5;

  UIButton *continueButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x - 125, self.view.frame.size.height * 4 / 5 - 50, 250.0f, 50.0f)];
  [continueButton addTarget:self action:@selector(dismissIntroductionViewController) forControlEvents:UIControlEventTouchUpInside];
  [continueButton setTitle:[MNAUtil localizedItem:@"CONFIRM"] forState:UIControlStateNormal];
  continueButton.backgroundColor = [HCommon colorFromHex:@"#FE2E54"];
  continueButton.titleLabel.font = [UIFont systemFontOfSize: 17];
  continueButton.layer.cornerRadius = 10;
  [continueButton setTintColor: [UIColor blackColor]];

  UIActivityIndicatorView *loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50.0f, 50.0f)];
  CGPoint center2 = self.view.center;
  center2.y = self.view.frame.size.height / 1.5;
  [loadingIndicator setCenter:center2];
  [loadingIndicator setColor: [UIColor blackColor]];
  loadingIndicator.alpha = 0.0;

  [self.view addSubview: imageView];
  [self.view addSubview: headerLabel];
  [self.view addSubview: introductionText];
  [self.view addSubview: continueButton];
  [self.view addSubview: loadingIndicator];
}

- (void)dismissIntroductionViewController {
  [self dismissViewControllerAnimated:YES completion:nil];

  NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@PLIST_FILENAME];
  NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] ?: [@{} mutableCopy];
  // flag completed introduction
  [settings setObject:[NSNumber numberWithBool:TRUE] forKey:@"hasCompletedIntroduction"];
  BOOL success = [settings writeToFile:plistPath atomically:YES];

  if (!success) {
    [HCommon showAlertMessage:@"Can't write file" withTitle:@"Error" viewController:nil];
  } else {
    notify_post(PREF_CHANGED_NOTIF);
  }
}
@end