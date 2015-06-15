//
//  WGGlobalFunctions.m
//  VirtualAgents-test
//
//  Created by saqib on 2/4/15.
//  Copyright (c) 2015 Muhammad Saqib Yaqeen. All rights reserved.
//

#import "WGGlobalFunctions.h"

@implementation WGGlobalFunctions
+(UIView *)GlobalMakeDropDownMenu{
    UIView *DropDownMenu=[[UIView alloc] initWithFrame:CGRectMake(716, 112, 200, 100)];
    DropDownMenu.backgroundColor=[WGViewController colorFromHexString:@"#DFDFDF" ];
    [[DropDownMenu layer] setBorderWidth:1.0f];
    [[DropDownMenu layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    UIButton *Button1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    [Button1 setTitle:@"Delete Lead" forState:UIControlStateNormal];
    [Button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Button1.titleLabel setTextAlignment: NSTextAlignmentCenter];
    [Button1 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [Button1 setBackgroundColor:[UIColor clearColor]];
    [Button1 setTag:1];
    [DropDownMenu addSubview:Button1];
    UIButton *Button2=[[UIButton alloc]initWithFrame:CGRectMake(0, 50, 200, 50)];
    [Button2 setTitle:@"Duplicate" forState:UIControlStateNormal];
    [Button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Button2.titleLabel setTextAlignment: NSTextAlignmentCenter];
    [Button2 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [Button2 setBackgroundColor:[UIColor clearColor]];
    [Button2 setTag:2];

    [DropDownMenu addSubview:Button2];
    
    return DropDownMenu;
    
    
}
+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
