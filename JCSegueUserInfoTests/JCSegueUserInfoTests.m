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

@interface TestViewController : UIViewController
@property (nonatomic, strong) id testProperty1;
@property (nonatomic, strong) id testProperty2;
@end
@implementation TestViewController
@end

#pragma mark -

@interface JCSegueUserInfoTests : SenTestCase
@property (strong) UIStoryboard *storyboard;
@property (strong) UIViewController *initialViewController;
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

  TestViewController *testVc = (id) self.initialViewController.presentedViewController;

  STAssertNotNil(testVc, @"Didn't instantiate test view controller");
  STAssertTrue([testVc isKindOfClass:[TestViewController class]], @"Didn't instantiate test view controller");
}

#pragma mark -

- (void)setUp
{
  [super setUp];

  self.storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:[NSBundle bundleForClass:[self class]]];
  STAssertNotNil(self.storyboard, @"Couldn't load storyboard");

  self.initialViewController = [self.storyboard instantiateInitialViewController];
  STAssertNotNil(self.storyboard, @"Couldn't instantiate initial view controller");
}

- (void)tearDown
{
  self.storyboard = nil;
  self.initialViewController = nil;
  [super tearDown];
}

@end
