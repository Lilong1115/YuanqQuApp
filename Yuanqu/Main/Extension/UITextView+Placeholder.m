//
//  UITextView+Placeholder.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/1.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "UITextView+Placeholder.h"

@implementation UITextView (Placeholder)

+ (UITextView *)creatTextViewWithPlaceholder:(NSString *)placeholder {
    
    UITextView *textView = [[UITextView alloc]init];
    
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeholder;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    placeHolderLabel.alpha = 0.7;
    [placeHolderLabel sizeToFit];
    [textView addSubview:placeHolderLabel];
    
    // same font
    textView.font = [UIFont systemFontOfSize:17];
    placeHolderLabel.font = textView.font;
    [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    return textView;
}

@end
