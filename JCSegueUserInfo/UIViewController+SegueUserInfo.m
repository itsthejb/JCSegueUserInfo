//
//  UIViewController+SegueUserInfo.m
//  JCSegueUserInfo
//
//  Created by Jonathan Crooke on 17/04/2013.
//  Copyright (c) 2013 Jonathan Crooke. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "UIViewController+SegueUserInfo.h"
#import "ObjcAssociatedObjectHelpers.h"
#import "JRSwizzle.h"

static BOOL __segue_swizzled = NO;

@interface UIViewController (SegueUserInfoPrivate)
@property (nonatomic, strong, readonly) NSMutableDictionary *__segueUserInfoDictionary;
- (void)__segue_user_info_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
@end

@implementation UIViewController (SegueUserInfo)

SYNTHESIZE_ASC_OBJ_LAZY(__segueUserInfoDictionary, NSMutableDictionary)

- (void)performSegueWithIdentifier:(NSString *)identifier
                            sender:(id)sender
                          userInfo:(NSDictionary *)userInfo
{
  if (!__segue_swizzled) {
    NSError *error = nil;
    [UIViewController jr_swizzleMethod:@selector(prepareForSegue:sender:)
                            withMethod:@selector(__segue_user_info_prepareForSegue:sender:)
                                 error:&error];
    NSAssert(!error, error.localizedDescription);
    __segue_swizzled = YES;
  }

  [self.__segueUserInfoDictionary setValue:userInfo forKey:identifier];
  [self performSegueWithIdentifier:identifier sender:sender];
}

- (void)__segue_user_info_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSAssert(__segue_swizzled, @"Not swizzled");
  NSDictionary *userInfo = [self.__segueUserInfoDictionary valueForKey:segue.identifier];
  if (userInfo) {
    [segue.destinationViewController setValuesForKeysWithDictionary:userInfo];
    [self.__segueUserInfoDictionary removeObjectForKey:segue.identifier];
  }
  [self __segue_user_info_prepareForSegue:segue sender:sender];
}

@end
