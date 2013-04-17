//
//  UIViewController+SegueUserInfo.m
//  JCSegueUserInfo
//
//  Created by Jonathan Crooke on 17/04/2013.
//  Copyright (c) 2013 Jonathan Crooke. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+SegueUserInfo.h"

static void *kSegueUserInfoKey = NULL;

@interface UIViewController (SegueUserInfoPrivate)
@property (nonatomic, strong, readonly) NSMutableDictionary *__segueUserInfoDictionary;
@end

@implementation UIViewController (SegueUserInfo)

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender userInfo:(NSDictionary *)userInfo {
  [self.__segueUserInfoDictionary setValue:userInfo forKey:identifier];
  [self performSegueWithIdentifier:identifier sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSDictionary *userInfo = [self.__segueUserInfoDictionary valueForKey:segue.identifier];
  if (userInfo) {
    [segue.destinationViewController setValuesForKeysWithDictionary:userInfo];
  }
}

- (NSMutableDictionary *)__segueUserInfoDictionary {
  return objc_getAssociatedObject(self, kSegueUserInfoKey);
}

@end
