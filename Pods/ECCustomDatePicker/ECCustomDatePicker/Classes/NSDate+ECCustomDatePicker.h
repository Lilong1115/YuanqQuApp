//
//  NSDate+ECCustomDatePicker.h
//  Pods
//
//  Created by Microseer on 2016/10/19.
//
//

#import <Foundation/Foundation.h>

extern NSString *const kDateFormatYYYYMMDD;
extern NSString *const kDateFormatYYMMDDTHHmmss;

@interface NSDate (ECCustomDatePicker)

+ (NSDateFormatter *)shareDateFormatter;

- (NSInteger)daysBetween:(NSDate *)aDate;

- (NSDate *)dateByAddingDays:(NSInteger)days;

- (NSString *)stringForFormat:(NSString *)format;

@end

@interface NSCalendar (AT)

+ (instancetype)sharedCalendar;

@end
