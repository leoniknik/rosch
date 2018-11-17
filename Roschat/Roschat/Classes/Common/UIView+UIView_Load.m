//
//  UIView+UIView_Load.m
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

#import "UIView+UIView_Load.h"

@implementation UIView (UIView_Load)

+ (instancetype)RX_loadFromNib
{
    Class selfClass = [self class];
    
    NSString *className = NSStringFromClass(selfClass);
    
    NSBundle *bunble = [NSBundle bundleForClass:selfClass];
    
    if (![bunble pathForResource:className ofType:@"nib"]) {
        className = className.pathExtension;
        if (![bunble pathForResource:className ofType:@"nib"]) {
            NSLog(@"test: view not found %@", className);
            return nil;
        }
    }
    
    NSArray *nibContents = [bunble loadNibNamed:className owner:nil options:nil];
    
    id view = nil;
    
    for (id obj in nibContents) {
        if ([obj isKindOfClass:selfClass]) {
            view = obj;
            break;
        }
    }
    
    return view;
}

@end
