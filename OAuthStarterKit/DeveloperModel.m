//
//  DeveloperModel.m
//

#import "DeveloperModel.h"

@implementation DeveloperModel

@synthesize firstName;
@synthesize lastName;
@synthesize city;
@synthesize province;
@synthesize company;
@synthesize pictureUrl;
@synthesize publicProfileUrl;

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
   if (self) {
        self.firstName = [dictionary objectForKey:@"firstName"];
        self.lastName = [dictionary objectForKey:@"lastName"];
        self.province= [dictionary objectForKey:@"province"];
        self.city= [dictionary objectForKey:@"city"];
        self.company = [dictionary objectForKey:@"company"];
        self.pictureUrl = [dictionary objectForKey:@"pictureUrl"];
        self.publicProfileUrl = [dictionary objectForKey:@"publicProfileUrl"];

    }
    
    return self;
}

- (void)dealloc {
   
    [super dealloc];
}
@end
