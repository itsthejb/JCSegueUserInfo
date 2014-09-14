//
//  JCSegueUserInfoTests.m
//  JCSegueUserInfoTests
//
//  Created by Jonathan Crooke on 17/04/2013.
//  Copyright (c) 2013 Jonathan Crooke. All rights reserved.
//

@import XCTest;
#import <UIKit/UIKit.h>
#import "UIViewController+SegueUserInfo.h"

@interface TestViewController : UIViewController
@property (nonatomic, strong) id testProperty1;
@property (nonatomic, strong) id testProperty2;
@end
@implementation TestViewController
@end

#pragma mark -

@interface JCSegueUserInfoTests : XCTestCase
@property (strong) UIStoryboard *storyboard;
@property (strong) UINavigationController *navController;
@property (strong) UITableViewController *initialViewController;
@end

@implementation JCSegueUserInfoTests

- (void)testCustomViewController
{
  id testVc = [self.storyboard instantiateViewControllerWithIdentifier:@"TestViewController"];
  XCTAssertTrue([testVc isKindOfClass:[TestViewController class]], @"Couldn't instantiate test view controller");
}

- (void)testSetSomeValuesAndKeys
{
  NSString *property1 = @"foo";
  NSString *property2 = @"bar";

  [self.initialViewController jc_performSegueWithIdentifier:@"TestSegue1"
                                                     sender:self
                                                   userInfo:@{ @"testProperty1" : property1,
                                                               @"testProperty2" : property2 }];

  TestViewController *testVc = (id) self.navController.topViewController;
  XCTAssertNotNil(testVc, @"");
  XCTAssertEqual(testVc.class, [TestViewController class], @"");

  // values
  XCTAssertEqual(testVc.testProperty1, property1, @"");
  XCTAssertEqual(testVc.testProperty2, property2, @"");
}

- (void)testNormalMethod
{
  [self.initialViewController performSegueWithIdentifier:@"TestSegue1" sender:self];

  TestViewController *testVc = (id) self.navController.topViewController;
  XCTAssertNotNil(testVc, @"");
  XCTAssertEqual(testVc.class, [TestViewController class], @"");

  // values
  XCTAssertNil(testVc.testProperty1, @"");
  XCTAssertNil(testVc.testProperty2, @"");
}

- (void)testExplicitSetters
{
  NSString *property1 = @"foo";
  NSString *property2 = @"bar";

  [self.initialViewController jc_setUserInfo:@{ @"testProperty1" : property1,
                                                @"testProperty2" : property2 }
                      forSegueWithIdentifier: @"TestSegue1"];

  [self.initialViewController performSegueWithIdentifier:@"TestSegue1"
                                                  sender:nil];

  TestViewController *testVc = (id) self.navController.topViewController;
  XCTAssertNotNil(testVc, @"");
  XCTAssertEqual(testVc.class, [TestViewController class], @"");

  // values
  XCTAssertEqual(testVc.testProperty1, property1, @"");
  XCTAssertEqual(testVc.testProperty2, property2, @"");

  // remove values
  [self.initialViewController jc_removeUserForSegueWithIdentifier:@"TestSegue1"];
  [self.initialViewController performSegueWithIdentifier:@"TestSegue1"
                                                  sender:nil];

  testVc = (id) self.navController.topViewController;
  XCTAssertNotNil(testVc, @"");
  XCTAssertEqual(testVc.class, [TestViewController class], @"");

  // values
  XCTAssertNil(testVc.testProperty1, @"");
  XCTAssertNil(testVc.testProperty2, @"");
}

#pragma mark -

- (void)setUp
{
  [super setUp];

  self.storyboard = [UIStoryboard storyboardWithName:@"Storyboard"
                                              bundle:[NSBundle bundleForClass:[self class]]];
  XCTAssertNotNil(self.storyboard, @"");

  self.navController = [self.storyboard instantiateInitialViewController];
  XCTAssertNotNil(self.navController, @"");
  XCTAssertEqual(self.navController.class, [UINavigationController class], @"");

  self.initialViewController = (id) self.navController.topViewController;
  XCTAssertNotNil(self.initialViewController, @"");
  XCTAssertEqual(self.initialViewController.class, [UITableViewController class], @"");
}

- (void)tearDown
{
  self.storyboard = nil;
  self.initialViewController = nil;
  [super tearDown];
}

@end
