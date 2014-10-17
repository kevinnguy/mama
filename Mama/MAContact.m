//
//  MAContact.m
//  Mama
//
//  Created by Kevin Nguy on 8/14/14.
//  Copyright (c) 2014 Kevin Nguy. All rights reserved.
//

#import "MAContact.h"

@implementation MAContact

- (instancetype)init
{
    return [self initWithFirstName:nil lastName:nil];
}

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName
{
    self = [super init];
    if (self) {
        self.firstName = firstName;
        self.lastName = lastName;
    }
    
    return self;
}

@end
