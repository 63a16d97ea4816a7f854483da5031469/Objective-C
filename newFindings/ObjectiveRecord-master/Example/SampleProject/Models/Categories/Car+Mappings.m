//
//  Car+Mappings.m
//  SampleProject
//
//  Created by Marin Usalj on 5/31/13.
//
//

#import "Car+Mappings.h"
#import "Person+Mappings.h"
#import "InsuranceCompany.h"

@implementation Car (Mappings)

+ (NSString *)primaryKey {
    return @"remoteID";
}

+ (NSDictionary *)mappings {
    return @{
        @"id": [self primaryKey],
        @"hp": @"horsePower",
        @"owner": @{
            @"class": [Person class]
        },
        @"insurance_id": @{
            @"key": @"insuranceCompany",
            @"class": [InsuranceCompany class]
        },
        @"insurance_company": @{
                @"key": @"insuranceCompany",
                @"class": [InsuranceCompany class]
                }

    };
}

@end
