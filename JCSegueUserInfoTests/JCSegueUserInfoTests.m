//
//  JCSegueUserInfoTests.m
//  JCSegueUserInfoTests
//
//  Created by Jonathan Crooke on 17/04/2013.
//  Copyright (c) 2013 Jonathan Crooke. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "UIViewController+SegueUserInfo.h"
#import "TestPilot.h"

@interface TestViewController : UIViewController
@property (nonatomic, strong) id testProperty1;
@property (nonatomic, strong) id testProperty2;
@end
@implementation TestViewController
@end

#pragma mark -

@interface JCSegueUserInfoTests : SenTestCase
@property (strong) UIStoryboard *storyboard;
@property (strong) UINavigationController *navController;
@property (strong) UITableViewController *initialViewController;
@end

@implementation JCSegueUserInfoTests

- (void)testCustomViewController
{
  id testVc = [self.storyboard instantiateViewControllerWithIdentifier:@"TestViewController"];
  STAssertTrue([testVc isKindOfClass:[TestViewController class]], @"Couldn't instantiate test view controller");
}

- (void)testSetSomeValuesAndKeys
{
  NSString *property1 = @"foo";
  NSString *property2 = @"bar";

  [self.initialViewController performSegueWithIdentifier:@"TestSegue1"
                                                  sender:self
                                                userInfo:@{ @"testProperty1" : property1, @"testProperty2" : property2 }];

  TestViewController *testVc = (id) self.navController.topViewController;
  assertNotNil(testVc);
  assertThat(testVc, instanceOf([TestViewController class]));

  // values
  assertThat(testVc.testProperty1, equalTo(property1));
  assertThat(testVc.testProperty2, equalTo(property2));
}

- (void)testNormalMethod
{
  [self.initialViewController performSegueWithIdentifier:@"TestSegue1" sender:self];

  TestViewController *testVc = (id) self.navController.topViewController;
  assertNotNil(testVc);
  assertThat(testVc, instanceOf([TestViewController class]));

  // values
  assertThat(testVc.testProperty1, nilValue());
  assertThat(testVc.testProperty2, nilValue());
}

#pragma mark -

- (void)setUp
{
  [super setUp];

  self.storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:[NSBundle bundleForClass:[self class]]];
  assertNotNil(self.storyboard);

  self.navController = [self.storyboard instantiateInitialViewController];
  assertNotNil(self.navController);
  assertThat(self.navController, instanceOf([UINavigationController class]));

  self.initialViewController = (id) self.navController.topViewController;
  assertNotNil(self.initialViewController);
  assertThat(self.initialViewController, instanceOf([UITableViewController class]));
}

- (void)tearDown
{
  self.storyboard = nil;
  self.initialViewController = nil;
  [super tearDown];
}

@end
