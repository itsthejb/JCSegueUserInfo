//
//  UIViewController+SegueUserInfo.m
//  JCSegueUserInfo
//
//  Created by Jonathan Crooke on 17/04/2013.
//  Copyright (c) 2013 Jonathan Crooke. All rights reserved.
//

#import "UIViewController+SegueUserInfo.h"
#import "EXTSwizzle.h"
#import "ObjcAssociatedObjectHelpers.h"

static BOOL __segue_swizzled = NO;

@interface UIViewController (SegueUserInfoPrivate)
@property (nonatomic, strong, readonly) NSMutableDictionary *__segueUserInfoDictionary;
- (void)__segue_user_info_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)__segue_user_info_original_prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
@end

@implementation UIViewController (SegueUserInfo)

SYNTHESIZE_ASC_OBJ_LAZY(__segueUserInfoDictionary, NSMutableDictionary)

- (void)performSegueWithIdentifier:(NSString *)identifier
                            sender:(id)sender
                          userInfo:(NSDictionary *)userInfo
{
  if (!__segue_swizzled) {
    EXT_SWIZZLE_INSTANCE_METHODS(UIViewController,
                                 prepareForSegue:sender:,
                                 __segue_user_info_prepareForSegue:sender:,
                                 __segue_user_info_original_prepareForSegue:sender:);
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
  [self __segue_user_info_original_prepareForSegue:segue sender:sender];
}

@end
