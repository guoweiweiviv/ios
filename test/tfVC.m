
#import <UIKit/UIKit.h>
#import "tfVC.h"

@interface tfVC ()
@end

@implementation tfVC
-(id) init
{
  self = [super init];
  self.restorationClass = [self class];
  self.restorationIdentifier = NSStringFromClass([self class]);
  return self;
}

-(void) viewDidLoad
{
  [super viewDidLoad];

  
  UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
  [tf setBackgroundColor:[UIColor greenColor]];
  tf.tag = 1999;
  [self.view addSubview:tf];
}

// encodeRestorableStateWithCoder is called when the app is suspended to the background
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
  NSLog(@"Child2ViewController: encodeRestorableStateWithCoder");
  
  UITextField *tf = [self.view viewWithTag:1999];
  
  [coder encodeObject:tf.text forKey:@"txt"];
  [super encodeRestorableStateWithCoder:coder];
}

// decodeRestorableStateWithCoder is called when the app is re-launched
- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
  // important: don't affect our views just yet, we might be not visible or we aren't the current
  // view controller, save off our ivars and restore our text view in viewWillAppear
  //
  NSLog(@"Child2ViewController: decodeRestorableStateWithCoder");
   UITextField *tf = [self.view viewWithTag:1999];
  tf.text = [coder decodeObjectForKey:@"txt"];
  [super decodeRestorableStateWithCoder:coder];
}


@end
